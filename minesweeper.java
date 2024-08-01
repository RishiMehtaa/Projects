
import javax.swing.*;
import javax.swing.plaf.BorderUIResource;
import java.awt.*;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.util.Random;


public class minesweeper implements MouseListener {

    JFrame f,g;
    JLabel go,t,level;
    JLabel[][] l;
    JButton[][] b;
    JButton c,rep,yes,no;
    JLayeredPane p1,p2;
    int m=0,n=0,i,j,count=0,clear=0,flag=0,win,bi,bj,bom=100;
    ImageIcon img,bomb;
    Random r;
    
    minesweeper()                                           //design
    {
        img = new ImageIcon("C:\\Users\\merit\\OneDrive\\Desktop\\bgs\\flag4.png");
        bomb = new ImageIcon("C:\\Users\\merit\\OneDrive\\Desktop\\bgs\\bomb.png");
        l = new JLabel[15][12];
        b = new JButton[15][12];
        r=new Random();

        f = new JFrame("Minesweeper");              //main frame
        f.setLayout(null);
        f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        f.setBounds(500,100,500,700);
        f.setVisible(true);

        g = new JFrame("GAME OVER");                //frame for game over
        g.setLayout(null);
        g.setBounds(600,300,300,200);
        g.setVisible(false);

        go = new JLabel("GAME OVER, Replay?");
        go.setFont(new Font(null, 0, 15));
        go.setBounds(70,40,250,20);
        g.add(go);

        yes = new JButton("YES");                   //yes button
        yes.setBounds(50,90,70,40);
        yes.addMouseListener(this);
        g.add(yes);

        no = new JButton("NO");             //no button
        no.setBounds(150,90,70,40);
        no.addMouseListener(this);
        g.add(no);

        t = new JLabel();                                           //flag counter
        t.setBounds(40, 50, 50, 50);
        t.setText(Integer.toString(count));
        f.add(t);

        level = new JLabel();
        level.setBounds(105, 50, 120, 50);
        level.setVisible(true);
        f.add(level);

        c = new JButton("QUIT");                   //quit buttom
        c.setBounds(360, 45, 100, 50);
        c.addMouseListener(this);
        f.add(c);

        rep = new JButton("NEW GAME");                 //reset button
        rep.setBounds(240, 45, 100, 50);
        rep.addMouseListener(this);
        f.add(rep);

        p1 = new JLayeredPane();                                        //layer of bombs and numbers
        p1.setBounds(10, 100, 457, 550);
        p1.setBorder(BorderUIResource.getBlackLineBorderUIResource()); 
        p1.setLayout(new GridLayout(15, 12,1,1));
        p1.setLayer(p1, p1.lowestLayer());
        
        p2 = new JLayeredPane();                                                //layer of tiles
        p2.setBounds(10, 100, 457, 550);
        p2.setBorder(BorderUIResource.getBlackLineBorderUIResource()); 
        p2.setLayout(new GridLayout(15, 12,1,1));
        p2.setLayer(p2, p2.highestLayer());

        for(i=0;i<15;i++)                                                    //adding labels and buttons
        {
            for(j=0;j<12;j++)
            {

                l[i][j]= new JLabel("",JLabel.CENTER);
                l[i][j].setBorder(BorderUIResource.getEtchedBorderUIResource());
                // l[i][j].setBackground(Color.BLACK);
                p1.add(l[i][j]);

                b[i][j]= new JButton();
                b[i][j].setBackground(Color.GRAY);
                b[i][j].addMouseListener(this);
                p2.add(b[i][j]);
               

            }

        }

        newgame();

        f.add(c);
        f.add(p2);
        f.add(p1);
        f.add(g);
    }

    public void numbercolour(int i, int j, int num)         //colouring the numbers
    {
        switch (num) {
            case 1:
                l[i][j].setForeground(Color.BLUE);
                break;
            case 2:
                l[i][j].setForeground(Color.GREEN);
            break;
            case 3:
                l[i][j].setForeground(Color.ORANGE);
            break;
            case 4:
                l[i][j].setForeground(Color.MAGENTA);
            break;
            case 5:
                l[i][j].setForeground(Color.RED);
            break;
            case 6:
                l[i][j].setForeground(Color.RED);
            break;
            case 7:
                l[i][j].setForeground(Color.RED);
            break;
            case 8:
                l[i][j].setForeground(Color.RED);
            break;
            default:
                break;
        }
    }

    public void tileopen(int i, int j)                      //opening surrounding tiles

