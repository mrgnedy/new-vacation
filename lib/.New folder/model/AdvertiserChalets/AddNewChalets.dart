import 'dart:core';



class DaysAndPrice
{

  String day;
  String price;
  DaysAndPrice(this.day,this.price);

  Map<String, dynamic> TojsonData()
  {
    var map = new Map<String, dynamic>();
    map["day"] = day;
    map["price"]=price;
    return map;
  }

}

class ImageChalets
{
  String image;

  ImageChalets(this.image);

  Map<String, dynamic> TojsonData()
  {
    var map = new Map<String, dynamic>();
    map["image"] = image;
    return map;
  }
}