class CodeVerificationSuccess
{
  Data data;
  String status;
  Null error;

  CodeVerificationSuccess({this.data, this.status, this.error});

   //----------------Return Data From Object ----------------//
  factory   CodeVerificationSuccess.fromJson(Map<String, dynamic> json)
  {
     return CodeVerificationSuccess(data : json['data'] != null ? new Data.fromJson(json['data']) : null,
                                    status : json['status'],
                                    error : json['error']);
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null)
    {
      data['data'] = this.data.toJson();
    }
    data['status'] = this.status;
    data['error'] = this.error;
    return data;
  }
}
//---------------------------------Code--------------------------------//
 class Data {
  String code;

  Data({this.code});

 factory Data.fromJson(Map<String, dynamic> json)
  {
     return Data(code:json['code']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    return data;
  }
}
