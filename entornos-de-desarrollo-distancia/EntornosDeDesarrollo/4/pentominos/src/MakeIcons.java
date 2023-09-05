import java.awt.Color;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.File;

import javax.imageio.ImageIO;
import javax.swing.JFileChooser;
import javax.swing.JOptionPane;

/**
 * This class is not actually part of the Pentominos program.  I used it to create some
 * images of the pieces that are used:  A large image that shows all the pieces in all
 * possible rotations/reflections and the images that are used in the dialog box for the
 * "One Sided" command.
 */
public class MakeIcons {
   
   private  static final int[][] piece_data = {  // Describes the pieces, taken from PentominosPanel.java
      { 1, 0,1,0,2,0,3,0,4 },
      { 1, 1,0,2,0,3,0,4,0 },
      { 2, 1,-1,1,0,1,1,2,0 },
      { 3, 0,1,1,0,2,-1,2,0 },
      { 3, 1,0,1,1,1,2,2,2 },
      { 3, 0,1,1,1,2,1,2,2 },
      { 3, 1,-2,1,-1,1,0,2,-2 },
      { 4, 1,0,2,0,2,1,2,2 },
      { 4, 0,1,0,2,1,0,2,0 },
      { 4, 1,0,2,-2,2,-1,2,0 },
      { 4, 0,1,0,2,1,2,2,2 },
      { 5, 0,1,0,2,1,1,2,1 },
      { 5, 1,-2,1,-1,1,0,2,0 },
      { 5, 1,0,2,-1,2,0,2,1 },
      { 5, 1,0,1,1,1,2,2,0 },
      { 6, 1,0,1,1,2,1,2,2 },
      { 6, 1,-1,1,0,2,-2,2,-1 },
      { 6, 0,1,1,1,1,2,2,2 },
      { 6, 0,1,1,-1,1,0,2,-1 },
      { 7, 0,1,0,2,1,0,1,2 },
      { 7, 0,1,1,1,2,0,2,1 },
      { 7, 0,2,1,0,1,1,1,2 },
      { 7, 0,1,1,0,2,0,2,1 },
      { 8, 1,0,1,1,1,2,1,3 },
      { 8, 1,0,2,0,3,-1,3,0 },
      { 8, 0,1,0,2,0,3,1,3 },
      { 8, 0,1,1,0,2,0,3,0 },
      { 8, 0,1,1,1,2,1,3,1 },
      { 8, 0,1,0,2,0,3,1,0 },
      { 8, 1,0,2,0,3,0,3,1 },
      { 8, 1,-3,1,-2,1,-1,1,0 },
      { 9, 0,1,1,-2,1,-1,1,0 },
      { 9, 1,0,1,1,2,1,3,1 },
      { 9, 0,1,0,2,1,-1,1,0 },
      { 9, 1,0,2,0,2,1,3,1 },
      { 9, 0,1,1,1,1,2,1,3 },
      { 9, 1,0,2,-1,2,0,3,-1 },
      { 9, 0,1,0,2,1,2,1,3 },
      { 9, 1,-1,1,0,2,-1,3,-1 },
      { 10, 1,-2,1,-1,1,0,1,1 },
      { 10, 1,-1,1,0,2,0,3,0 },
      { 10, 0,1,0,2,0,3,1,1 },
      { 10, 1,0,2,0,2,1,3,0 },
      { 10, 0,1,0,2,0,3,1,2 },
      { 10, 1,0,1,1,2,0,3,0 },
      { 10, 1,-1,1,0,1,1,1,2 },
      { 10, 1,0,2,-1,2,0,3,0 },
      { 11, 1,-1,1,0,1,1,2,1 },
      { 11, 0,1,1,-1,1,0,2,0 },
      { 11, 1,0,1,1,1,2,2,1 },
      { 11, 1,0,1,1,2,-1,2,0 },
      { 11, 1,-2,1,-1,1,0,2,-1 },
      { 11, 0,1,1,1,1,2,2,1 },
      { 11, 1,-1,1,0,1,1,2,-1 },
      { 11, 1,-1,1,0,2,0,2,1 },
      { 12, 0,1,1,0,1,1,2,1 },
      { 12, 0,1,0,2,1,0,1,1 },
      { 12, 1,0,1,1,2,0,2,1 },
      { 12, 0,1,1,-1,1,0,1,1 },
      { 12, 0,1,1,0,1,1,1,2 },
      { 12, 1,-1,1,0,2,-1,2,0 },
      { 12, 0,1,0,2,1,1,1,2 },
      { 12, 0,1,1,0,1,1,2,0 }
   };
   
   private static Color pieceColor[] = {  // the colors of pieces number 1 through 12; pieceColor[0] is not used.
         null,
         new Color(200,0,0),
         new Color(150,150,255),
         new Color(0,200,200),
         new Color(255,150,255),
         new Color(0,200,0),
         new Color(150,255,255),
         new Color(200,200,0),
         new Color(0,0,200),
         new Color(255,150,150),
         new Color(200,0,200),
         new Color(255,255,150),
         new Color(150,255,150)
   };
   
