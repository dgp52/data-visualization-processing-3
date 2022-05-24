//Custom color class
class Color{
  
  //Store RGB
  int[] c;
  
  //Constructor
  Color(int[] customColor){
    c = customColor;
  }
  
  //Get color based on bin index
  color getColor(int index){
    int[] result = new int[3];
    //create a new color based on the bin index
    for(int i = 0; i < c.length; i++){ //<>//
      if(c[i] != 0){
        result[i] = c[i] + (index * -30);
      }
    }
    return color(result[0], result[1], result[2]);
  }
}
