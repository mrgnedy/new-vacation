class UpdateAdvertiser {
  Data data;
  String status;
  Null error;

  UpdateAdvertiser({this.data, this.status, this.error});

 factory UpdateAdvertiser.fromJson(Map<String, dynamic> json) {
    return UpdateAdvertiser(
        data : json['data'] != null ? new Data.fromJson(json['data']) : null,
        status : json['status'],
        error : json['error']);
  }

  Map<String, dynamic> toJson()
  {
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
  int id;
  String name;
  String email;
  int phone;
  String bank;
  String accountName;
  String accountNumber;
  String eban;
  String image;
  int roleId;
  Null emailVerifiedAt;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.bank,
        this.accountName,
        this.accountNumber,
        this.eban,
        this.image,
        this.roleId,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt});

 factory Data.fromJson(Map<String, dynamic> json)
 {
   return Data( id:json['id'],
       name : json['name'],
       email : json['email'],
       phone : json['phone'],
       bank : json['bank'],
       accountName : json['account_name'],
       accountNumber : json['account_number'],
       eban : json['eban'],
       image : json['image'],
       roleId : json['role_id'],
       emailVerifiedAt : json['email_verified_at'],
       createdAt : json['created_at'],
       updatedAt : json['updated_at']
   );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['bank'] = this.bank;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['eban'] = this.eban;
    data['image'] = this.image;
    data['role_id'] = this.roleId;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

//-------------if Failed Update------------------------//

class FailedUpdate {
  Null data;
  String status;
  Error error;

  FailedUpdate({this.data, this.status, this.error});

factory  FailedUpdate.fromJson(Map<String, dynamic> json) {


    return FailedUpdate(data : json['data'],
        status : json['status'],
        error : json['error'] != null ? new Error.fromJson(json['error']) : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['status'] = this.status;
    if (this.error != null) {
      data['error'] = this.error.toJson();
    }
    return data;
  }
}

class Error {
  List<String> email;

  Error({this.email});

  Error.fromJson(Map<String, dynamic> json) {
    email = json['email'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    return data;
  }
}
