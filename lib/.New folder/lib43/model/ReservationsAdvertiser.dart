class ReservationsAdvertiser {
  Data data;
  String status;
  Null error;

  ReservationsAdvertiser({this.data, this.status, this.error});

  ReservationsAdvertiser.fromJson(Map<String, dynamic> json) {
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
  List<Reservations> reservations;
  int budget;

  Data({this.reservations, this.budget});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['reservations'] != null) {
      reservations = new List<Reservations>();
      json['reservations'].forEach((v) {
        reservations.add(new Reservations.fromJson(v));
      });
    }
    budget = json['budget'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reservations != null) {
      data['reservations'] = this.reservations.map((v) => v.toJson()).toList();
    }
    data['budget'] = this.budget;
    return data;
  }
}

class Reservations {
  int id;
  int chaletId;
  int userId;
  int price;
  String startDate;
  int discount;
  String endDate;
  int state;
  String createdAt;
  String updatedAt;

  Reservations(
      {this.id,
        this.chaletId,
        this.userId,
        this.price,
        this.startDate,
        this.discount,
        this.endDate,
        this.state,
        this.createdAt,
        this.updatedAt});

  Reservations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chaletId = json['chalet_id'];
    userId = json['user_id'];
    price = json['price'];
    startDate = json['startDate'];
    discount = json['discount'];
    endDate = json['endDate'];
    state = json['state'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chalet_id'] = this.chaletId;
    data['user_id'] = this.userId;
    data['price'] = this.price;
    data['startDate'] = this.startDate;
    data['discount'] = this.discount;
    data['endDate'] = this.endDate;
    data['state'] = this.state;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
