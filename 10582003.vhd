----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.02.2020 15:24:37
-- Design Name: 
-- Module Name: 10582003 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
----------------------------------------------------------------
--REGISTRO                                                    --
----------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register1 is
    generic (
        ADDR_DIM : integer := 8
    );
    Port ( in1 : in STD_LOGIC_VECTOR (ADDR_DIM-1 downto 0);
           rst : in STD_LOGIC;
           clk : in STD_LOGIC; 
           en : in STD_LOGIC;
           out1 : out STD_LOGIC_VECTOR (ADDR_DIM-1 downto 0)
           );
end register1;

architecture Behavioral of register1 is

begin
    process(clk, rst, en)
    begin
        if rst = '1' then
            out1 <= (others => '0');
        elsif en = '1' and rising_edge(clk) then
            out1 <= in1;
        end if;
    end process;

end Behavioral;
----------------------------------------------------------------
--ADDRESS_MAP                                                 --
----------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity address_map is
  generic(
    ADDR_DIM : integer := 8
  );
  Port (   addr_in : in STD_LOGIC_VECTOR (ADDR_DIM-1 downto 0);
           reg : in STD_LOGIC_VECTOR (ADDR_DIM-1 downto 0);
           addr_out : out STD_LOGIC_VECTOR (ADDR_DIM-1 downto 0));
end address_map;

architecture dataflow of address_map is
signal diff : STD_LOGIC_VECTOR(ADDR_DIM-1 downto 0);
begin
    diff <= STD_LOGIC_VECTOR(SIGNED(addr_in) - SIGNED(reg));
    with diff select
        addr_out <= "1---0001" when STD_LOGIC_VECTOR(TO_UNSIGNED(0, ADDR_DIM)),
                    "1---0010" when STD_LOGIC_VECTOR(TO_UNSIGNED(1, ADDR_DIM)),
                    "1---0100" when STD_LOGIC_VECTOR(TO_UNSIGNED(2, ADDR_DIM)),
                    "1---1000" when STD_LOGIC_VECTOR(TO_UNSIGNED(3, ADDR_DIM)),
                    "0-------" when others;
                       
end dataflow;
----------------------------------------------------------------
--OUTPUT LOGIC                                                --
----------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity output_logic1 is
    generic(
        ADDR_DIM : integer := 8;
        NWZ : integer := 8;
        DWZ : integer := 4;
        LCOD : integer := 3
    );
    Port ( out1 : out STD_LOGIC_VECTOR (ADDR_DIM-1 downto 0);
           addr_in : in STD_LOGIC_VECTOR (ADDR_DIM-1 downto 0);
           reg0 : in STD_LOGIC_VECTOR (ADDR_DIM-1 downto 0);
           reg1 : in STD_LOGIC_VECTOR (ADDR_DIM-1 downto 0);
           reg2 : in STD_LOGIC_VECTOR (ADDR_DIM-1 downto 0);
           reg3 : in STD_LOGIC_VECTOR (ADDR_DIM-1 downto 0);
           reg4 : in STD_LOGIC_VECTOR (ADDR_DIM-1 downto 0);
           reg5 : in STD_LOGIC_VECTOR (ADDR_DIM-1 downto 0);
           reg6 : in STD_LOGIC_VECTOR (ADDR_DIM-1 downto 0);
           reg7 : in STD_LOGIC_VECTOR (ADDR_DIM-1 downto 0)
           );
end output_logic1;

architecture mixed of output_logic1 is
signal addr_out0, addr_out1, addr_out2, addr_out3, addr_out4, addr_out5,addr_out6, addr_out7 : STD_LOGIC_VECTOR(ADDR_DIM-1 downto 0);
signal first_bits : STD_LOGIC_VECTOR(NWZ-1 downto 0);
signal wz_number : STD_LOGIC_VECTOR(ADDR_DIM-DWZ-2 downto 0);
signal first_part: STD_LOGIC_VECTOR(LCOD downto 0);

