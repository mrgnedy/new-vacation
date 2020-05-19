///--------------------------------------Chalit Avilable--------------------------//
class SuccessAvailable {
  Data data;
  String status;
  Null error;

  SuccessAvailable({this.data, this.status, this.error});

  SuccessAvailable.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['status'] = this.status;
    data['error'] = this.error;
    return data;
  }
}

class Data {
  String chalet;
  String startDate;
  String endDate;
  int price;

  Data({this.chalet, this.startDate, this.endDate, this.price});

  Data.fromJson(Map<String, dynamic> json) {
    chalet = json['chalet'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chalet'] = this.chalet;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['price'] = this.price;
    return data;
  }
}