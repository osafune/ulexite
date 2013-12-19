-- cineraria_core_nios2_fast_custom_instruction_master_multi_slave_translator1.vhd

-- Generated using ACDS version 13.0sp1 232 at 2013.10.15.04:24:50

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cineraria_core_nios2_fast_custom_instruction_master_multi_slave_translator1 is
	generic (
		N_WIDTH          : integer := 3;
		USE_DONE         : integer := 1;
		NUM_FIXED_CYCLES : integer := 0
	);
	port (
		ci_slave_dataa     : in  std_logic_vector(31 downto 0) := (others => '0'); --  ci_slave.dataa
		ci_slave_datab     : in  std_logic_vector(31 downto 0) := (others => '0'); --          .datab
		ci_slave_result    : out std_logic_vector(31 downto 0);                    --          .result
		ci_slave_n         : in  std_logic_vector(7 downto 0)  := (others => '0'); --          .n
		ci_slave_readra    : in  std_logic                     := '0';             --          .readra
		ci_slave_readrb    : in  std_logic                     := '0';             --          .readrb
		ci_slave_writerc   : in  std_logic                     := '0';             --          .writerc
		ci_slave_a         : in  std_logic_vector(4 downto 0)  := (others => '0'); --          .a
		ci_slave_b         : in  std_logic_vector(4 downto 0)  := (others => '0'); --          .b
		ci_slave_c         : in  std_logic_vector(4 downto 0)  := (others => '0'); --          .c
		ci_slave_ipending  : in  std_logic_vector(31 downto 0) := (others => '0'); --          .ipending
		ci_slave_estatus   : in  std_logic                     := '0';             --          .estatus
		ci_slave_clk       : in  std_logic                     := '0';             --          .clk
		ci_slave_clken     : in  std_logic                     := '0';             --          .clk_en
		ci_slave_reset     : in  std_logic                     := '0';             --          .reset
		ci_slave_start     : in  std_logic                     := '0';             --          .start
		ci_slave_done      : out std_logic;                                        --          .done
		ci_master_dataa    : out std_logic_vector(31 downto 0);                    -- ci_master.dataa
		ci_master_datab    : out std_logic_vector(31 downto 0);                    --          .datab
		ci_master_result   : in  std_logic_vector(31 downto 0) := (others => '0'); --          .result
		ci_master_n        : out std_logic_vector(2 downto 0);                     --          .n
		ci_master_clk      : out std_logic;                                        --          .clk
		ci_master_clken    : out std_logic;                                        --          .clk_en
		ci_master_reset    : out std_logic;                                        --          .reset
		ci_master_start    : out std_logic;                                        --          .start
		ci_master_done     : in  std_logic                     := '0';             --          .done
		ci_master_a        : out std_logic_vector(4 downto 0);
		ci_master_b        : out std_logic_vector(4 downto 0);
		ci_master_c        : out std_logic_vector(4 downto 0);
		ci_master_estatus  : out std_logic;
		ci_master_ipending : out std_logic_vector(31 downto 0);
		ci_master_readra   : out std_logic;
		ci_master_readrb   : out std_logic;
		ci_master_writerc  : out std_logic
	);
end entity cineraria_core_nios2_fast_custom_instruction_master_multi_slave_translator1;

