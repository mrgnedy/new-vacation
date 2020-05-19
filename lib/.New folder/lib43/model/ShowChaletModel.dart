class ShowChalet {
  Data data;
  String status;
  Null error;
  int rate;
  int chaletStatus;
  ShowChalet({this.data, this.status, this.error, this.chaletStatus});

  ShowChalet.fromJson(Map<String, dynamic> json) {
    data = (json['data']['all']) !=null ? new Data.fromJson(json['data']['all']) : null;
    status = json['status'];
    error = json['error'];
    rate = json['data']['rate'];
    chaletStatus = json['data']['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data']['all'] = this.data.toJson();
    }
    // data['data']['rate'] = this.rate;
    data['status'] = this.status;
    data['error'] = this.error;
    return data;
  }
}

class Data {
  Chalet chalet;
  // int rate;
  List commentRate;
  Data({this.chalet,
  this.commentRate,
  //  this.rate
   });

  Data.fromJson(Map<String, dynamic> json) {
    chalet =
        json['chalet'] != null ? new Chalet.fromJson(json['chalet']) : null;
    commentRate = json['rates'];
    // rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chalet != null) {
      data['chalet'] = this.chalet.toJson();
    }
    // data['rate'] = this.rate;
    return data;
  }
}

class Chalet {
  int id;
  // List commentAndRate;
  String advName;
  String advEmail;
  String advNum;
  String name;
  String startDate;
  String endDate;
  String startTime;
  String endTime;
  double lat;
  double lng;
  String kind;
  String department;
  int space;
  int nightNumber;
  String about;
  List<String> restTools;
  int bathrooms;
  List<String> conditions;
  int discount;
  int cancel;
  int userId;
  String createdAt;
  String updatedAt;
  List additions;
  List<Days> days;
  List<Descriptions> descriptions;
  List<Images> images;

  Chalet(
      {this.id,
      // this.advEmail,
      this.name,
      // this.commentAndRate,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.lat,
      this.lng,
      this.kind,
      this.department,
      this.space,
      this.nightNumber,
      this.about,
      this.restTools,
      this.bathrooms,
      this.conditions,
      this.discount,
      this.cancel,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.days,
      this.descriptions,
      this.images});

  Chalet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    advEmail = json['user']['email']; //add
    advNum = json['user']['phone'].toString(); //add
    advName = json['user']['name']; //add
    name = json['name'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    lat = json['lat'];
    lng = json['lng'];
    kind = json['kind'];
    department = json['department'];
    space = json['space'];
    nightNumber = json['nightNumber'];
    about = json['about'];
    restTools = json['restTools'].cast<String>();
    bathrooms = json['bathrooms'];
    conditions = json['conditions'].cast<String>();
    discount = json['discount'];
    cancel = json['cancel'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    additions = json['additions'];
    // commentAndRate = json['rates']; //added

    // List.generate(json['comment_rate'].length, (index) {
    //   final Map comment = json['comment_rate'][index];
    //   return {'comment': comment['comment'], 'rate': comment['rate']};
    // });
    if (json['days'] != null) {
      days = new List<Days>();
      json['days'].forEach((v) {
        days.add(new Days.fromJson(v));
      });
    }
    if (json['descriptions'] != null) {
      descriptions = new List<Descriptions>();
      json['descriptions'].forEach((v) {
        descriptions.add(new Descriptions.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['kind'] = this.kind;
    data['department'] = this.department;
    data['space'] = this.space;
    data['nightNumber'] = this.nightNumber;
    data['about'] = this.about;
    data['restTools'] = this.restTools;
    data['bathrooms'] = this.bathrooms;
    data['conditions'] = this.conditions;
    data['discount'] = this.discount;
    data['cancel'] = this.cancel;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    // data['comment_rate'] = this.commentAndRate;
    // data['advertiser_id'] = this.advEmail;
    if (this.days != null) {
      data['days'] = this.days.map((v) => v.toJson()).toList();
    }
    if (this.descriptions != null) {
      data['descriptions'] = this.descriptions.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Days {
  int id;
  String day;
  int price;
  int chaletId;
  String createdAt;
  String updatedAt;

  Days(
      {this.id,
      this.day,
      this.price,
      this.chaletId,
      this.createdAt,
      this.updatedAt});

  Days.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day = json['day'];
    price = json['price'];
    chaletId = json['chalet_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['day'] = this.day;
    data['price'] = this.price;
    data['chalet_id'] = this.chaletId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Descriptions {
  int id;
  String key;
  int value;
  int chaletId;
  String createdAt;
  String updatedAt;

  Descriptions(
      {this.id,
      this.key,
      this.value,
      this.chaletId,
      this.createdAt,
      this.updatedAt});

  Descriptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
    chaletId = json['chalet_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['value'] = this.value;
    data['chalet_id'] = this.chaletId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Images {
  int id;
  String image;
  int chaletId;
  String createdAt;
  String updatedAt;

  Images({this.id, this.image, this.chaletId, this.createdAt, this.updatedAt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    chaletId = json['chalet_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['chalet_id'] = this.chaletId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
