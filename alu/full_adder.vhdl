library ieee;
use ieee.std_logic_1164.all;

-- Entradas y salidas
entity full_adder1 is
    Port (
        A      : in  std_logic; -- Entrada A
        B      : in  std_logic; -- Entrada B
        Cin    : in  std_logic; -- Acarreo de entrada
        Sum    : out std_logic; -- Suma 
        Cout   : out std_logic  -- Acarreo de salida
    );
end full_adder1;

-- Operacion realizada
architecture Operacion1 of full_adder1 is
begin
    process(A, B, Cin)
    begin
        Sum <= A XOR B XOR Cin; -- Suma de los bits de entrada con el acarreo de entrada
        Cout <= (Cin AND A ) OR ( (Cin XOR A) AND B ); -- Generacion del acarreo de salida
    end process;
end Operacion1;