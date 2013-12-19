-- ===================================================================
-- TITLE : Backlight Contoroller (for FAN5333B)
--
--     DESIGN : S.OSAFUNE (J-7SYSTEM Works)
--     DATE   : 2013/07/31 -> 2013/07/31
--            : 2013/07/31 (FIXED)
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

entity backlight_control is
	port(
	--==== Avalonバス信号線 ==========================================
		reset			: in  std_logic;
		clk				: in  std_logic;	-- 40MHz時に約156kHzの周期 

		read			: in  std_logic;
		readdata		: out std_logic_vector(31 downto 0);

		write			: in  std_logic;
		writedata		: in  std_logic_vector(31 downto 0);

	--==== ユーザーロジック信号線 ====================================

		backlight_on	: out std_logic;	-- '1'でバックライト点灯 
		backlight_pwm	: out std_logic		-- 0に近いほど明るい 
	);
end backlight_control;

architecture RTL of backlight_control is
	signal pwmcount		: std_logic_vector(7 downto 0);
	signal pwmref_reg	: std_logic_vector(7 downto 0);
	signal pwmout_reg	: std_logic;
	signal blon_reg		: std_logic;

begin

	readdata(31 downto 9) <= (others=>'0');
	readdata(8) <= blon_reg;
	readdata(7 downto 0) <= pwmref_reg;

	backlight_on  <= blon_reg;
	backlight_pwm <= pwmout_reg;

	process (clk,reset) begin
		if (reset='1') then
			pwmcount <= X"00";
			pwmref_reg <= X"00";
			pwmout_reg <= '0';
			blon_reg <= '0';

		elsif(clk'event and clk='1') then
			pwmcount <= pwmcount + 1;

			if (pwmcount = pwmref_reg) then
				pwmout_reg <= '0';
			elsif (pwmcount = 0) then
				pwmout_reg <= '1';
			end if;

			if (write = '1') then
				blon_reg <= writedata(8);
				pwmref_reg <= writedata(7 downto 0);
			end if;

		end if;
	end process;


end RTL;
