import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

/**
 * A Window that holds a PentominosPanel and its menu bar.
 * This class has a main program that simply opens a window.
 */
public class Pentominos extends JFrame {

   public static void main(String[] args) {
      int rows, cols;
      try {
         rows = Integer.parseInt(args[0]);
         cols = Integer.parseInt(args[1]);
      }
      catch (Exception e) {
         rows = 8;
         cols = 8;
      }
      Pentominos f = new Pentominos("Pentominos",rows, cols);
      f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
      f.setVisible(true);
   }
   
   private PentominosPanel panel;
   private boolean runningAsApplet = true;
   
   public Pentominos(String title, int rows, int cols) {
      this(title,rows,cols,false);
   }
   
   public Pentominos(String title, int rows, int cols, boolean runningAsApplet) {
      super(title);
      panel = new PentominosPanel(rows,cols,true);
      setContentPane(panel);
      this.runningAsApplet = runningAsApplet;
      JMenuBar bar = panel.getMenuBar(!runningAsApplet,null);
      bar.add(makeSizeMenu());
      setJMenuBar(bar);
      pack();
      Dimension screensize = Toolkit.getDefaultToolkit().getScreenSize();
      setLocation( (screensize.width - getWidth())/2, (screensize.height - getHeight())/2 );
   }
   
   private static int[][] sizeChoices = {
      {8,8}, {10,6}, {12,5}, {15,4}, {20,3},
      {8,9}, {11,6}, {13,5}, {16,4}
   };
   
   private JMenu makeSizeMenu() {
      JMenu size = new JMenu("Size");
      for (int i = 0; i < sizeChoices.length; i++) {
         final int r = sizeChoices[i][0];
         final int c = sizeChoices[i][1];
         JMenuItem item = new JMenuItem(r + "-by-" + c);
         item.addActionListener( new ActionListener() {
            public void actionPerformed(ActionEvent evt) {
               setBoardSize(r,c);
            }
         });
         size.add(item);
      }
      JMenuItem other = new JMenuItem("Custom Size...");
      other.addActionListener(new ActionListener() {
         public void actionPerformed(ActionEvent evt) {
            doOtherSize();
         }
      });
      size.addSeparator();
      size.add(other);
      return size;
   }
   
   private void doOtherSize() {
      JPanel p = new JPanel();
      p.setBorder(BorderFactory.createEmptyBorder(10,10,10,10));
      p.setLayout(new GridLayout(2,2,10,10));
      JComboBox rowChoice = new JComboBox();
      JComboBox columnChoice = new JComboBox();
      for (int i = 3; i <= 21; i++) {
         String s = "" + i;
         rowChoice.addItem(s);
         columnChoice.addItem(s);
      }
      rowChoice.setSelectedIndex(5);
      columnChoice.setSelectedIndex(5);
      p.add( new JLabel("Rows:", JLabel.RIGHT) );
      p.add(rowChoice);
      p.add( new JLabel("Columns:", JLabel.RIGHT) );
      p.add(columnChoice);
      if (JOptionPane.OK_OPTION == JOptionPane.showConfirmDialog(panel,p,"Select Size",JOptionPane.OK_CANCEL_OPTION)) {
         int r= rowChoice.getSelectedIndex() + 3;
         int c = columnChoice.getSelectedIndex() + 3;
         setBoardSize(r,c);
      }
   }
   
   private void setBoardSize(int rows, int cols) {
      PentominosPanel oldPanel = panel;
      oldPanel.terminate();
      panel = new PentominosPanel(rows,cols,false);
      JMenuBar bar = panel.getMenuBar(!runningAsApplet,oldPanel);
      bar.add(makeSizeMenu());
      setJMenuBar(bar);
      setContentPane(panel);
      pack();
      int squareWidth = panel.getWidth() / cols; 
      int squareHeight = panel.getHeight() / rows; 
      Rectangle bounds = getBounds();
      if (squareHeight < squareWidth)
         bounds.width = 4 + cols*squareHeight; // comment at bottom and menu bar can distort squares when packing
      Dimension screensize = Toolkit.getDefaultToolkit().getScreenSize();
      if (bounds.x + bounds.width + 20 > screensize.width)
         bounds.x = screensize.width - bounds.width - 20;
      if (bounds.y + bounds.height > screensize.height)
         bounds.y = screensize.height - bounds.height;
      setBounds(bounds);
      validate();  // Seems to be necessary on Windows only.
   }

}
