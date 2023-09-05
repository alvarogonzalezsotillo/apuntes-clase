package pruebas;

public class RectanguladorAcabado {

	/**
	 * Calcula el numero de rectangulos distintos que se pueden
	 * formar con varios elementos. Se considera que el rectangulo
	 * 5x7 y el rectangulo 7x5 son iguales. No se considera rectangulos
	 * a los que tienen lado 1.
	 * 
	 * @param i numero de elementos
	 * @return el numero de rectangulos diferentes que se pueden
	 *         formar con este numero de elementos
	 */
	public static int rectangulosDiferentes(long i) {
		if( i <= 0 ){
			throw new IllegalArgumentException();
		}
		int ret = 0;
		for (long j = 2; j <= Math.sqrt(i); j++) {
			if( i%j == 0 ){
				System.out.println( i + " = " + j + "*" + (i/j) );
				ret ++;
			}
		}
		return ret;
	}

	public static void main(String[] args) {
		long millis = System.currentTimeMillis();
		rectangulosDiferentes(391);
		rectangulosDiferentes(982451629L*982451653L);
		System.out.println( System.currentTimeMillis() - millis );
	}
}
