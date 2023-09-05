package pruebas;

import static pruebas.Triangulador.TipoTriangulo.*;

public class Triangulador {

	public static enum TipoTriangulo{
		equilatero, isosceles, escaleno, rectangulo, notriangulo
	}
	
	/**
	 * Calcula el tipo de triangulo que se construiria con tres segmentos
	 * de la longitud dada. 
	 * Si un triangulo es a la vez isosceles y equilatero, se considera
	 * que ser equilatero es mas importante.
	 * Si un triangulo es a la vez isosceles y rectangulo, se considera 
	 * que ser rectangulo es mas importante.
	 * @param a longitud del lado a
	 * @param b longitud del lado b
	 * @param c longitud del lado c
	 * @return un tipo de triangulo del enum correspondiente
	 */
	public static TipoTriangulo triangula( int a, int b, int c ){
		
		TipoTriangulo ret = escaleno;
		
		if( a == b && b == c )
			ret = equilatero;
		
		else if( a*a + b*b == c*c || b*b + c*c == a*a || a*a + c*c == b*b )
			ret = rectangulo;
		
		else if( a == b || b == c || b == a )
			ret = isosceles;			
		
		return ret;
	}
}
