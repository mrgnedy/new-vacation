class TokenFailed {
  Null data;
  String status;
  Error error;

  TokenFailed({this.data, this.status, this.error});

  factory TokenFailed.fromJson(Map<String, dynamic> json)
  {

    return TokenFailed(data :json['data'],
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

  factory Error.fromJson(Map<String, dynamic> json)
  {
    return Error( email : json['email'].cast<String>());
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    return data;
  }
}



