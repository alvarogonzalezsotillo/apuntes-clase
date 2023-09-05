import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

import javax.swing.JApplet;

/**
 * This applets appears as a single button that can be clicked to open a
 * window of type Pentominos.
 */
public class PentominosLauncherApplet extends JApplet {
   
   private JButton launchButton;
   private Pentominos frame;

   public PentominosLauncherApplet() {
      launchButton = new JButton("Launch Pentominos");
      setContentPane(launchButton);
      launchButton.addActionListener(new ActionListener() {
         public void actionPerformed(ActionEvent evt) {
            doLaunchButton();
         }
      });
   }
   
   public void stop() {
      if (frame != null)
         frame.dispose();
   }
   
   private void doLaunchButton() {
      launchButton.setEnabled(false);
      if (frame == null) {
         frame = new Pentominos("Pentominos",8,8,true);
         frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
         frame.addWindowListener( new WindowAdapter() {
            public void windowClosed(WindowEvent evt) {
               launchButton.setText("Launch Pentominos");
               launchButton.setEnabled(true);
               frame = null;
            }
            public void windowOpened(WindowEvent evt) {
               launchButton.setText("Close Pentominos");
               launchButton.setEnabled(true);
            }
         });
         frame.setVisible(true);
      }
      else {
         frame.dispose();
      }
   }
   

}
