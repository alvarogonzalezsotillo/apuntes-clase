package pruebas;

import static org.junit.Assert.*;
import static pruebas.MaximoComunDivisor.ITERATIVO;
import static pruebas.MaximoComunDivisor.RECURSIVO;

import org.junit.BeforeClass;
import org.junit.Test;

public class MaximoComunDivisorTest {

	private static MaximoComunDivisor m;

	@BeforeClass
	public static void preparaMCD(){
		m = RECURSIVO;
	}
	
	@Test
	public void conFactoresComunes() {
		assertEquals(m.mcd(10, 15), 5);
	}

	@Test
	public void sinFactoresComunes() {
		assertTrue( m.mcd(10, 17) == 1);
	}

	@Test(expected = IllegalArgumentException.class)
	public void noSeAceptanNegativos() {
		m.mcd(10, -1);
	}

	@Test(expected = IllegalArgumentException.class)
	public void noSeAceptanCeros() {
		m.mcd(10, 0);
	}

	@Test
	public void recursivoGrande() {
		m.mcd(Integer.MAX_VALUE/10, 1);
	}

	@Test
	public void iterativoGrande() {
		m.mcd(Integer.MAX_VALUE/10, 1);
	}

	@Test(timeout=10)
	public void recursivoEsIgualAIterativo() {
		for( int j = 0 ; j < 100000 ; j++ ){
			int a = (int) (Math.random() * 500)+1;
			int b = (int) (Math.random() * 500)+1;
			int r = RECURSIVO.mcd(a, b);
			int i =ITERATIVO.mcd(a, b);
			assertEquals(r,i);
		}
	}

}
