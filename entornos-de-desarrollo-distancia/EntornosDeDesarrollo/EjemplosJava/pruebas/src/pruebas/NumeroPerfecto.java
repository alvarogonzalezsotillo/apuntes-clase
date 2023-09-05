package pruebas;

public class NumeroPerfecto {
	
	
	
	
	public boolean esPerfecto(int n){
		int divisores = 0;
		for( int i = 1 ; i < n ; i++ ){
			if( n%i == 0 ){
				divisores += i;
			}
		}
		return divisores == n;
	}
	
	
	
	
	
	
	
	
	
	public static void main(String[] args) {
		NumeroPerfecto np = new NumeroPerfecto();
		
		int pruebas[] = {-6, -1, 0, 1, 2, 3, 6, 13, 27, 29};
		
		for (int n : pruebas) {
			System.out.println( n + " es perfecto: " + np.esPerfecto(n) );
		}
	}

}
