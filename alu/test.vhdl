library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end testbench;

architecture sim of testbench is
    signal A, B, Cin: std_logic := '0';
    signal Sum, Cout: std_logic;

    -- Instanciación del full adder
    component full_adder1
        Port (
            A: in std_logic;
            B: in std_logic;
            Cin: in std_logic;
            Sum: out std_logic;
            Cout: out std_logic
        );
    end component;

begin
    uut: full_adder1 port map (A, B, Cin, Sum, Cout);

    -- Generación de señales de prueba
    process
    begin
        -- Prueba 1
        A <= '0'; B <= '0'; Cin <= '0'; wait for 10 ns;
        assert (Sum = '0' and Cout = '0') report "Error en prueba 1" severity error;

        -- Prueba 2
        A <= '0'; B <= '1'; Cin <= '0'; wait for 10 ns;
        assert (Sum = '1' and Cout = '0') report "Error en prueba 2" severity error;

        -- Agrega más pruebas según sea necesario
        wait;
    end process;
end sim;