    {
        if((j!=0)&&(i!=0))      //top left
        {
            if(b[i-1][j-1].getIcon()==null)
            b[i-1][j-1].setVisible(false);
        }
        if(i!=0)            //upper
        {
            if(b[i-1][j].getIcon()==null)
            b[i-1][j].setVisible(false);
        }
        if((j!=11)&&(i!=0))         //top right
        {
            if(b[i-1][j+1].getIcon()==null)
            b[i-1][j+1].setVisible(false);

        }
        if(j!=0)            //left
        {
            if(b[i][j-1].getIcon()==null)
            b[i][j-1].setVisible(false);
        }
        if(j!=11)                //right
        {
            if(b[i][j+1].getIcon()==null)
            b[i][j+1].setVisible(false);
        }
        if((j!=0)&&(i!=14))              //bottom left
        {
            if(b[i+1][j-1].getIcon()==null)
            b[i+1][j-1].setVisible(false);
        }
        if(i!=14)               //down
        {
            if(b[i+1][j].getIcon()==null)
            b[i+1][j].setVisible(false);
        }
        if((j!=11)&&(i!=14))                 //bottom right
        {
            if(b[i+1][j+1].getIcon()==null)
            b[i+1][j+1].setVisible(false);
        }


    }
    
    public void tileboom(int i, int j)                      //checking surrounding tiles and opening them             
    {

        if((j!=0)&&(i!=0))
        {
            if((l[i-1][j-1].getText()==null)&&(l[i-1][j-1].getIcon()==null)&&((b[i-1][j-1].isVisible()==true)||(b[i-1][j-1].getIcon()==img)))        //top left
            {
                if(b[i-1][j-1].getIcon()==null)
                b[i-1][j-1].setVisible(false);
                tileboom(i-1, j-1);
            }
            
        }
        if(i!=0)
        {
            if((l[i-1][j].getText()==null)&&(l[i-1][j].getIcon()==null)&&((b[i-1][j].isVisible()==true)||(b[i-1][j].getIcon()==img)))             //upper
            {
                if(b[i-1][j].getIcon()==null)
                b[i-1][j].setVisible(false);
                tileboom(i-1, j);
            }
            

        }
        if((j!=11)&&(i!=0))
        {
            if((l[i-1][j+1].getText()==null)&&(l[i-1][j+1].getIcon()==null)&&((b[i-1][j+1].isVisible()==true)||(b[i-1][j+1].getIcon()==img)))              //top right
            {    
                if(b[i-1][j+1].getIcon()==null)
                b[i-1][j+1].setVisible(false);
                tileboom(i-1, j+1);
    
            }
    

        }
        if(j!=0)
        {
            if((l[i][j-1].getText()==null)&&(l[i][j-1].getIcon()==null)&&((b[i][j-1].isVisible()==true)||(b[i][j-1].getIcon()==img)))     //left
            {                
                if(b[i][j-1].getIcon()==null)
                b[i][j-1].setVisible(false);
                tileboom(i, j-1);
            }
     
             

        }
        if(j!=11)
        {
            if((l[i][j+1].getText()==null)&&(l[i][j+1].getIcon()==null)&&((b[i][j+1].isVisible()==true)||(b[i][j+1].getIcon()==img)))        //right
            {                
                if(b[i][j+1].getIcon()==null)
                b[i][j+1].setVisible(false);
                tileboom(i, j+1);
            }
    
            

        }
        if((j!=0)&&(i!=14))
        {
            if((l[i+1][j-1].getText()==null)&&(l[i+1][j-1].getIcon()==null)&&((b[i+1][j-1].isVisible()==true)||(b[i+1][j-1].getIcon()==img)))      //bottom left
            {                
                if(b[i+1][j-1].getIcon()==null)
                b[i+1][j-1].setVisible(false);
                tileboom(i+1, j-1);
            }
    

        }
        if(i!=14)
        {
            if((l[i+1][j].getText()==null)&&(l[i+1][j].getIcon()==null)&&((b[i+1][j].isVisible()==true)||(b[i+1][j].getIcon()==img)))        //down
            {                
                if(b[i+1][j].getIcon()==null)
                b[i+1][j].setVisible(false);
                tileboom(i+1, j);
            }
    

        }
        if((j!=11)&&(i!=14))
        {
            if((l[i+1][j+1].getText()==null)&&(l[i+1][j+1].getIcon()==null)&&((b[i+1][j+1].isVisible()==true)||(b[i+1][j+1].getIcon()==img)))     //bottom right
            {                
                if(b[i+1][j+1].getIcon()==null)
                b[i+1][j+1].setVisible(false);
                tileboom(i+1, j+1);
            }
    

        }

                    tileopen(i, j);
                    return;


    }

