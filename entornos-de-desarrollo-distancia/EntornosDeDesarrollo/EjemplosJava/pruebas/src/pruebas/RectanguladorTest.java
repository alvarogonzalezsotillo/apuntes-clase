package pruebas;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

public class RectanguladorTest {

	@Test
	public void unPrimoNoTieneRectangulos(){
		assertEquals( Rectangulador.rectangulosDiferentes(29), 0 );
	}
	
	@Test
	public void soloUnRectangulo(){
		assertEquals( Rectangulador.rectangulosDiferentes(391), 1 );
	}

	@Test
	public void soloUnRectanguloCuadrado(){
		assertEquals( Rectangulador.rectangulosDiferentes(11*11), 1 );
	}
	
	
	@Test
	public void variosRectangulos(){
		assertEquals( Rectangulador.rectangulosDiferentes(60), 5 );
	}
	
	@Test(expected=IllegalArgumentException.class)
	public void elCeroNoTieneRectangulos(){
		Rectangulador.rectangulosDiferentes(0);
	}
	
	@Test(expected=IllegalArgumentException.class)
	public void unNegativoNoTieneRectangulos(){
		Rectangulador.rectangulosDiferentes(-60);
	}
	
	@Test(timeout=60000)
	public void unNumeroGrandeEnMenosDeUnMinuto(){
		assertEquals( Rectangulador.rectangulosDiferentes(965211226903592737L), 1 );
	}
	
}
