package pruebas;

/**
 * Operaciones de suma y multiplicación con polinomios
 * 
 * @author alvaro.gonzalezsotillo@educa.madrid.org
 * 
 */
public class Polinomio {
	private double _coeficientes[];

	public Polinomio() {
		this( new double[]{0} );
	}

	public Polinomio(double coeficientes[]) {
		_coeficientes = new double[coeficientes.length];
		System.arraycopy(coeficientes, 0, _coeficientes, 0, coeficientes.length);
	}

	public int grado() {
		return _coeficientes.length - 1;
	}
	
	public double coeficiente( int grado ){
		if( grado > grado() ){
			return 0;
		}
		return _coeficientes[grado];
	}
	
	public static Polinomio menos(Polinomio a){
		double coeficientes[] = new double[a.grado()+1];
		for( int i = 0 ; i <= a.grado() ; i++ ){
			coeficientes[i] = -a.coeficiente(i);
		}
		return new Polinomio(coeficientes);
	}
	
	public static Polinomio resta( Polinomio a, Polinomio b ){
		return suma(a, menos(b) );
	}
	
	public static Polinomio suma( Polinomio a, Polinomio b ){
		int grado = Math.max(a.grado(), b.grado()) + 1;
		double coeficientes[] = new double[grado];
		
		for( int i = 0 ; i < grado ; i++ ){
			coeficientes[i] = a.coeficiente(i) + b.coeficiente(i);
		}
		return new Polinomio(coeficientes);
	}
	
	public static Polinomio multiplica( Polinomio a, Polinomio b ){
		Polinomio ret = new Polinomio();
		for( int i = 0 ; i <= b.grado() ; i++ ){
			Polinomio p = a.copia();
			p = p.elevaGrado(i);
			p = p.multiplica( b.coeficiente(i) );
			ret = suma( ret, p );
		}
		return ret;
	}
	
	public double valor(double x){
		double ret = coeficiente(grado());
		for( int i = grado()-1 ; i >= 0 ; i-- ){
			ret *= x;
			ret += coeficiente(i);
		}
		return ret;
	}
	
	public Polinomio elevaGrado(int grados){
		double coeficientes[] = new double[grado()+1+grados];
		System.arraycopy(_coeficientes, 0, coeficientes, grados, _coeficientes.length);
		return new Polinomio(coeficientes);
	}
	
	public Polinomio multiplica(double n){
		double coeficientes[] = new double[grado()+1];
		for (int i = 0; i < coeficientes.length; i++) {
			coeficientes[i] = coeficiente(i)*n;
		}
		return new Polinomio(coeficientes);
	}
	
	public Polinomio copia(){
		return multiplica(1);
	}
	
	@Override
	public String toString() {
		String ret = "";
		for( int i = grado() ; i >= 0 ; i-- ){
			if( coeficiente(i) >= 0 ){
				ret += "+ ";
			}
			ret += coeficiente(i); 
			if( i > 0 ){
				ret +="x";
			}
			if( i > 1 ){
				ret += "^" + i; 
			}
			ret += " ";
		}
		return ret;
	}

	public static void main(String[] args){
		Polinomio p1 = new Polinomio( new double[]{1,-2.5,3} );
		Polinomio p2 = new Polinomio( new double[]{1,-2.5,3} );
		
		Polinomio p = multiplica(p1, p2);
		
		System.out.println( p1.valor(3) );
		System.out.println( 1 - 3*2.5 + 3*3*3 );
		System.out.println( p1 );
		
		System.out.println( p1.valor(3)*p2.valor(3) + " == " + p.valor(3) );
	}
}