architecture rtl of cineraria_core_nios2_fast_custom_instruction_master_multi_slave_translator1 is
	component altera_customins_slave_translator is
		generic (
			N_WIDTH          : integer := 8;
			USE_DONE         : integer := 1;
			NUM_FIXED_CYCLES : integer := 2
		);
		port (
			ci_slave_dataa     : in  std_logic_vector(31 downto 0) := (others => 'X'); -- dataa
			ci_slave_datab     : in  std_logic_vector(31 downto 0) := (others => 'X'); -- datab
			ci_slave_result    : out std_logic_vector(31 downto 0);                    -- result
			ci_slave_n         : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- n
			ci_slave_readra    : in  std_logic                     := 'X';             -- readra
			ci_slave_readrb    : in  std_logic                     := 'X';             -- readrb
			ci_slave_writerc   : in  std_logic                     := 'X';             -- writerc
			ci_slave_a         : in  std_logic_vector(4 downto 0)  := (others => 'X'); -- a
			ci_slave_b         : in  std_logic_vector(4 downto 0)  := (others => 'X'); -- b
			ci_slave_c         : in  std_logic_vector(4 downto 0)  := (others => 'X'); -- c
			ci_slave_ipending  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- ipending
			ci_slave_estatus   : in  std_logic                     := 'X';             -- estatus
			ci_slave_clk       : in  std_logic                     := 'X';             -- clk
			ci_slave_clken     : in  std_logic                     := 'X';             -- clk_en
			ci_slave_reset     : in  std_logic                     := 'X';             -- reset
			ci_slave_start     : in  std_logic                     := 'X';             -- start
			ci_slave_done      : out std_logic;                                        -- done
			ci_master_dataa    : out std_logic_vector(31 downto 0);                    -- dataa
			ci_master_datab    : out std_logic_vector(31 downto 0);                    -- datab
			ci_master_result   : in  std_logic_vector(31 downto 0) := (others => 'X'); -- result
			ci_master_n        : out std_logic_vector(2 downto 0);                     -- n
			ci_master_clk      : out std_logic;                                        -- clk
			ci_master_clken    : out std_logic;                                        -- clk_en
			ci_master_reset    : out std_logic;                                        -- reset
			ci_master_start    : out std_logic;                                        -- start
			ci_master_done     : in  std_logic                     := 'X';             -- done
			ci_master_readra   : out std_logic;                                        -- readra
			ci_master_readrb   : out std_logic;                                        -- readrb
			ci_master_writerc  : out std_logic;                                        -- writerc
			ci_master_a        : out std_logic_vector(4 downto 0);                     -- a
			ci_master_b        : out std_logic_vector(4 downto 0);                     -- b
			ci_master_c        : out std_logic_vector(4 downto 0);                     -- c
			ci_master_ipending : out std_logic_vector(31 downto 0);                    -- ipending
			ci_master_estatus  : out std_logic                                         -- estatus
		);
	end component altera_customins_slave_translator;

begin

	nios2_fast_custom_instruction_master_multi_slave_translator1 : component altera_customins_slave_translator
		generic map (
			N_WIDTH          => N_WIDTH,
			USE_DONE         => USE_DONE,
			NUM_FIXED_CYCLES => NUM_FIXED_CYCLES
		)
		port map (
			ci_slave_dataa     => ci_slave_dataa,    --  ci_slave.dataa
			ci_slave_datab     => ci_slave_datab,    --          .datab
			ci_slave_result    => ci_slave_result,   --          .result
			ci_slave_n         => ci_slave_n,        --          .n
			ci_slave_readra    => ci_slave_readra,   --          .readra
			ci_slave_readrb    => ci_slave_readrb,   --          .readrb
			ci_slave_writerc   => ci_slave_writerc,  --          .writerc
			ci_slave_a         => ci_slave_a,        --          .a
			ci_slave_b         => ci_slave_b,        --          .b
			ci_slave_c         => ci_slave_c,        --          .c
			ci_slave_ipending  => ci_slave_ipending, --          .ipending
			ci_slave_estatus   => ci_slave_estatus,  --          .estatus
			ci_slave_clk       => ci_slave_clk,      --          .clk
			ci_slave_clken     => ci_slave_clken,    --          .clk_en
			ci_slave_reset     => ci_slave_reset,    --          .reset
			ci_slave_start     => ci_slave_start,    --          .start
			ci_slave_done      => ci_slave_done,     --          .done
			ci_master_dataa    => ci_master_dataa,   -- ci_master.dataa
			ci_master_datab    => ci_master_datab,   --          .datab
			ci_master_result   => ci_master_result,  --          .result
			ci_master_n        => ci_master_n,       --          .n
			ci_master_clk      => ci_master_clk,     --          .clk
			ci_master_clken    => ci_master_clken,   --          .clk_en
			ci_master_reset    => ci_master_reset,   --          .reset
			ci_master_start    => ci_master_start,   --          .start
			ci_master_done     => ci_master_done,    --          .done
			ci_master_readra   => open,              -- (terminated)
			ci_master_readrb   => open,              -- (terminated)
			ci_master_writerc  => open,              -- (terminated)
			ci_master_a        => open,              -- (terminated)
			ci_master_b        => open,              -- (terminated)
			ci_master_c        => open,              -- (terminated)
			ci_master_ipending => open,              -- (terminated)
			ci_master_estatus  => open               -- (terminated)
		);

end architecture rtl; -- of cineraria_core_nios2_fast_custom_instruction_master_multi_slave_translator1
