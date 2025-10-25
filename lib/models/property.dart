class BuPropertyNewModel {
  List<Property>? data;
  String? error;
  String? message;
  String? status;

  BuPropertyNewModel({this.data, this.error, this.message, this.status});

  BuPropertyNewModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Property>[];
      json['data'].forEach((v) {
        data!.add(Property.fromJson(v));
      });
    }
    error = json['error'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['error'] = error;
    data['message'] = message;
    data['status'] = status;
    return data;
  }

  bool get success => status == 'success' || status == '200';
}

class Property {
  int? id;
  String? name;
  String? description;
  String? image;
  double? latitude;
  double? longitude;
  int? businessUnitId;
  String? businessUnitName;
  Map<String, dynamic>? additionalData;

  Property({
    this.id,
    this.name,
    this.description,
    this.image,
    this.latitude,
    this.longitude,
    this.businessUnitId,
    this.businessUnitName,
    this.additionalData,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'],
      name: json['name'] ?? json['property_name'],
      description: json['description'],
      image: json['image'] ?? json['property_image'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      businessUnitId: json['business_unit_id'],
      businessUnitName: json['business_unit_name'],
      additionalData: json,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['business_unit_id'] = businessUnitId;
    data['business_unit_name'] = businessUnitName;
    return data;
  }
}

class BusinessUnitPropertiesResponse {
  final bool success;
  final String? message;
  final List<Property> properties;

  BusinessUnitPropertiesResponse({
    required this.success,
    this.message,
    required this.properties,
  });

  factory BusinessUnitPropertiesResponse.fromJson(Map<String, dynamic> json) {
    final model = BuPropertyNewModel.fromJson(json);
    return BusinessUnitPropertiesResponse(
      success: model.success,
      message: model.message ?? model.error,
      properties: model.data ?? [],
    );
  }
}
