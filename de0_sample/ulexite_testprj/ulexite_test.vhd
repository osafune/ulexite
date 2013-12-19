-- ===================================================================
-- TITLE : ULEXITE PCB TEST
--
--     DESIGN : S.OSAFUNE (J-7SYSTEM Works)
--     DATE   : 2013/07/31 -> 2013/08/02
--            : 2013/08/02 (FIXED)
--
-- ===================================================================
-- *******************************************************************
--   Copyright (C) 2010-2013, J-7SYSTEM Works.  All rights Reserved.
--
-- * This module is a free sourcecode and there is NO WARRANTY.
-- * No restriction on use. You can use, modify and redistribute it
--   for personal, non-profit or commercial products UNDER YOUR
--   RESPONSIBILITY.
-- * Redistributions of source code must retain the above copyright
--   notice.
-- *******************************************************************

-- ULEXITE PCB のテストを行う 
--	ULEXITEボードをDE0にセットしコンフィグを行うとカラーバーを表示する 
--		SW9   : バックライトのON/OFF 
--		SW7-0 : バックライトの輝度を設定(0:最大輝度～255:最低輝度) 
--		BTN2  : 左チャネルから441Hzの矩形波を発音 
--		BTN1  : 右チャネルから882Hzの正弦波を発音 
--  	BTN0  : リセット 


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity ulexite_test is
	port(
		CLOCK_50		: in  std_logic;	-- 50MHz in

		LCD_BLON		: out std_logic;
		LCD_BLDIMMER	: out std_logic;
		LCD_DISP		: out std_logic;
		LCD_DE			: out std_logic;
		LCD_DCK			: out std_logic;
		LCD_R			: out std_logic_vector(7 downto 0);
		LCD_G			: out std_logic_vector(7 downto 0);
		LCD_B			: out std_logic_vector(7 downto 0);
		DAC_BCLK		: out std_logic;
		DAC_LRCK		: out std_logic;
		DAC_SDAT		: out std_logic;

		SW				: in  std_logic_vector(9 downto 0);
		BUTTON			: in  std_logic_vector(2 downto 0);		-- '0'でON 
		LEDG			: out std_logic_vector(9 downto 0)
	);
end ulexite_test;

architecture RTL of ulexite_test is

	component pll
	PORT
	(
		areset		: IN STD_LOGIC  := '0';
		inclk0		: IN STD_LOGIC  := '0';
		c0		: OUT STD_LOGIC ;
		c1		: OUT STD_LOGIC ;
		locked		: OUT STD_LOGIC 
	);
	end component;

	component vga_syncgen
	generic (
		H_TOTAL		: integer := 525;	-- ATM0430D5(480x272) / 9.0MHz
		H_SYNC		: integer := 40;
		H_BACKP		: integer := 0;
		H_ACTIVE	: integer := 480;
		V_TOTAL		: integer := 288;
		V_SYNC		: integer := 3;
		V_BACKP		: integer := 0;
		V_ACTIVE	: integer := 272
	);
	port (
		reset		: in  std_logic;		-- active high
		video_clk	: in  std_logic;		-- typ 25.175MHz

		scan_ena	: in  std_logic;		-- framebuff scan enable
		dither_ena	: in  std_logic;		-- dither enable

		framestart	: out std_logic;
		linestart	: out std_logic;
		dither		: out std_logic;		-- RGB444 dither signal
		pixelena	: out std_logic;		-- pixel readout active

		hsync		: out std_logic;
		vsync		: out std_logic;
		hblank		: out std_logic;
		vblank		: out std_logic;
		cb_rout		: out std_logic_vector(7 downto 0);		-- colorbar pixeldata
		cb_gout		: out std_logic_vector(7 downto 0);
		cb_bout		: out std_logic_vector(7 downto 0)
	);
	end component;

	component soundtest
	port(
		reset			: in  std_logic;
		clk_128fs		: in  std_logic;	-- 5.6448MHz(44.1kHz) 

		key_l			: in  std_logic;	-- 左チャネルから441Hzの矩形波 
		key_r			: in  std_logic;	-- 右チャネルから882Hzの正弦波 

		dac_bclk		: out std_logic;
		dac_lrck		: out std_logic;
		dac_data		: out std_logic
	);
	end component;

	signal pllreset_sig		: std_logic;
	signal key_l_sig		: std_logic;
	signal key_r_sig		: std_logic;
	signal sw_blon_sig		: std_logic;
	signal sw_dimmer_sig	: std_logic_vector(7 downto 0);

	signal clk128fs_sig		: std_logic;
	signal clk_video_sig	: std_logic;
	signal locked_sig		: std_logic;
	signal reset_sig		: std_logic;

	signal pwmcount			: std_logic_vector(7 downto 0);
	signal pwmref_reg		: std_logic_vector(7 downto 0);
	signal pwmout_reg		: std_logic;
	signal blon_reg			: std_logic;

	signal hblank_sig		: std_logic;
	signal vblank_sig		: std_logic;

begin

	pllreset_sig <= not BUTTON(0);
	key_l_sig <= not BUTTON(2);
	key_r_sig <= not BUTTON(1);

	sw_blon_sig <= SW(9);
	sw_dimmer_sig <= SW(7 downto 0);

	pll_inst : pll
	PORT MAP (
		areset	 => pllreset_sig,
		inclk0	 => CLOCK_50,
		c0	 	 => clk128fs_sig,	-- 5.6448MHz (128fs)
		c1	 	 => clk_video_sig,	-- 9.0MHz
		locked	 => locked_sig
	);

	reset_sig <= not locked_sig;

	LEDG <= (others=>locked_sig);



	process (CLOCK_50, reset_sig) begin
		if (reset_sig='1') then
			pwmcount <= X"00";
			pwmref_reg <= X"00";
			pwmout_reg <= '0';
			blon_reg <= '0';

		elsif(CLOCK_50'event and CLOCK_50='1') then
			pwmcount <= pwmcount + 1;

			if (pwmcount = pwmref_reg) then
				pwmout_reg <= '0';
			elsif (pwmcount = 0) then
				pwmout_reg <= '1';
			end if;

			blon_reg <= sw_blon_sig;
			pwmref_reg <= sw_dimmer_sig;

		end if;
	end process;

	LCD_BLON <= blon_reg;
	LCD_BLDIMMER <= pwmout_reg;



	U0 : vga_syncgen
	port map (
		video_clk	=> clk_video_sig,
		reset		=> reset_sig,
		scan_ena	=> '0',
		dither_ena	=> '0',

		hblank		=> hblank_sig,
		vblank		=> vblank_sig,
		cb_rout		=> LCD_R,
		cb_gout		=> LCD_G,
		cb_bout		=> LCD_B
	);

	LCD_DISP <= locked_sig;
	LCD_DE <= (not hblank_sig) and (not vblank_sig);
	LCD_DCK <= clk_video_sig;



	U1 : soundtest
	port map (
		reset		=> reset_sig,
		clk_128fs	=> clk128fs_sig,
		key_l		=> key_l_sig,
		key_r		=> key_r_sig,

		dac_bclk	=> DAC_BCLK,
		dac_lrck	=> DAC_LRCK,
		dac_data	=> DAC_SDAT
	);


end RTL;
