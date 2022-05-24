Table data;
PShape worldMap;
PShape location;
Slide[] slides;
int currentSlide;
Button nextBtn;

void setup ()
{
    //Set screen size
    int WIDTH = 1300;
    int HEIGHT = 700;
    size(1300, 700);
    
    //Initialize
    currentSlide = 0;
    data = loadTable("countries.csv", "header");
    worldMap = loadShape("world.svg");
    location = loadShape("location.svg");
    slides = new Slide[3];
    nextBtn = new Button(0,"Next Slide", WIDTH - (WIDTH * 0.1), HEIGHT - (HEIGHT * 0.1), 100, 50, null);
       
    //Add new slides
    slides[0] = new Slide("SuicideCount", 5, new Color(new int[] {255, 89, 0}), location, "","Suicide count", "Suicide count per country, 2009","The above map shows the suicide rate in 2009, and sets forth that Russia has the highest rate of suicide. It appears\nfrom the maps that while Russia has less population than the United States, it has the highest suicide rate.");
    slides[1] = new Slide("Population", 5, new Color(new int[] {0, 182, 255}), location, "M", "Population count (Million)", "Population count per country, 2009","The maps regarding population, show Brazil has the second highest population, however, their suicide rate is comparatively\nlow compared to the United States. One can deduce from the maps that high population doesn't mean high suicide rate.");
    slides[2] = new Slide("GDP", 5, new Color(new int[] {158, 0, 175}),location, "B","GDP count (Billion)", "GDP count per country, 2009","From this map we can conclude that while Japan and Germany have a high GDP, they do not show the highest population as with\nRussia and Brazil. In examination of the maps, one can get a clear picture of the overall success & failure of a particular country.");   
    
    frameRate(30);
}

void draw ()
{
  //Current window width and height
  int WIDTH = 1300;
  int HEIGHT = 700;
    
  //Get current slide
  int currSlide = currentSlide;
  Slide currentSlide = slides[currSlide]; //<>//
  
  if(currentSlide.getRenderFlag()){
    //Set background color
    background(255);
    
    //Draw title
    currentSlide.drawTitle((WIDTH-(WIDTH * 0.6)), 30);
    
    //Draw description
    currentSlide.drawDescription(WIDTH-(WIDTH * 0.98), HEIGHT-(HEIGHT * 0.1));
    
    //Clear and draw map
    currentSlide.drawMap(worldMap, data);
    positionMap();
    
    //Draw legend
    currentSlide.drawLegend(WIDTH, HEIGHT);
    
    //Draw button
    nextBtn.drawButton();
    
    //stop drawing
    currentSlide.setRenderFlag(false);
  }
}

//When mouse is pressed
void mousePressed() {
  int WIDTH = 1300;
  int HEIGHT = 700;
  
  //Check legend buttons
  int currSlide = currentSlide;
  Slide currentSlide = slides[currSlide];
  
  if (nextBtn.mouseIsOver()) {
    //Next button clicked
    currentSlide.setRenderFlag(true);
    updateCurrentSlideCount();
  } else if (currentSlide.getShowAllData() != null && currentSlide.getShowAllData().mouseIsOver()) { //<>//
    //Show all button clicked
    currentSlide.setRenderFlag(true);
  }
   
  for(int i = 0; i < currentSlide.getLegendButtons().length; i++) {
    if(currentSlide.getLegendButtons()[i].mouseIsOver()) {
      //Location button clicked
      currentSlide.onLegendButtonClick(currentSlide.getLegendButtons()[i].id, worldMap, WIDTH, HEIGHT);
    }
  }
}

//Update current slide count
void updateCurrentSlideCount(){
  if(currentSlide == slides.length - 1){
    currentSlide = 0;
  } else {
    currentSlide++;
  }
}

//Position the world map
void positionMap() {
  int WIDTH = 1300;
  int HEIGHT = 700;
  shape(worldMap, (WIDTH-(WIDTH * 0.9))/2, (HEIGHT-(HEIGHT * 0.85))/2, WIDTH * 0.7, HEIGHT * 0.8);
}