   private final static int[][][] side_info = { // piece positions for the two sides of two-sided pentominos; used in implementation of "One Sided" command.
      { {27, 28, 29, 30}, {23, 24, 25, 26} }, // Sides A and B for "L" pentomino
      { {35, 36, 37, 38}, {31, 32, 33, 34} }, // for "N" pentomino
      { {43, 44, 45, 46}, {39, 40, 41, 42} }, // for "Y" pentomino
      { {47, 48, 49, 50}, {51, 52, 53, 54} }, // for "R" pentomino
      { {59, 60, 61, 62}, {55, 56, 57, 58} }, // for "P" pentomino
      { {3, 4}, {5, 6} }                      // for "Z" pentoino
   };
   
   private static void doSaveImage(BufferedImage image, String fileName) {
      String defaultName = "/Users/eck/Desktop/pentomino_icons/" + fileName + ".png"; // Name for file to be saved.
      File selectedFile = new File(defaultName);
      System.out.println("Saving image " + selectedFile.getAbsolutePath());
      try {
         if ( ! ImageIO.write(image,"PNG",selectedFile) )  // This actually writes the image to the file.
            System.out.println("   Can't write PNG");
      }
      catch (Exception e) {
         System.out.println("   Error while saving image.");
      }
   }
   
   public static void makeAllPieces() {  // Make an image showing all the pieces in all postions
      BufferedImage icons = new BufferedImage(9*56,12*56,BufferedImage.TYPE_INT_RGB);
      Graphics g = icons.getGraphics();
      g.setColor(Color.white);
      g.fillRect(0,0,9*56,12*56);
      g.setColor(Color.black);
      g.drawRect(0,0,9*56-1,12*56-1);
      int y = 10;
      int x = 56;
      int current_piece = 1;
      g.setColor(Color.black);
      g.drawString("0",20,35);
      for (int i = 0; i < piece_data.length; i++) {
         int[] piece = piece_data[i];
         if (piece[0] > current_piece) {
            y += 56;
            x = 56;
            g.setColor(Color.black);
            g.drawString(""+i,20,y+20);
            current_piece = piece[0];
         }
         if (i == 1)
            x += 10;  // Move vertical "I" pentomino over 20 pixels.
         int mincol = 0;
         for (int j = 2; j < 8; j += 2)
            if (piece[j] < mincol)
               mincol = piece[j];
         g.setColor(pieceColor[piece[0]]);
         g.fillRect(x-mincol*10+3,y,10,10);
         g.setColor(Color.black);
         g.drawRect(x-mincol*10+3,y,10,10);
         for (int j = 1; j < 8; j += 2) {
            g.setColor(pieceColor[piece[0]]);
            g.fillRect(x+(-mincol+piece[j+1])*10+3,y+piece[j]*10,10,10);
            g.setColor(Color.black);
            g.drawRect(x+(-mincol+piece[j+1])*10+3,y+piece[j]*10,10,10);
         }
         x += 56;
      }
      doSaveImage(icons,"all_pieces");
      System.out.println("Done");
   }
   
   private static void makeSideIcons() {  // Make images used in the dialog box for the "One Sided" command.
      for (int p = 0; p < 6; p++) {
         int[][] sides = side_info[p];
         for (int s = 0; s < 2; s++) {
            int[] pieces = sides[s];
            int width = 200; // 10 + 50*pieces.length;
            int height = 20 + (p >= 3? 30 : 40);
            BufferedImage icon = new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);
            Graphics g = icon.getGraphics();
            g.setColor(Color.white);
            g.fillRect(0,0,width,height);
            g.setColor(Color.black);
            g.drawRect(0,0,width-1,height-1);
            int x = 0;
            for (int i = 0; i < pieces.length; i++) {
               int[] piece = piece_data[pieces[i]];
               int mincol = 0;
               for (int j = 2; j < 8; j += 2)
                  if (piece[j] < mincol)
                     mincol = piece[j];
               g.setColor(pieceColor[piece[0]]);
               g.fillRect(x-mincol*10+10,10,10,10);
               g.setColor(Color.black);
               g.drawRect(x-mincol*10+10,10,10,10);
               for (int j = 1; j < 8; j += 2) {
                  g.setColor(pieceColor[piece[0]]);
                  g.fillRect(x+(-mincol+piece[j+1])*10+10,10+piece[j]*10,10,10);
                  g.setColor(Color.black);
                  g.drawRect(x+(-mincol+piece[j+1])*10+10,10+piece[j]*10,10,10);
               }
               x += 50;
               if (p == 0 && s == 0 && i == 2) // special offset for last position of side A of "L" pentomino 
                  x -= 10;
            }

            
            doSaveImage(icon,"piece" + p + "_side" + (s+1));
         }
      }
   }


   public static void main(String[] args) {
      
      makeAllPieces();
      makeSideIcons();

   }

}
