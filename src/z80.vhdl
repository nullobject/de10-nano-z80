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
  -- address bus
  signal cpu_addr	: std_logic_vector(15 downto 0);

  -- data bus
  signal cpu_di	: std_logic_vector(7 downto 0);
  signal cpu_do	: std_logic_vector(7 downto 0);

  -- i/o request: the address bus holds a valid address for an i/o read or
  -- write operation
  signal cpu_ioreq_n : std_logic;

  -- memory request: the address bus holds a valid address for a memory read or
  -- write operation
  signal cpu_mreq_n : std_logic;

  -- read: ready to read data from the data bus
  signal cpu_rd_n : std_logic;

  -- write: the data bus contains a byte to write somewhere
  signal cpu_wr_n : std_logic;
begin
  cpu : entity work.T80s
  generic map(Mode => 0, T2Write => 1, IOWait => 1)
  port map(
    RESET_n => '1',
    CLK_n   => not clk,
    WAIT_n  => '1',
    INT_n   => '1',
    NMI_n   => '1',
    BUSRQ_n => '1',
    M1_n    => open,
    MREQ_n  => cpu_mreq_n,
    IORQ_n  => cpu_ioreq_n,
    RD_n    => cpu_rd_n,
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
