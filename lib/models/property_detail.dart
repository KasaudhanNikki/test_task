class PropertyDetailResponse {
  PropertyDetail? propertyDetail;
  String? error;
  String? message;
  String? status;

  PropertyDetailResponse({this.propertyDetail, this.error, this.message, this.status});

  bool get success => status == 'success' || (error == null && propertyDetail != null);
  PropertyDetailResponse.fromJson(Map<String, dynamic> json) {
    propertyDetail = json['data'] != null
        ? PropertyDetail.fromJson(json['data'])
        : null;
    error = json['error'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.propertyDetail != null) {
      data['data'] = propertyDetail?.toJson();
    }
    data['error'] = this.error;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class PropertyDetail {
  int? id;
  String? name;
  String? latitude;
  String? longitude;
  String? image;

  PropertyDetail({this.id, this.name, this.latitude, this.longitude, this.image});

  PropertyDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['image'] = this.image;
    return data;
  }
}