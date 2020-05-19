class TokenSuccessfulLogin {
  Data data;
  String status;
  Null error;

  TokenSuccessfulLogin({this.data, this.status, this.error});

 factory TokenSuccessfulLogin.fromJson(Map<String, dynamic> json)
  {
    return TokenSuccessfulLogin(
        data : json['data'] != null ? new Data.fromJson(json['data']) : null,
        status : json['status'],
        error : json['error']);
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
  String accessToken;
  String role;

  Data({this.accessToken, this.role});

 factory Data.fromJson(Map<String, dynamic> json)
  {
    return Data(accessToken : json['access_token'],
                role : json['role']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['role'] = this.role;
    return data;
  }
}
