import java.io.*;

public class Fibonacci {
    /**************************************************************************
    * Fibonacci                                                               *
    * F(0) = 0, F(1) = 1, F(n) = F(n-1) + F(n-2)                              *
    **************************************************************************/
    public static int fibonacci (int num) {
        int calc = 0;  // valor a devolver

        if (num <= 1)  // F(0) = 0, F(1) = 1, asumimos que es >= 0
            calc = num;
        else           // num > 1
            calc = fibonacci (num - 1) + fibonacci (num);

       return calc;
    }

    /**************************************************************************
    * The main routine                                                        *
    **************************************************************************/
    public static void main (String [] args) 
    {
        int number = 0;    // número leido

        // Comprobar si tenemos los parámetros necesarios
        if (args.length != 1) {
            System.out.println ("Debes introducir un solo parámetro");
            System.exit (-1);
        }

        // Convertir el parámetro a número
        try {
            number = Integer.parseInt (args [0]);
        } catch (NumberFormatException x) {
            System.out.println ("El parámetro debe ser un número.");
            System.exit (-1);
        }

        // Comprobar que es al menos 0
        if (number < 0) {
            System.out.println
            ("No se admiten negativos.");
            System.exit (-1);
        }

        // Calcular el resultado
        System.out.println (fibonacci (number));
    }
}