component address_map is
     generic(
        ADDR_DIM : integer := ADDR_DIM
     );
    Port ( addr_in : in STD_LOGIC_VECTOR (ADDR_DIM-1 downto 0);
           reg : in STD_LOGIC_VECTOR (ADDR_DIM-1 downto 0);
           addr_out : out STD_LOGIC_VECTOR (ADDR_DIM-1 downto 0)
           );
end component;

 
begin

    addrmap0 : address_map
    generic map (ADDR_DIM => ADDR_DIM)
    port map(addr_in => addr_in, reg => reg0, addr_out => addr_out0 );
    
    addrmap1 : address_map
    generic map (ADDR_DIM => ADDR_DIM)
    port map(addr_in => addr_in, reg => reg1, addr_out => addr_out1 );
    
    addrmap2 : address_map
    generic map (ADDR_DIM => ADDR_DIM)
    port map(addr_in => addr_in, reg => reg2, addr_out => addr_out2 );
    
    addrmap3 : address_map
    generic map (ADDR_DIM => ADDR_DIM)
    port map(addr_in => addr_in, reg => reg3, addr_out => addr_out3 );
    
    addrmap4 : address_map
    generic map (ADDR_DIM => ADDR_DIM)
    port map(addr_in => addr_in, reg => reg4, addr_out => addr_out4 );
    
    addrmap5 : address_map
    generic map (ADDR_DIM => ADDR_DIM)
    port map(addr_in => addr_in, reg => reg5, addr_out => addr_out5 );
    
    addrmap6 : address_map
    generic map (ADDR_DIM => ADDR_DIM)
    port map(addr_in => addr_in, reg => reg6, addr_out => addr_out6 );
    
    addrmap7 : address_map
    generic map (ADDR_DIM => ADDR_DIM)
    port map(addr_in => addr_in, reg => reg7, addr_out => addr_out7 );
    
    
    first_bits(0) <= addr_out0(ADDR_DIM-1);
    first_bits(1) <= addr_out1(ADDR_DIM-1);
    first_bits(2) <= addr_out2(ADDR_DIM-1);
    first_bits(3) <= addr_out3(ADDR_DIM-1);
    first_bits(4) <= addr_out4(ADDR_DIM-1);
    first_bits(5) <= addr_out5(ADDR_DIM-1);
    first_bits(6) <= addr_out6(ADDR_DIM-1);
    first_bits(7) <= addr_out7(ADDR_DIM-1);

    with first_bits select
            wz_number <= "000" when "00000001",
                         "001" when "00000010",
                         "010" when "00000100",
                         "011" when "00001000",
                         "100" when "00010000",
                         "101" when "00100000",
                         "110" when "01000000",
                         "111" when "10000000",
                         "---" when others;
    
    first_part <= '1' & wz_number;
    
    with first_bits select
        out1 <= first_part & addr_out0(ADDR_DIM-DWZ-1 downto 0) when "00000001", 
                first_part & addr_out1(ADDR_DIM-DWZ-1 downto 0) when "00000010",
                first_part & addr_out2(ADDR_DIM-DWZ-1 downto 0) when "00000100",
                first_part & addr_out3(ADDR_DIM-DWZ-1 downto 0) when "00001000",
                first_part & addr_out4(ADDR_DIM-DWZ-1 downto 0) when "00010000",
                first_part & addr_out5(ADDR_DIM-DWZ-1 downto 0) when "00100000",
                first_part & addr_out6(ADDR_DIM-DWZ-1 downto 0) when "01000000",
                first_part & addr_out7(ADDR_DIM-DWZ-1 downto 0) when "10000000",
                addr_in when others;


end mixed;
----------------------------------------------------------------
--FSM                                                         --
----------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity FSM is
  generic(
        ADDR_DIM : integer := 8;
        NWZ : integer := 8
    );
  Port (i_clk :         in      std_logic;
        i_start :       in      std_logic;
        i_rst :         in      std_logic;
        addr_out:       in      std_logic_vector(ADDR_DIM-1 downto 0);
        o_address :     out     std_logic_vector(15 downto 0);
        o_done :        out     std_logic;
        o_en :          out     std_logic;
        o_we :          out     std_logic;
        o_data :        out     std_logic_vector (ADDR_DIM-1 downto 0);
        enable_reg:     out     std_logic_vector (ADDR_DIM-1 downto 0);
        en_addr_in:     out     std_logic );
