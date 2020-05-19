class TokenFailedLogin {
  Null data;
  String status;
  String error;

  TokenFailedLogin({this.data, this.status, this.error});

 factory TokenFailedLogin.fromJson(Map<String, dynamic> json)
  {
    return TokenFailedLogin(data : json['data'],
                           status : json['status'],
                           error : json['error']);
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['status'] = this.status;
    data['error'] = this.error;
    return data;
  }
}
