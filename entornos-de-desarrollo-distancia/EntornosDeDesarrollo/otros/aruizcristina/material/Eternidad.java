public class Eternidad{

    public static void main (String args[])
    {
        System.out.print("* ");
        System.out.println( "y=" + loopy(23) );
    }

   
    public static int loopy(int y)
    {
        for (int i=0; i <10 ; i++) 
        {
            y++;
            i=3;
        }
        return y;
    }
    
}