    public void newgame()                                   //resetting of bombs and numbers for a new game
    {
        
        for(i=0;i<15;i++)               //deleting all icons
        {
            for(j=0;j<12;j++)
            {
                l[i][j].setIcon(null);
                l[i][j].setText(null);
                b[i][j].setIcon(null);
                b[i][j].setVisible(true);
            }
        }
        
        bom=r.nextInt(15, 41);
        for(i=0;i<bom;i++)                  //adding bombs
        {
            bi=r.nextInt(15);
            bj=r.nextInt(12);
            if(l[bi][bj].getIcon()!=bomb)
            l[bi][bj].setIcon(bomb);
            else
            i--;
        }
        count=bom;
        t.setText(Integer.toString(count));
        if(bom<=23)
        level.setText("Level: EASY");
        if((bom>23)&&(bom<=30))
        level.setText("Level: MODERATE");
        if(bom>30)
        level.setText("Level: HARD");
        int num;
        for(i=0;i<15;i++)               //adding numbers
        {
            for(j=0;j<12;j++)
            {
                num=0;
                if((j!=0)&&(i!=0))
                {
                    if(l[i-1][j-1].getIcon()==bomb)
                    num++;    
                }
                if(i!=0)
                {
                    if(l[i-1][j].getIcon()==bomb)
                    num++;    
                }
                if((j!=11)&&(i!=0))
                {
                    if(l[i-1][j+1].getIcon()==bomb)
                    num++;    
                }
                if(j!=0)
                {
                    if(l[i][j-1].getIcon()==bomb)
                    num++;    
                }
                if(j!=11)
                {
                    if(l[i][j+1].getIcon()==bomb)
                    num++;    
                }
                if((j!=0)&&(i!=14))
                {
                    if(l[i+1][j-1].getIcon()==bomb)
                    num++;    
                }
                if(i!=14)
                {
                    if(l[i+1][j].getIcon()==bomb)
                    num++;    
                }
                if((j!=11)&&(i!=14))
                {
                    if(l[i+1][j+1].getIcon()==bomb)
                    num++;    
                }

                if(num!=0)
                l[i][j].setText(Integer.toString(num));
                else
                l[i][j].setText(null);
                l[i][j].setForeground(Color.gray);
                numbercolour(i, j, num);
            }
        }

    }

    public void mouseClicked(MouseEvent e)                  //interactivity
    {
        win=0;
        
        for(i=0;i<15;i++)
        {
            for(j=0;j<12;j++)
            {
                
                if((e.getSource()==b[i][j])&&(e.isMetaDown()))          //flag
                {
                    if(b[i][j].getIcon()==img)
                    {
                        b[i][j].setIcon(null);
                        count++;
                    }
                    else
                    {
                        b[i][j].setIcon(img);
                        count--;        
                    }
                }

                else if((e.getSource()==b[i][j])&&(b[i][j].getIcon()!=img))
                {
                b[i][j].setVisible(false);
                if(l[i][j].getIcon()==bomb)
                {
                    for(m=0;m<15;m++)
                    {
                        for(n=0;n<12;n++)
                        {
                            if(l[m][n].getIcon()==bomb)
                            b[m][n].setVisible(false);
                        }
                    }
                    go.setText("GAME OVER, Replay?");
                    g.setVisible(true);
                }
                if((l[i][j].getText()==null)&&(l[i][j].getIcon()==null))
                {
                    tileboom(i, j);
                }
                
            }

                else if(e.getSource()==c)                   //quit button
                {
                    ((JFrame) g).dispose();
                    ((JFrame) f).dispose();        
                }

                else if(e.getSource()==rep)             //replay button
                {
                newgame();
                clear=0;
                flag=0;
                }
                
                if((l[i][j].getIcon()==bomb)&&(b[i][j].getIcon()==img))
                {
                    win++;
                }
                t.setText(Integer.toString(count));
            }
        }

        if(clear==1)
        flag=1;
        else if (clear==0)
        flag=0;

        if(e.getSource()==yes)          //yes button
        {
            g.setVisible(false);
            count=0;
            newgame(); 
        }
        if(e.getSource()==no)           //no button
        {
            ((JFrame) g).dispose();
            ((JFrame) f).dispose();
        }
        if((win==bom)&&(count==0))
        {
            go.setText("YOU WIN! Play Again?");
            g.setVisible(true);
        }
    }
    public void mousePressed(MouseEvent e) {
    }
    public void mouseReleased(MouseEvent e) {
    }
    public void mouseEntered(MouseEvent e) {
    }
    public void mouseExited(MouseEvent e) {
    }
    public static void main(String[] args) {                 //main method
        minesweeper m= new minesweeper();
        
    }

}

   
    

