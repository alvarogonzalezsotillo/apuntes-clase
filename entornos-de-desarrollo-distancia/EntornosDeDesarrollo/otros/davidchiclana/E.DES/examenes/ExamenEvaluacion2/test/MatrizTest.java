/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import junit.framework.TestCase;

/**
 *
 * @author Aran
 */
public class MatrizTest extends TestCase{
    
    public MatrizTest(String nombre) {
        super(nombre);
    }
    
    // rotando 0 posiciones, rotar menos de 9 posiciones, rotar mas de 9 posiciones
    
    
    public void test_c1_Rotar_dcha(){
//        Matriz a[] = new Matriz[]{1,2,3};
        Matriz m[][] = new Matriz[0][0];
        assertTrue(m[2][2].Rota_dcha(m) == 1);
    
    }
    
    public void test_c1_Rotar_izda(){
        Matriz m[][] = new Matriz[0][0];
        assertTrue(m[0][0].Rota_izqda(m)== 9);
    }


}
