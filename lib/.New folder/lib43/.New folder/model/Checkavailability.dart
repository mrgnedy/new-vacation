class CheckavailabilitySuccess {
  String data;
  String status;
  Null error;

  CheckavailabilitySuccess({this.data, this.status, this.error});

  CheckavailabilitySuccess.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    status = json['status'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['status'] = this.status;
    data['error'] = this.error;
    return data;
  }
}

///----------------------------------------------------
class CheckavailabilityFailed {
  Null data;
  String status;
  String error;

  CheckavailabilityFailed({this.data, this.status, this.error});

  CheckavailabilityFailed.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    status = json['status'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['status'] = this.status;
    data['error'] = this.error;
    return data;
  }
}