end FSM;

architecture Behavioral of FSM is
type state_type is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14);
signal next_state, current_state : state_type;
begin
state_reg : process(i_rst, i_clk)
    begin
        if i_rst='1' then
            current_state <= S0;
        elsif rising_edge(i_clk) then
            current_state <= next_state;
        end if;
    end process;
    
    FSM : process(current_state, i_start)
    begin
        case current_state is
            when S0 =>
                en_addr_in <= '-';
                enable_reg <= (others => '-');
                o_done <= '0';
                o_en <= '0';
                o_we <= '0';
                o_data <= (others => '-');
                o_address <= (others => '-');
                if i_start = '1' then
                    next_state <= S1;
                else 
                    next_state <= S0;
                end if;
            when S1 =>
                o_en <= '1';
                o_we <= '0';
                o_done <= '0';
                o_data <= (others => '-');
                o_address <= "0000000000000000";
                enable_reg <= (others => '-');
                en_addr_in <= '-';
                next_state <= S2;
            when S2 =>
                o_en <= '1';
                o_we <= '0';
                o_done <= '0';
                o_data <= (others => '-');
                o_address <= "0000000000000001";
                enable_reg <= STD_LOGIC_VECTOR(TO_UNSIGNED(1, NWZ));
                en_addr_in <= '-';
                next_state <= S3;
            when S3 =>
                o_en <= '1';
                o_we <= '0';
                o_done <= '0';
                o_data <= (others => '-'); 
                o_address <= "0000000000000010";
                enable_reg <= STD_LOGIC_VECTOR(TO_UNSIGNED(2, NWZ));
                en_addr_in <= '-';
                next_state <= S4;
            when S4 =>
                o_en <= '1';
                o_we <= '0';
                o_done <= '0';
                o_data <= (others => '-');
                o_address <= "0000000000000011";
                enable_reg <= STD_LOGIC_VECTOR(TO_UNSIGNED(4, NWZ));
                en_addr_in <= '-';
                next_state <= S5;
            when S5 =>
                o_en <= '1';
                o_we <= '0';
                o_done <= '0';
                o_data <= (others => '-'); 
                o_address <= "0000000000000100";
                enable_reg <= STD_LOGIC_VECTOR(TO_UNSIGNED(8, NWZ));
                en_addr_in <= '-';
                next_state <= S6;
            when S6 =>
                o_en <= '1';
                o_we <= '0';
                o_done <= '0';
                o_data <= (others => '-');
                o_address <= "0000000000000101";
                enable_reg <= STD_LOGIC_VECTOR(TO_UNSIGNED(16, NWZ));
                en_addr_in <= '-';
                next_state <= S7;
            when S7 =>
                o_en <= '1';
                o_we <= '0';
                o_done <= '0';
                o_data <= (others => '-');
                o_address <= "0000000000000110";
                enable_reg <= STD_LOGIC_VECTOR(TO_UNSIGNED(32, NWZ));
                en_addr_in <= '-';
                next_state <= S8;
            when S8 =>
                o_en <= '1';
                o_we <= '0';
                o_done <= '0';
                o_data <= (others => '-');
                o_address <= "0000000000000111";
                enable_reg <= STD_LOGIC_VECTOR(TO_UNSIGNED(64, NWZ));
                en_addr_in <= '-';
                next_state <= S9;
            when S9 =>
                o_en <= '1';
                o_we <= '0';
                o_done <= '0';
                o_data <= (others => '-');
                o_address <= "0000000000001000";
                enable_reg <= STD_LOGIC_VECTOR(TO_UNSIGNED(128, NWZ));
                en_addr_in <= '-';
                next_state <= S10;
            when S10 =>
                enable_reg <= STD_LOGIC_VECTOR(TO_UNSIGNED(0, NWZ));
                o_en <= '0';
                o_we <= '0';
                o_done <= '0';
                en_addr_in <= '1';
                o_address <= (others => '-');
                o_data <=(others => '-');
                next_state <= S11;
            when S11 =>
                enable_reg <= STD_LOGIC_VECTOR(TO_UNSIGNED(0, NWZ));
                o_en <= '1';
                o_we <= '1';
                o_done <= '0';
                en_addr_in <= '0';
                o_address <= "0000000000001001";
                o_data <= addr_out;
                next_state <= S12;
            when S12 =>
                enable_reg <= STD_LOGIC_VECTOR(TO_UNSIGNED(0, NWZ));
                o_en <= '1';
                o_we <= '1';
                o_done <= '1';
                en_addr_in <= '0';
                o_address <= "0000000000001001";
                o_data <= addr_out;
                next_state <= S13;
            when S13 =>
                enable_reg <= STD_LOGIC_VECTOR(TO_UNSIGNED(0, NWZ));
                en_addr_in <= '0';
                o_en <= '0';
                o_we <= '0';
                o_data <= (others => '-');
                o_address <= (others => '-');
                if i_start = '0' then
                    o_done <= '0';
                    next_state <= S14;
                else
                    o_done <= '1';
                    next_state <= S13;
                end if;
            when S14 =>
                o_en <= '1';
                o_we <= '0';
                o_done <= '0';
                o_data <= (others => '-');
                o_address <= "0000000000001000";
                enable_reg <= STD_LOGIC_VECTOR(TO_UNSIGNED(0, NWZ));
                en_addr_in <= '0';
                if i_start = '0' then
                    next_state <= S14;
                else
                    next_state <= S10;
                end if;
        end case;     
    end process;


