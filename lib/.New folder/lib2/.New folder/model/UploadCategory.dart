
///-----------------------------Days--------------------------//
class UploadDays {

  String day;
  String price;

  UploadDays({this.day,this.price,} );


  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['price'] = this.price;
    return data;
  }






}

///------------------------------------------Descriptions---------------------------------//
class UploadDescriptions {

  String key;
  String value;

  UploadDescriptions(
      {
        this.key,
        this.value,}
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}

///------------------------------------- List Images ---------------------------//

class UploadImages {


  String image;


  UploadImages({this.image});


   Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['image'] = this.image;

    return data;
  }
}
