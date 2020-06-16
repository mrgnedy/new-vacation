class CititesModel {
  List<City> data;
  String status;
  String error;

  CititesModel({this.data, this.status, this.error});

  CititesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<City>();
      json['data'].forEach((v) {
        data.add(new City.fromJson(v));
      });
    }
    status = json['status'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['error'] = this.error;
    return data;
  }
}

class City {
  int id;
  String city;
  String createdAt;
  String updatedAt;

  City({this.id, this.city, this.createdAt, this.updatedAt});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['city'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city'] = this.city;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
