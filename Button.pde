class Button {
  String label;
  float x;
  float y;
  float w;
  float h;
  PShape icon;
  int id;
  
  //Constructor
  Button(int btnId, String labelB, float xpos, float ypos, float widthBtn, float heightBtn, PShape btnIcon) {
    id = btnId;
    label = labelB;
    x = xpos;
    y = ypos;
    w = widthBtn;
    h = heightBtn;
    icon = btnIcon;
  }
  
  //Draw the button
  void drawButton() {
    fill(218);
    stroke(141);
    rect(x, y, w, h, 1);
    
    if(icon != null) {
      shape(icon, x+(w/99), y+(h/99), w*0.99, h*0.99);
    } else {
      textSize(15);
      textAlign(CENTER, CENTER);
      fill(0);
      text(label, x+(w/2), y+(h/2));
    }
  }
  
  //Check if mouse is over this button
  boolean mouseIsOver() {
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {
      return true;
    }
    return false;
  }
}
