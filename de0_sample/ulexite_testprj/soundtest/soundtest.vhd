-- ===================================================================
-- TITLE : Sound test (for BU9480F)
--
--     DESIGN : S.OSAFUNE (J-7SYSTEM Works)
--     DATE   : 2013/08/01 -> 2013/08/02
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

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity soundtest is
	port(
		reset			: in  std_logic;
		clk_128fs		: in  std_logic;	-- 5.6448MHz(44.1kHz) 

		key_l			: in  std_logic;	-- 左チャネルから441Hzの矩形波 
		key_r			: in  std_logic;	-- 右チャネルから882Hzの正弦波 

		dac_bclk		: out std_logic;
		dac_lrck		: out std_logic;
		dac_data		: out std_logic
	);
end soundtest;

architecture RTL of soundtest is
	signal key_l_in_reg		: std_logic_vector(1 downto 0);
	signal key_r_in_reg		: std_logic_vector(1 downto 0);
	signal volume_l_reg		: std_logic_vector(14 downto 0);
	signal volume_r_reg		: std_logic_vector(14 downto 0);

	signal pcmout_l_sig		: std_logic_vector(15 downto 0);
	signal pcmout_r_sig		: std_logic_vector(15 downto 0);
	signal fs_sig			: std_logic;
	signal fs_old_reg		: std_logic;

	signal wavecount		: integer range 0 to 49;
	signal sqrtoggle_reg	: std_logic;
	signal wavesqr_reg		: std_logic_vector(15 downto 0);
	signal wavesin_reg		: std_logic_vector(15 downto 0);

	type DEF_ROM is array(0 to 49) of std_logic_vector(15 downto 0);
	constant WAVEROM : DEF_ROM := (
		X"0000",X"100A",X"1FD4",X"2F1E",X"3DA9",X"4B3B",X"579E",X"629F",
		X"6C12",X"73D0",X"79BB",X"7DBA",X"7FBE",X"7FBE",X"7DBA",X"79BB",
		X"73D0",X"6C12",X"629F",X"579E",X"4B3B",X"3DA9",X"2F1E",X"1FD4",
		X"100A",X"0000",X"EFF6",X"E02C",X"D0E2",X"C257",X"B4C5",X"A862",
		X"9D61",X"93EE",X"8C30",X"8645",X"8246",X"8042",X"8042",X"8246",
		X"8645",X"8C30",X"93EE",X"9D61",X"A862",X"B4C5",X"C257",X"D0E2",
		X"E02C",X"EFF6"
	);

	component loreley_dacif_bu9480f_ds
	generic(
		RESET_LEVEL		: std_logic := '1';
		CLOCK_EDGE		: std_logic := '1'
	);
	port(
		reset		: in  std_logic;
		clk			: in  std_logic;
		clk_ena		: in  std_logic := '1';	-- Pulse width 1clock time (128fs)
		fs_timing	: out std_logic;

		pcmdata_l	: in  std_logic_vector(15 downto 0);	-- 符号付き 
		pcmdata_r	: in  std_logic_vector(15 downto 0);
		volume_l	: in  std_logic_vector(14 downto 0);	-- 符号なし 
		volume_r	: in  std_logic_vector(14 downto 0);

		dac_bclk	: out std_logic;
		dac_lrck	: out std_logic;
		dac_data	: out std_logic;
		aud_l		: out std_logic;
		aud_r		: out std_logic;
		spdif		: out std_logic
	);
	end component;

begin

	process (clk_128fs, reset) begin
		if (reset = '1') then
			fs_old_reg <= '0';
			wavecount <= 0;
			sqrtoggle_reg <= '0';
			wavesqr_reg <= X"0000";
			wavesin_reg <= X"0000";

		elsif (clk_128fs'event and clk_128fs = '1') then
			fs_old_reg <= fs_sig;

			if (fs_sig = '1' and fs_old_reg = '0') then
				if (wavecount = 49) then
					wavecount <= 0;
					sqrtoggle_reg <= not sqrtoggle_reg;
				else
					wavecount <= wavecount + 1;
				end if;

				if (sqrtoggle_reg = '0') then
					wavesqr_reg <= X"5A82";
				else
					wavesqr_reg <= X"A57E";
				end if;

				wavesin_reg <= WAVEROM(wavecount);
			end if;

		end if;
	end process;



	process (clk_128fs, reset) begin
		if (reset = '1') then
			key_l_in_reg <= "00";
			key_r_in_reg <= "00";
			volume_l_reg <= (others=>'0');
			volume_r_reg <= (others=>'0');

		elsif (clk_128fs'event and clk_128fs = '1') then
			key_l_in_reg <= key_l_in_reg(0) & key_l;
			key_r_in_reg <= key_r_in_reg(0) & key_r;

			if (key_l_in_reg(1) = '1') then
				volume_l_reg <= (14=>'1',others=>'0');
			else
				volume_l_reg <= (others=>'0');
			end if;

			if (key_r_in_reg(1) = '1') then
				volume_r_reg <= (14=>'1',others=>'0');
			else
				volume_r_reg <= (others=>'0');
			end if;

		end if;
	end process;



	U_dac : loreley_dacif_bu9480f_ds
	port map (
		reset			=> reset,
		clk				=> clk_128fs,
		clk_ena			=> '1',
		fs_timing		=> fs_sig,

		pcmdata_l		=> wavesqr_reg,
		pcmdata_r		=> wavesin_reg,
		volume_l		=> volume_l_reg,
		volume_r		=> volume_r_reg,

		dac_bclk		=> dac_bclk,
		dac_lrck		=> dac_lrck,
		dac_data		=> dac_data
	);


end RTL;
