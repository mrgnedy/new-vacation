class TokenSuccessfulRegister {
  String data;
  String status;
  Null error;

  TokenSuccessfulRegister({this.data, this.status, this.error});

  factory TokenSuccessfulRegister.fromJson(Map<String, dynamic> json) {
    return TokenSuccessfulRegister(data: json['data'],
        status: json['status'],
        error :json['error']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['status'] = this.status;
    data['error'] = this.error;
    return data;
  }
}


