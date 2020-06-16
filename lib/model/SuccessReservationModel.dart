class SuccessReservationModel {
  Data data;
  String status;
  Null error;

  SuccessReservationModel({this.data, this.status, this.error});

  SuccessReservationModel.fromJson(Map<String, dynamic> json) {
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
  ReservationData reservationData;
  String price;
  String discount;
  String iban;
  String accountNumber;

  Data(
      {this.reservationData,
        this.price,
        this.discount,
        this.iban,
        this.accountNumber});

  Data.fromJson(Map<String, dynamic> json) {
    reservationData = json['reservation data'] != null
        ? new ReservationData.fromJson(json['reservation data'])
        : null;
    price = json['price'].toString();
    discount = json['discount'].toString();
    iban = json['iban'];
    accountNumber = json['account_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reservationData != null) {
      data['reservation data'] = this.reservationData.toJson();
    }
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['iban'] = this.iban;
    data['account_number'] = this.accountNumber;
    return data;
  }
}

class ReservationData {
  String price;
  String chaletId;
  String startDate;
  String endDate;
  int userId;
  String updatedAt;
  String createdAt;
  int id;

  ReservationData(
      {this.price,
        this.chaletId,
        this.startDate,
        this.endDate,
        this.userId,
        this.updatedAt,
        this.createdAt,
        this.id});

  ReservationData.fromJson(Map<String, dynamic> json) {
    price = json['price'].toString();
    chaletId = json['chalet_id'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['chalet_id'] = this.chaletId;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