end Behavioral;
----------------------------------------------------------------
--PROJECT_RETI_LOGICHE                                        --
----------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity project_reti_logiche is
    generic(
        ADDR_DIM : integer := 8;
        NWZ : integer := 8;
        DWZ : integer := 4;
        LCOD : integer := 3
    );
    port (
        i_clk :         in      std_logic;
        i_start :       in      std_logic;
        i_rst :         in      std_logic;
        i_data :        in      std_logic_vector(ADDR_DIM-1 downto 0);
        o_address :     out     std_logic_vector(15 downto 0);
        o_done :        out     std_logic;
        o_en :          out     std_logic;
        o_we :          out     std_logic;
        o_data :        out     std_logic_vector (ADDR_DIM-1 downto 0)
    );
end project_reti_logiche;


architecture Structural of project_reti_logiche is

    signal addr_in, addr_out, ad0, ad1, ad2, ad3, ad4, ad5, ad6, ad7: STD_LOGIC_VECTOR(ADDR_DIM-1 downto 0);
    signal en_addr_in : STD_LOGIC; 
    signal enable_reg : STD_LOGIC_VECTOR(NWZ-1 downto 0);
    
   component FSM is 
       generic(
        ADDR_DIM : integer := ADDR_DIM;
        NWZ : integer := NWZ
    );
  Port (i_clk :         in      std_logic;
        i_start :       in      std_logic;
        i_rst :         in      std_logic;
        addr_out:       in      std_logic_vector(ADDR_DIM-1 downto 0);
        o_address :     out     std_logic_vector(15 downto 0);
        o_done :        out     std_logic;
        o_en :          out     std_logic;
        o_we :          out     std_logic;
        o_data :        out     std_logic_vector (ADDR_DIM-1 downto 0);
        enable_reg:     out     std_logic_vector (ADDR_DIM-1 downto 0);
        en_addr_in:     out     std_logic );
    end component;
    
    
    component register1 is
        generic (
        ADDR_DIM : integer := ADDR_DIM
        );
        Port ( in1 : in STD_LOGIC_VECTOR (ADDR_DIM-1 downto 0);
               rst : in STD_LOGIC;
               clk : in STD_LOGIC; 
               en : in STD_LOGIC;
               out1 : out STD_LOGIC_VECTOR (ADDR_DIM-1 downto 0)
           );
       end component;
       
     component output_logic1 is
        generic(
        ADDR_DIM : integer := ADDR_DIM;
        NWZ : integer := NWZ;
        DWZ : integer := DWZ;
        LCOD : integer := LCOD
        );
        Port (  out1 : out STD_LOGIC_VECTOR (ADDR_DIM-1 downto 0);
                addr_in : in STD_LOGIC_VECTOR (ADDR_DIM-1 downto 0);
                reg0 : in STD_LOGIC_VECTOR (ADDR_DIM-1 downto 0);
                reg1 : in STD_LOGIC_VECTOR (ADDR_DIM-1 downto 0);
                reg2 : in STD_LOGIC_VECTOR (ADDR_DIM-1 downto 0);
                reg3 : in STD_LOGIC_VECTOR (ADDR_DIM-1 downto 0);
                reg4 : in STD_LOGIC_VECTOR (ADDR_DIM-1 downto 0);
                reg5 : in STD_LOGIC_VECTOR (ADDR_DIM-1 downto 0);
                reg6 : in STD_LOGIC_VECTOR (ADDR_DIM-1 downto 0);
                reg7 : in STD_LOGIC_VECTOR (ADDR_DIM-1 downto 0));
        end component;
    
    
