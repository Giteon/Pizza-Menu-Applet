/**************
 Pizza_Hut_Concept_Applet
 Gideon Fox
 Mobiquity
/**************
 
 
/*Decl. Images*/
PImage orderPizza, orderWings, 
pizzaHutLogo, backArrow, 
backArrowBig, OR, 
wingstreetWings, 
salads, sandwiches, 
sides, desserts, 
createOwn, chooseRecipie, 
smallPizza, mediumPizza, largePizza;
/**/

String screen; /*the current screen*/
private ArrayList <Button> buttons = new ArrayList <Button>();
Button arrowBig;

void setup()
{
  size(600, 400);
  screen = "pizzaOrWings";

  /*Init. Main Screen Images*/
  orderPizza = loadImage("data/orderPizza.png");
  orderWings = loadImage("data/orderWings.png");

  /*Init. Misc Images*/
  pizzaHutLogo = loadImage("data/pizzaHutLogo.png");
  backArrow = loadImage("data/backArrow.PNG");
  backArrowBig = loadImage("data/backArrowBig.PNG");
  OR = loadImage("data/OR.png");
  /**/

  /*Init. Wings & Things Images*/
  wingstreetWings = loadImage("data/wingstreetWings.png");
  salads = loadImage("data/salads.png");
  sandwiches = loadImage("data/sandwiches.png");
  sides = loadImage("data/sides.png");
  desserts = loadImage("data/desserts.png");
  /**/

  /*Init Pizza Images*/
  chooseRecipie = loadImage("data/chooseRecipie.png");
  createOwn = loadImage("data/createOwn.png");
  smallPizza = loadImage("data/smallPizza.png.png");
  mediumPizza = loadImage("data/mediumPizza.png.png");
  largePizza = loadImage("data/largePizza.png.png");
  /**/

  /*Init. guarenteed buttons*/
  buttons.add(new Button(orderPizza, (width/2)-(orderPizza.width/2), 110)); /*index 0*/
  buttons.add(new Button(orderWings, (width/2)-(orderWings.width/2), 245)); /*index 1*/
  arrowBig = new Button(backArrowBig, 3, 354);
  /**/
}
void draw()
{
  background(32);

  /*call the functions for all objects in the buttons ArrayList*/
  for (int i = 0; i < buttons.size (); i ++)
  {
    buttons.get(i).showImage();
    buttons.get(i).showOutline();
    buttons.get(i).mouseClicked();
  }
  /**/

  /*Displays the back arrow*/
  if ( screen != "pizzaOrWings" ) /*can't go back if on first screen*/
  {
    if ( (mouseX <= (3 + (backArrowBig.width/2))) && (mouseY >= 362) ) /*shows big arrow if mouse hovering*/
    {
      arrowBig.showImage();
      arrowBig.mouseClicked();
    } else
    {
      image(backArrow, 3, 362); /*show image of small arrow*/
    }
  }
  /**/

  /*Logo at top of screen*/
  image(pizzaHutLogo, (width/2)-(pizzaHutLogo.width/2), 8);

  /*displays 'OR' image if on first pizza screen*/
  if (screen == "pizza")
  {
    image(OR, (width/2)-(OR.width/2), 195);
  }
  /**/
}
void clearButtons()
{
  for (int i = 0; i < buttons.size (); i ++)
  {
    buttons.remove(i);
    i-=1;
  }
}
public class Button
{
  private int posX, posY, outlineL, outlineW;
  private boolean clicked, isClicked, withinBox;
  private PImage image;

  public Button(PImage img, int x, int y)
  {
    posX = x;
    posY = y;
    outlineL = img.width; /*dimensions of the white outlined box around each button are based on the dimensions of the image*/
    outlineW = img.height;
    image = img;
  }
  /**/
  /**/
  public boolean withinOutline() /*checks if the mouse is within the borders of the button*/
  {
    if ( (mouseX >= posX) && (mouseX <= posX + outlineL) && (mouseY >= posY) && (mouseY <= posY + outlineW) )
    {
      return true;
    }
    return false;
  }

