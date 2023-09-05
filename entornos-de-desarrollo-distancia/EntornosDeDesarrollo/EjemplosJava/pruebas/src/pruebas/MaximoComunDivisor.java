package pruebas;

/**
 * Devuelve el maximo comun divisor de dos numeros
 * @author alvaro.gonzalezsotillo@educa.madrid.org
 *
 */
public abstract class MaximoComunDivisor {
	private MaximoComunDivisor(){
	}
	
	public int mcd(int a, int b){
		if( a <= 0 || b <= 0 ){
			throw new IllegalArgumentException();
		}
		return mcd_I(a,b);
	}
	
	abstract protected int mcd_I(int a, int b);
	
	public static MaximoComunDivisor ITERATIVO = new MaximoComunDivisor(){
		@Override
		public int mcd_I(int a, int b) {
			int temp;
			while( b > 0 ){
				if( a < b ){
					temp = a;
					a = b;
					b = temp;
				}
				temp = b;
				b = a - b;
				a = temp;
			}
			return a;
		}
	};
	
	public static MaximoComunDivisor RECURSIVO = new MaximoComunDivisor() {
		@Override
		public int mcd_I(int a, int b) {
			if( b == 0 ){
				return a;
			}
			int newA = Math.max(a, b);
			int newB = Math.min(a, b);
			return mcd_I( newB, newA-newB );
		}
	};
	
}

