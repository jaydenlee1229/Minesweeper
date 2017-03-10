import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 30;
public final static int NUM_COLS = 30;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined
private boolean gameOver = false;
void setup ()
{
    size(600, 600);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int i = 0; i < NUM_ROWS; i++)
    {
        for(int j = 0; j < NUM_COLS; j++)
        {
            buttons[i][j] = new MSButton(i, j);
        }
    }
    while(bombs.size() < 151)
    {
        setBombs();
    }
}
public void setBombs()
{
    int row = (int)(Math.random() * NUM_ROWS);
    int col = (int)(Math.random() * NUM_COLS);
    if(!bombs.contains(buttons[row][col]))
    {
        bombs.add(buttons[row][col]);
    }
}
public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    for(int i = 0; i < NUM_ROWS; i++)
    {
        for(int j = 0; j < NUM_COLS; j++)
        {
            if(bombs.contains(buttons[i][j]) && !buttons[i][j].marked)
            {
                return false;
            }
        }
    }
    return true;
}
public void displayLosingMessage()
{
    //your code here
    buttons[14][11].setLabel("Y");
    buttons[14][12].setLabel("O");
    buttons[14][13].setLabel("U");
    buttons[14][15].setLabel("L");
    buttons[14][16].setLabel("O");
    buttons[14][17].setLabel("S");
    buttons[14][18].setLabel("E");
}
public void displayWinningMessage()
{
    //your code here

    
    buttons[14][11].setLabel("Y");
    buttons[14][12].setLabel("O");
    buttons[14][13].setLabel("U");
    buttons[14][15].setLabel("W");
    buttons[14][16].setLabel("I");
    buttons[14][17].setLabel("N");
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;

    public MSButton ( int rr, int cc )
    {
        width = 600/NUM_COLS;
        height = 600/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        if(gameOver == true)
        {
            return;
        }
        clicked = true;
        if(keyPressed)
        {
            marked = !marked;
            if(marked == false)
            {   
                clicked = false;
            }
        }
        else if(bombs.contains(this))
        {
            gameOver = true;
            displayLosingMessage();
        }
        else if(countBombs(r, c) > 0)
        {
            setLabel("" + countBombs(r, c));
        }
        else
        {
            if(isValid(r - 1, c - 1) && buttons[r - 1][c - 1].clicked == false)
            {
                buttons[r - 1][c - 1].mousePressed();
            }
            if(isValid(r - 1, c) && buttons[r - 1][c].clicked == false)
            {
                buttons[r - 1][c].mousePressed();
            }
            if(isValid(r - 1, c + 1) && buttons[r - 1][c + 1].clicked == false)
            {
                buttons[r - 1][c + 1].mousePressed();
            }
            if(isValid(r, c - 1) && buttons[r][c - 1].clicked == false)
            {
                buttons[r][c - 1].mousePressed();
            }
            if(isValid(r, c + 1) && buttons[r][c + 1].clicked == false)
            {
                buttons[r][c + 1].mousePressed();
            }
            if(isValid(r + 1, c - 1) && buttons[r + 1][c - 1].clicked == false)
            {
                buttons[r + 1][c - 1].mousePressed();
            }
            if(isValid(r + 1, c) && buttons[r + 1][c].clicked == false)
            {
                buttons[r + 1][c].mousePressed();
            }
            if(isValid(r + 1, c + 1) && buttons[r + 1][c + 1].clicked == false)
            {
                buttons[r + 1][c + 1].mousePressed();
            }
        }
    }
    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this)) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill(r*5, c*5, mouseX);

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
        {
            return true;
        }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(row - 1, col - 1) && bombs.contains(buttons[row - 1][col - 1]))
        {
                numBombs++;
        }
        if(isValid(row - 1, col) && bombs.contains(buttons[row - 1][col]))
        {
                numBombs++;
        }
        if(isValid(row - 1, col + 1) && bombs.contains(buttons[row - 1][col + 1]))
        {
                numBombs++;
        }
        if(isValid(row, col - 1) && bombs.contains(buttons[row][col - 1]))
        {
                numBombs++;
        }
        if(isValid(row, col + 1) && bombs.contains(buttons[row][col + 1]))
        {
                numBombs++;
        }
        if(isValid(row + 1, col - 1) && bombs.contains(buttons[row + 1][col - 1]))
        {
                numBombs++;
        }
        if(isValid(row + 1, col) && bombs.contains(buttons[row + 1][col]))
        {
                numBombs++;
        }
        if(isValid(row + 1, col + 1) && bombs.contains(buttons[row + 1][col + 1]))
        {
                numBombs++;
        }
        return numBombs;
    }
}



