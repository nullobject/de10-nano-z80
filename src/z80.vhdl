library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity z80 is
  port(
    clk : in std_logic;
    led : out std_logic_vector(7 downto 0)
  );
end z80;

architecture arch of z80 is
  signal cpu_mreq_n : std_logic;
  signal cpu_wr_n : std_logic;
  signal cpu_addr	: std_logic_vector(15 downto 0);
  signal cpu_di	: std_logic_vector(7 downto 0);
  signal cpu_do	: std_logic_vector(7 downto 0);
begin
  cpu : entity work.T80s
  generic map(Mode => 0, T2Write => 1, IOWait => 1)
  port map(
    RESET_n => '1',
    CLK_n   => clk,
    WAIT_n  => '1',
    INT_n   => '1',
    NMI_n   => '1',
    BUSRQ_n => '1',
    M1_n    => open,
    MREQ_n  => cpu_mreq_n,
    IORQ_n  => open,
    RD_n    => open,
    WR_n    => cpu_wr_n,
    RFSH_n  => open,
    HALT_n  => open,
    BUSAK_n => open,
    A       => cpu_addr,
    DI      => cpu_di,
    DO      => cpu_do
  );

  led <= cpu_addr(7 downto 0);
end arch;
