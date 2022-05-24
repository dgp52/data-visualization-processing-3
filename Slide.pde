//This class holds the slide, legend, bins 
class Slide {
  
  String title;
  String legendTitle;
  String description;
  String attribute;
  String unit;
  int binc;
  Bin[] bins;
  Button[] buttons;
  Button showAllData;
  Color cl;
  PShape icon;
  boolean renderFlag;
  
  //Constructor
  Slide(String attr, int binCount, Color c, PShape btnIcon, String legendUnit, String lTitle, String slideTitle, String slideDescription) {
    title = slideTitle;
    description = slideDescription;
    attribute = attr;
    binc = binCount;
    bins = new Bin[binCount];
    buttons = new Button[binCount];
    cl = c;
    legendTitle = lTitle;
    icon = btnIcon;
    renderFlag = true;
    unit = legendUnit;
  }
  
  //Draw title
  void drawTitle(float x, float y){
    textSize(30);
    fill(0,0,0);
    textAlign(CENTER, CENTER);
    text(title, x, y);
  }
  
  //Draw description
  void drawDescription(float x, float y){
    textSize(18);
    fill(0,0,0);
    textAlign(LEFT, CENTER);
    text(description, x, y);
  } //<>//
  
  //Draw map
  void drawMap(PShape map, Table data){ //<>//
    clearMap();
    ComputeDrawMap(map, data); //<>//
  }
  
  //Sort, compute bins, and determine color
  void ComputeDrawMap(PShape map, Table data) {
    //Get all rows associated with the current attribute
    CountryAttribute[] attributeRows = new CountryAttribute[data.getRowCount()];
    for(int i = 0; i < data.getRowCount(); i++){
      attributeRows[i] = new CountryAttribute( data.getRow(i).getString("CountryCode"), data.getRow(i).getString("Country"), data.getRow(i).getInt(attribute));
    }
    
    //Sort objects by value
    int n = attributeRows.length;  
    for (int j = 1; j < n; j++) {  
        CountryAttribute k = attributeRows[j];  
        int i = j-1;  
        while ((i > -1) && (attributeRows[i].getAttributeValue() > k.getAttributeValue())) {  
            attributeRows[i+1] = attributeRows[i];  
            i--;  
        }  
        attributeRows[i+1] = k;  
    }
   
    //Divide based on bins
    //Only support even parts
    int parts = attributeRows.length % binc;
    if(parts == 0){
      int start = 0;
      int end = attributeRows.length/binc;
      for(int i = 0; i < binc; i++){
         bins[i] = new Bin();
         for(int x = 0; x <= end-start-1; x++){
           bins[i].getAttributes().add(attributeRows[x+start]);
         }
         start = end;
         end = end + attributeRows.length/binc;
      } 
     }
     
     //Determine Color
     for(int i = 0; i < bins.length; i++) {
       bins[i].setColor(cl.getColor(i));
     }
     
     //Color map based on computed color
     colorBinMap(map);
  }
  
  //Draw legend
  void drawLegend(float w, float h) {
    float x = w-(w*0.23);
    float y = h-(h*0.9);
    float recWidth = w-(w*0.8);
    float recHeight =  h-(h*0.25);
    
    //Legend Container
    fill(218);
    stroke(141);
    rect(x, y, recWidth, recHeight, 1);
    
    //Legend Title
    textSize(20);
    fill(0,0,0);
    textAlign(CENTER, CENTER);
    text(legendTitle, w-(w*0.13), h-(h*0.93));
    
    //Show Bins
    int rectSize = 20;
    for(int i = 0; i < bins.length; i++){
      //Add icons
      buttons[i] = new Button(i, null, x + 10 , y + (10 + (30 * i)), rectSize, rectSize, icon);
      buttons[i].drawButton();
      
      //Rectangle bins
      fill(bins[i].getColor());
      rect(x + (40), y + (10 + (30 * i)), rectSize, rectSize, 1);
      
      //Labels
      textSize(20);
      fill(0,0,0);
      textAlign(LEFT, CENTER);
      text(bins[i].getAttributes().get(0).getAttributeValue() + " - " + bins[i].getAttributes().get(bins[i].getAttributes().size() - 1).getAttributeValue() + unit, 
      x + 70, y + (18 + (30 * i)));
      
      if(i == bins.length-1){
        //No data
        fill(color(181,181,181));
        rect(x + (40), y + (10 + (30 * (i+1))), rectSize, rectSize, 1);
        
        //Labels
        textSize(20);
        fill(0,0,0);
        textAlign(LEFT, CENTER);
        text("No data available", x + 70, y + (18 + (30 * (i + 1))));
      }
    }
    
    //Available feature label
    textSize(15);
    fill(0,0,0);
    textAlign(LEFT, BOTTOM);
    text("Available Features:\n" + 
    "\"Next Slide\" button click toggle \n slides. \n" + 
    "Click location icon to see specific \ncountries.\n" +
    "Click \"Show all\" to see all data.", x + 10, y + recHeight - 10);
    
  }
    
  //Color map based on its color
  void colorBinMap(PShape worldMap){
    for(int i = 0; i < bins.length; i++){
      for(int j = 0; j < bins[i].getAttributes().size(); j++){
        CountryAttribute c = bins[i].getAttributes().get(j);
        PShape s = worldMap.getChild(c.getCountryCode());
        s.setFill(bins[i].getColor());
      }
    }
  }
  
  //When location buttons on legend gets clicked
  void onLegendButtonClick(int btnid, PShape worldMap, float w, float h){
    renderFlag = false;
    Bin currentBin = bins[btnid];
    clearMap();
    
    //Draw half container to hide labels
    fill(218);
    rect(w-(w*0.225), h-(h*0.60), w-(w*0.81), (h-(h*0.3))/5, 1);
    
    for(int i = 0; i < currentBin.getAttributes().size(); i++){
        PShape s = worldMap.getChild(currentBin.getAttributes().get(i).getCountryCode()); //<>//
        s.setFill(currentBin.getColor());
        
        //Show detailed info
        textSize(17);
        fill(0,0,0);
        textAlign(LEFT, CENTER);
        text(currentBin.getAttributes().get(i).getCountryName() + ": " + currentBin.getAttributes().get(i).getAttributeValue() + unit, w-(w*0.22), h-(h * 0.5 + (i * 30)));   

        if(i == currentBin.getAttributes().size()-1) {
          showAllData = new Button(-1, "Show all", w-(w*0.225), h-(h * 0.5 + (i * 30)) + (h * 0.13), w-(w*0.81), (h-(h*0.8))/4, null);
          showAllData.drawButton();
        }
    }
    positionMap();
  }
  
  //Clear entire map
  void clearMap() {
    for(int i = 0; i < worldMap.getChildCount(); i++){
      PShape ps = worldMap.getChild(i);
      ps.setFill(color(181,181,181));
    }
    positionMap();
  }  
  
  //Getters and Setters
  String getTitle(){
    return title;
  }
  
  String getDescription() {
    return description;
  }
  
  Button[] getLegendButtons(){
    return buttons;
  }
  
  Button getShowAllData() {
    return showAllData;
  }
  
  boolean getRenderFlag() {
    return renderFlag;
  }
  
   void setRenderFlag(boolean flag) {
    renderFlag = flag;
  }
}