  /**/
  public void showImage()
  {
    /**/
    image(image, posX, posY);
  }
  public void showOutline()
  {
    if (withinOutline())
    {
      strokeWeight(3); /*outline is thicker if mouse is hovering*/
    } else
    {
      strokeWeight(1);
    }
    noFill();
    stroke(255);
    if (screen == "chooseSize")
    {
      ellipse(posX+outlineL/2, posY+outlineW/2, outlineL, outlineL);
    } else
    {
      rect(posX, posY, outlineL, outlineW);
    }
  }
  public void mouseClicked()
  {
    if (mousePressed && withinOutline())
    {
      isClicked = true;
      newButtons(); /*Calls the newButtons() function, which checks if the clickage that just occured is valid, and whether a new screen should be created*/
      //      print(screen);
      //      println(buttons.size()); /*For some reason, when the mouse is clicked, the mouseClicked() function is running more than once-->need to fix*/
    }
  }
  public boolean getIsClicked() /*since the newButtons() function is called in the mouseClicked() function, a separate boolean function is needed to return the specific details of which button was clicked when it is called by newButtons()*/
  {
    if (isClicked)
    {
      isClicked = false;
      return true;
    }
    return false;
  }
  public void newButtons() /*If clickage was valid, based on current conditions (current screen, which button was clicked), clear the current buttons, make new ones, and change 'screen'*/
  {
    /**********************************************************************/
    if (screen == "pizzaOrWings")
    {

      if (buttons.get(0).getIsClicked()) /*Pizza*/
      {
        clearButtons();

        buttons.add(new Button(createOwn, (width/2)-(createOwn.width/2), 115));
        buttons.add(new Button(chooseRecipie, (width/2)-(chooseRecipie.width/2), 268));
        screen = "pizza";
      } else if (buttons.get(1).getIsClicked()) /*Wings & Things*/
      {
        clearButtons();
        buttons.add(new Button(wingstreetWings, (width/2)-(wingstreetWings.width/2), 100));
        buttons.add(new Button(salads, 67, 169));
        buttons.add(new Button(sandwiches, 244, 170));
        buttons.add(new Button(sides, 328, 239));
        buttons.add(new Button(desserts, 92, 241));
        screen = "wingsAndThings";
      }
    }
    /*******************************************************/
    else if (screen == "pizza")
    {
      if (buttons.get(0).getIsClicked()) /*make your own*/
      {
        //switch to pizza maker app
      } else if (buttons.get(1).getIsClicked()) /* choose a recipie */
      {
        clearButtons();

        buttons.add(new Button(smallPizza, 50, 200));
        buttons.add(new Button(mediumPizza, 230, 200));
        buttons.add(new Button(largePizza, 410, 200));

        screen = "chooseSize";
      }

      if (arrowBig.getIsClicked()) /*back arrow must have been clicked*/
      {
        clearButtons();

        buttons.add(new Button(orderPizza, (width/2)-(orderPizza.width/2), 110)); /*index 0*/
        buttons.add(new Button(orderWings, (width/2)-(orderWings.width/2), 245)); /*index 1*/
        screen = "pizzaOrWings";
      }
    }
    /**************************************************/
    else if (screen == "wingsAndThings")
    {
      if (buttons.get(0).getIsClicked()) /*make your own*/
      {
        clearButtons();
      } else if (buttons.get(1).getIsClicked()) /* choose a recipie */
      {
        clearButtons();
      }

      if (arrowBig.getIsClicked()) /*back arrow must have been clicked*/
      {
        clearButtons();

        buttons.add(new Button(orderPizza, (width/2)-(orderPizza.width/2), 110)); /*index 0*/
        buttons.add(new Button(orderWings, (width/2)-(orderWings.width/2), 245)); /*index 1*/
        screen = "pizzaOrWings";
      }
    }


    /***********************************************/
    else if (screen == "chooseSize")
    {
      if (arrowBig.getIsClicked())
      {
        clearButtons();
        buttons.add(new Button(createOwn, (width/2)-(createOwn.width/2), 115));
        buttons.add(new Button(chooseRecipie, (width/2)-(chooseRecipie.width/2), 268));
        screen = "pizza";
        
      }
    }
  }
}

