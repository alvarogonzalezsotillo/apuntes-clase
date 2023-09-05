package pruebas;


public class IntervalosAcabado {

	/**
	 * Calcula el solapamiento de dos intervalos [x1,x2) y [y1,y2)
	 * Por ejemplo, [5, 10) y [0,9) solapan en los elementos 5, 6, 7 y 8, ya que
	 * el 9 no esta incluido. 
	 * 
	 * @param x1 Inicio del intervalo x
	 * @param x2 Fin del intervalo x
	 * @param y1 Inicio del intervalo y
	 * @param y2 Fin del intervalo y
	 * @return El solapamiento de los intervalos
	 */
	public static int solapamiento(int x1, int x2, int y1, int y2) {
		int ret;
		if (x1 > y1) {
			if (x2 < y2)
				ret = x2 - x1;
			else {
				if (x1 > y2)
					ret = 0;
				else
					ret = y2 - x1;
			}

		} else {
			if (x2 > y2)
				ret = y2 - y1;
			else {
				if (x2 > y1)
					ret = x2 - y1;
				else
					ret = 0;
			}

		}
		return ret;
	}

	public static int overlap(int x1, int x2, int y1, int y2) {
		int a = Math.max(x1, y1);
		int b = Math.min(x2, y2);
		return Math.max(0, b - a);
	}

}
