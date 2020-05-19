class ModelDrawer {
  List<String> data;
  String status;
  Null error;

  ModelDrawer({this.data, this.status, this.error});

 factory ModelDrawer.fromJson(Map<String, dynamic> json)
  {
   return ModelDrawer( data : json['data'].cast<String>(),
       status : json['status'],
       error : json['error']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['status'] = this.status;
    data['error'] = this.error;
    return data;
  }
}
