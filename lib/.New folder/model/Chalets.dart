//class Chalets {
//  Data data;
//  String status;
//  Null error;
//
//  Chalets({this.data, this.status, this.error});
/////----- Chalets.fromJson(re)
// factory Chalets.fromJson(Map<String, dynamic> json)
//  {
//  return  Chalets(data : json['data'] != null ? new Data.fromJson(json['data']) : null,
//             status : json['status'],
//              error : json['error']);
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    if (this.data != null) {
//      data['data'] = this.data.toJson();
//    }
//    data['status'] = this.status;
//    data['error'] = this.error;
//    return data;
//  }
//}
//
//class Data {
//  int id;
//  String name;
//  String startDate;
//  String endDate;
//  String startTime;
//  String endTime;
//  double lat;
//  double lng;
//  String kind;
//  String department;
//  int space;
//  int nightNumber;
//  String about;
//  List<String> restTools;
//  int bathrooms;
//  List<String> conditions;
//  int discount;
//  int cancel;
//  int userId;
//  String createdAt;
//  String updatedAt;
//  String averageRating;
//  List<Days> days;
//  List<Descriptions> descriptions;
//  List<Images> images;
//
//  Data(
//      {this.id,
//        this.name,
//        this.startDate,
//        this.endDate,
//        this.startTime,
//        this.endTime,
//        this.lat,
//        this.lng,
//        this.kind,
//        this.department,
//        this.space,
//        this.nightNumber,
//        this.about,
//        this.restTools,
//        this.bathrooms,
//        this.conditions,
//        this.discount,
//        this.cancel,
//        this.userId,
//        this.createdAt,
//        this.updatedAt,
//        this.averageRating,
//        this.days,
//        this.descriptions,
//        this.images});
//
// factory Data.fromJson(Map<String, dynamic> json) {
//
//
//    if (json['days'] != null)
//    {
//      days = new List<Days>();
//
//      json['days'].forEach((v)
//      {
//        days.add(new Days.fromJson(v));
//      });
//    }
//
//
//    if (json['descriptions'] != null) {
//      descriptions = new List<Descriptions>();
//      json['descriptions'].forEach((v) {
//        descriptions.add(new Descriptions.fromJson(v));
//      });
//    }
//    if (json['images'] != null)
//    {
//           images = new List<Images>();
//      json['images'].forEach((v) {
//        images.add(new Images.fromJson(v));
//      });
//    }
//
//
//    return Data(   id : json['id'],
//        name : json['name'],
//        startDate : json['startDate'],
//        endDate : json['endDate'],
//        startTime : json['startTime'],
//        endTime : json['endTime'],
//        lat : json['lat'],
//        lng : json['lng'],
//        kind : json['kind'],
//        department : json['department'],
//        space : json['space'],
//        nightNumber : json['nightNumber'],
//        about : json['about'],
//        restTools : json['restTools'].cast<String>(),
//    bathrooms : json['bathrooms'],
//    conditions : json['conditions'].cast<String>(),
//    discount : json['discount'],
//    cancel : json['cancel'],
//    userId : json['user_id'],
//    createdAt : json['created_at'],
//    updatedAt : json['updated_at'],
//    averageRating : json['average_rating'],);
//
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['id'] = this.id;
//    data['name'] = this.name;
//    data['startDate'] = this.startDate;
//    data['endDate'] = this.endDate;
//    data['startTime'] = this.startTime;
//    data['endTime'] = this.endTime;
//    data['lat'] = this.lat;
//    data['lng'] = this.lng;
//    data['kind'] = this.kind;
//    data['department'] = this.department;
//    data['space'] = this.space;
//    data['nightNumber'] = this.nightNumber;
//    data['about'] = this.about;
//    data['restTools'] = this.restTools;
//    data['bathrooms'] = this.bathrooms;
//    data['conditions'] = this.conditions;
//    data['discount'] = this.discount;
//    data['cancel'] = this.cancel;
//    data['user_id'] = this.userId;
//    data['created_at'] = this.createdAt;
//    data['updated_at'] = this.updatedAt;
//    data['average_rating'] = this.averageRating;
//    if (this.days != null) {
//      data['days'] = this.days.map((v) => v.toJson()).toList();
//    }
//    if (this.descriptions != null) {
//      data['descriptions'] = this.descriptions.map((v) => v.toJson()).toList();
//    }
//    if (this.images != null) {
//      data['images'] = this.images.map((v) => v.toJson()).toList();
//    }
//    return data;
//  }
//}
//
//class Days {
//  int id;
//  String day;
//  int price;
//  int chaletId;
//  String createdAt;
//  String updatedAt;
//
//  Days(
//      {this.id,
//        this.day,
//        this.price,
//        this.chaletId,
//        this.createdAt,
//        this.updatedAt});
//
//  Days.fromJson(Map<String, dynamic> json) {
//    id = json['id'];
//    day = json['day'];
//    price = json['price'];
//    chaletId = json['chalet_id'];
//    createdAt = json['created_at'];
//    updatedAt = json['updated_at'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['id'] = this.id;
//    data['day'] = this.day;
//    data['price'] = this.price;
//    data['chalet_id'] = this.chaletId;
//    data['created_at'] = this.createdAt;
//    data['updated_at'] = this.updatedAt;
//    return data;
//  }
//}
//
//class Descriptions {
//  int id;
//  String key;
//  int value;
//  int chaletId;
//  String createdAt;
//  String updatedAt;
//
//  Descriptions(
//      {this.id,
//        this.key,
//        this.value,
//        this.chaletId,
//        this.createdAt,
//        this.updatedAt});
//
//  Descriptions.fromJson(Map<String, dynamic> json) {
//    id = json['id'];
//    key = json['key'];
//    value = json['value'];
//    chaletId = json['chalet_id'];
//    createdAt = json['created_at'];
//    updatedAt = json['updated_at'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['id'] = this.id;
//    data['key'] = this.key;
//    data['value'] = this.value;
//    data['chalet_id'] = this.chaletId;
//    data['created_at'] = this.createdAt;
//    data['updated_at'] = this.updatedAt;
//    return data;
//  }
//}
//
//class Images {
//  int id;
//  String image;
//  int chaletId;
//  String createdAt;
//  String updatedAt;
//
//  Images({this.id, this.image, this.chaletId, this.createdAt, this.updatedAt});
//
//  Images.fromJson(Map<String, dynamic> json) {
//    id = json['id'];
//    image = json['image'];
//    chaletId = json['chalet_id'];
//    createdAt = json['created_at'];
//    updatedAt = json['updated_at'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['id'] = this.id;
//    data['image'] = this.image;
//    data['chalet_id'] = this.chaletId;
//    data['created_at'] = this.createdAt;
//    data['updated_at'] = this.updatedAt;
//    return data;
//  }
//}
