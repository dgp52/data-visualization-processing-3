//This class holds country and value information
class CountryAttribute {
    String countryCode;
    int intAttribute;
    String country;
    
    //Constructor
    CountryAttribute(String code, String countryName, int attr) {
      countryCode = code;
      country = countryName;
      intAttribute = attr;
    }
    
    String getCountryCode() {
      return countryCode;
    }
    
    String getCountryName() {
      return country;
    }
    
    int getAttributeValue() {
      return intAttribute;
    }
}
