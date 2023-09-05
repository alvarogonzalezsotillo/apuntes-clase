/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package unidad3;

/**
 *
 * @author java
 */
import java.io.*;
public class MayorMenor3NumerosDepurar {
 private static BufferedReader stdin = new BufferedReader(new InputStreamReader(System.in));
    public static void main(String args[]) throws IOException{
        String input;
        int n1,n2,n3,mayor;
        System.out.printf("Introduce el primer numero: ");
        input=stdin.readLine();
        n1 =Integer.parseInt(input);
        System.out.printf("Introduce el segundo numero: ");
        input=stdin.readLine();
        n2 =Integer.parseInt(input);
        System.out.printf("Introduce el tercer numero: ");
        input=stdin.readLine();
        n3 =Integer.parseInt(input);

        if(n1>n2) {
            if(n3>n1) System.out.printf("\n %d %d %d",n3,n1,n2);
            else if(n3>n2) System.out.printf("\n %d %d %d",n1,n3,n2);
            else System.out.printf("\n %d %d %d",n1,n2,n3);
        }
        else if(n2>n1) {
                if(n3>n2) System.out.printf("\n %d %d %d",n3,n2,n1);
                else if(n3>n1) System.out.printf("\n %d %d %d",n2,n3,n1);
                else System.out.printf("\n %d %d %d",n2,n1,n3);
        }
        else if(n1==n2){
                System.out.printf("\n %d %d=%d",n3,n1,n2);
                if (n3>n1) System.out.printf("\n %d %d=%d",n3,n1,n2);
                else if(n1<n3) System.out.printf("\n %d=%d %d",n1,n2,n3);
        }
        else if(n1==n3){
                if (n2>n1) System.out.printf("\n %d %d=%d",n2,n1,n3);
                else if(n1>n2) System.out.printf("\n %d=%d %d",n1,n3,n2);
        }
        else if(n2==n3){
            if (n2>n1) System.out.printf("\n %d=%d %d",n2,n3,n1);
            else if(n1>n2) System.out.printf("\n %d %d=%d",n1,n2,n3);
        }
        else System.out.printf("Son iguales",n2,n3,n1);
   }
}
