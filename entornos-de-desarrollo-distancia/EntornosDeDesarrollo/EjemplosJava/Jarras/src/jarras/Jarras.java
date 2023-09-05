package jarras;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

/**
 * Almacena informacion acerca de varias jarras con cierta capacidad y su contenido
 * @author agonzalez
 *
 */
public class Jarras{

	int capacidad[];
	int contenido[];
	
	public Jarras(){
		this( new int[]{ 16, 9, 7 },  new int[]{ 16, 0, 0 } );
	}

	/**
	 * 
	 * @param capacidad capacidad de las jarras
	 * @param contenido contenido de las jarras
	 */
	public Jarras( int capacidad[], int contenido[] ){
		this.capacidad = capacidad.clone();
		this.contenido = contenido.clone();
	}
	
	/**
	 * 
	 * @return una copia del conjuto de jarras original
	 */
	public Jarras copiar(){
		return new Jarras( capacidad, contenido );
	}
	
	/**
	 * 
	 * @param origen jarra de origen
	 * @param destino jarra de destino
	 * @return nuevo conjunto de jarras donde la jarra origen se vuelca sobre la de destino
	 */
	public Jarras pasar( int origen, int destino ){
		int transvase = Math.min( contenido[origen], capacidad[destino] - contenido[destino] );
		if( transvase == 0 ){
			return null;
		}
		Jarras ret = copiar();
		ret.contenido[origen] -= transvase;
		ret.contenido[destino] += transvase;
		return ret;
	}
	
	@Override
	public String toString() {
		String ret = "(";
		for( int i = 0 ; i < contenido.length ; i++ ){
			ret += " " + contenido[i] + "/" + capacidad[i];
		}
		return ret + " )";
	}
	
	@Override
	public boolean equals(Object jarra) {
		Jarras j = (Jarras) jarra;
		for( int i = 0 ; i < j.contenido.length ; i++ ){
			if( j.contenido[i] != contenido[i] ){
				return false;
			}
		}
		return true;
	}
	
	
	/**
	 * Avanza en la secuencia de busqueda hacia una secuencia de cambios que lleve al objetivo
	 * @param visitados configuraciones de jarras ya revisadas
	 * @param soluciones lista de cambios que ya se han encontrado llevan a una solucion
	 * @param busqueda la lista de cambios que se esta comprobando en este momento
	 * @param objetivo la configuracion final de las jarras a la que se quiere llegar
	 * @return true si se encuentra una solucion
	 */
	private static boolean busca( Set<Jarras> visitados, Set<ArrayList<Jarras>> soluciones, ArrayList<Jarras> busqueda, Jarras objetivo ){
		
		Jarras actual = busqueda.get( busqueda.size()-1 );
		if( actual.equals(objetivo) ){
			soluciones.add(busqueda);
			return true;
		}
		
		if( visitados.contains(actual) ){
			return false;
		}
		
		visitados.add(actual);
		
		for( int origen = 0 ; origen < actual.capacidad.length ; origen++ ){
			for( int destino = 0 ; destino < actual.capacidad.length ; destino++ ){
				if( origen == destino ){
					continue;
				}
				Jarras siguiente = actual.pasar(origen, destino);
				if( siguiente == null ){
					continue;
				}
				ArrayList<Jarras> b = new ArrayList<Jarras>(busqueda);
				b.add(siguiente);
				busca( visitados, soluciones, b, objetivo );
			}
		}
		return false;
	}
	
	/**
	 * Encuentra las posibles formas de pasar de una configuracion de jarras a otra
	 * @param inicio configuracion inicial de las jarras
	 * @param objetivo configracion final buscada
	 * @return una lista de soluciones, que son una lista de los cambios entre el inicio y el objetivo
	 */
	public static Set<ArrayList<Jarras>> busca( Jarras inicio, Jarras objetivo ){
		Set<Jarras>visitados = new HashSet<Jarras>();
		ArrayList<Jarras> busqueda = new ArrayList<Jarras>();
		Set<ArrayList<Jarras>> soluciones = new HashSet<ArrayList<Jarras>>();
		busqueda.add(inicio);
		busca(visitados, soluciones, busqueda, objetivo);
		return soluciones;
		
	}
	
	@Override
	public int hashCode() {
		int ret = 0;
		for( int c: contenido ){
			ret += c;
			ret ^= 2;
		}
		return ret;
	}

	/**
	 * Ejemplo de uso, pasando unas jarras de capacidades 16, 9 y 7 con la primera llena, a una configuracion
	 * con 8 en una jarra, y 8 en otra
	 * 
	 */
	public static void main(String[] args) {
		Jarras inicio = new Jarras( new int[]{ 16, 9, 7 },  new int[]{ 16, 0, 0 } );
		Jarras objetivo = new Jarras( new int[]{ 16, 9, 7 },  new int[]{ 8, 8, 0 } );
		
		Set<ArrayList<Jarras>> soluciones = busca( inicio, objetivo );
		System.out.println( "Pasando de las jarras:" + inicio );
		System.out.println( "A las jarras:" + objetivo );
		for (ArrayList<Jarras> solucion : soluciones) {
			System.out.println( solucion );
		}
		
		
		
	}
	
}
