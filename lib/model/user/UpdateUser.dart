class UpdateUser {
  Data data;
  String status;
  Null error;

  UpdateUser({this.data, this.status, this.error});

  UpdateUser.fromJson(Map<String, dynamic> json) {
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
  Profile profile;
  List<Officers> officers;

  Data({this.profile, this.officers});

  Data.fromJson(Map<String, dynamic> json) {
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    if (json['officers'] != null) {
      officers = new List<Officers>();
      json['officers'].forEach((v) {
        officers.add(new Officers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profile != null) {
      data['profile'] = this.profile.toJson();
    }
    if (this.officers != null) {
      data['officers'] = this.officers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Profile {
  int id;
  String name;
  String email;
  int phone;
  Null bank;
  Null accountName;
  Null accountNumber;
  Null eban;
  Null image;
  String os;
  String deviceToken;
  int roleId;
  Null emailVerifiedAt;
  String createdAt;
  String updatedAt;

  Profile(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.bank,
      this.accountName,
      this.accountNumber,
      this.eban,
      this.image,
      this.os,
      this.deviceToken,
      this.roleId,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    bank = json['bank'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    eban = json['eban'];
    image = json['image'];
    os = json['os'];
    deviceToken = json['device_token'];
    roleId = json['role_id'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['os'] = this.os;
    data['device_token'] = this.deviceToken;
    data['role_id'] = this.roleId;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Officers {
  int id;
  String phone;
  String name;
  int userId;
  String createdAt;
  String updatedAt;

  Officers(
      {this.id,
      this.phone,
      this.name,
      this.userId,
      this.createdAt,
      this.updatedAt});

  Officers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    name = json['name'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

//--------------Erro----------------//
class UpdateUserFailed {
  Null data;
  String status;
  Error error;

  UpdateUserFailed({this.data, this.status, this.error});

factory  UpdateUserFailed.fromJson(Map<String, dynamic> json)
{

    return UpdateUserFailed(data : json['data'],
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
