public class Numbers {

    private enum Bandera {

		// Entero decimal a binario
		DECIMAL_A_BINARIO("e"),
		// Cadena binaria a decimal
		BINARIO_A_DECIMAL("b");
		
		private String nombre;

		private Bandera(String nombre) {
			this.nombre = nombre;
		}

		public static Bandera getBandera(String nombre) {
			for (Bandera b : Bandera.values()) {
				if (b.nombre.equals(nombre)) {
					return b;
				}
			}
			throw new IllegalArgumentException("Bandera inválida");
		}
    }
    
    public static void main(String[] args) {
		Bandera b = Bandera.getBandera(args[0]);
		switch (b) {
		case DECIMAL_A_BINARIO:
			manejaEntero(args[1]);
			break;
		case BINARIO_A_DECIMAL:
			manejaBinario(args[1]);
			break;
		default:
			break;
		}
    }

    private static void manejaEntero(String entero) {
		int n = Integer.parseInt(entero);
		String numeroBinario = Integer.toBinaryString(n);
		// Cambiar longitud
		String bits32 = String.format("%8s", numeroBinario).replace(" ", "0");
		System.out.println("Decimal: " + n);
		System.out.println("Binario (complemento a 2): " + bits32);
    }

    private static void manejaBinario(String bin) {
		int n = Integer.parseInt(bin,2);
		// if (bin.charAt(0) == '1'){ // checa complemento a 2
		//     n -= 1 << bin.length();
		// }
		System.out.println("Binario: " + bin);
		System.out.println("Decimal: "+ n);
    }
}
