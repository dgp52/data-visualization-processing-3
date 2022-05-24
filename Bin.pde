class Bin{
  String label;
  color c;
  ArrayList<CountryAttribute> ca;

  //Constructor
  Bin() {
    ca = new ArrayList<CountryAttribute>();
  }
  
  //Each bin contains a list of attributes
  ArrayList<CountryAttribute> getAttributes(){
    return ca;
  }
    
  color getColor(){
    return c;
  }
  
  void setLabel(String l) {
    label = l;
  }
  
  void setColor(color cl){
    c = cl;
  }
}