begin
    
    reg0 : register1
    generic map(ADDR_DIM => ADDR_DIM)
    port map(in1 => i_data, rst => i_rst, clk => i_clk, en => enable_reg(0), out1 => ad0);

    reg1 : register1
    generic map(ADDR_DIM => ADDR_DIM)
    port map(in1 => i_data, rst => i_rst, clk => i_clk, en => enable_reg(1), out1 => ad1);
    
    reg2 : register1
    generic map(ADDR_DIM => ADDR_DIM)
    port map(in1 => i_data, rst => i_rst, clk => i_clk, en => enable_reg(2), out1 => ad2);
    
    reg3 : register1
    generic map(ADDR_DIM => ADDR_DIM)
    port map(in1 => i_data, rst => i_rst, clk => i_clk, en => enable_reg(3), out1 => ad3);
    
    reg4 : register1
    generic map(ADDR_DIM => ADDR_DIM)
    port map(in1 => i_data, rst => i_rst, clk => i_clk, en => enable_reg(4), out1 => ad4);
    
    reg5 : register1
    generic map(ADDR_DIM => ADDR_DIM)
    port map(in1 => i_data, rst => i_rst, clk => i_clk, en => enable_reg(5), out1 => ad5);
    
    reg6 : register1
    generic map(ADDR_DIM => ADDR_DIM)
    port map(in1 => i_data, rst => i_rst, clk => i_clk, en => enable_reg(6), out1 => ad6);
    
    reg7 : register1
    generic map(ADDR_DIM => ADDR_DIM)
    port map(in1 => i_data, rst => i_rst, clk => i_clk, en => enable_reg(7), out1 => ad7);
    
    reg_in : register1 
    generic map(ADDR_DIM => ADDR_DIM)
    port map(in1 => i_data, rst => i_rst, clk => i_clk, en => en_addr_in, out1 => addr_in);
    
    out_log : output_logic1
    generic map(ADDR_DIM => ADDR_DIM, NWZ => NWZ, DWZ => DWZ, LCOD => LCOD)
    port map(out1 => addr_out, addr_in => addr_in, reg0 => ad0, 
            reg1 => ad1, reg2 => ad2, reg3 => ad3, reg4 => ad4,
            reg5 => ad5, reg6 => ad6, reg7 => ad7);
            
    FSM1: FSM
    generic map(ADDR_DIM => ADDR_DIM, NWZ => NWZ)
    port map(i_clk => i_clk, i_start=>i_start, i_rst => i_rst,
             addr_out => addr_out, o_address => o_address, o_done => o_done, 
             o_en => o_en, o_we => o_we, o_data => o_data, enable_reg => enable_reg,
              en_addr_in => en_addr_in);
    
            

    
end Structural;