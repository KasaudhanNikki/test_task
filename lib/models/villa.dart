class ClaimedVillaModel {
  Data? data;
  String? error;
  String? message;
  String? status;

  ClaimedVillaModel({this.data, this.error, this.message, this.status});

  ClaimedVillaModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    error = json['error'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error'] = error;
    data['message'] = message;
    data['status'] = status;
    return data;
  }

  bool get success => status == 'success' || status == '200';
}

class Data {
  List<Villa>? villa;
  List<Company>? company;

  Data({this.villa, this.company});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['villa'] != null) {
      villa = <Villa>[];
      json['villa'].forEach((v) {
        villa!.add(Villa.fromJson(v));
      });
    }
    if (json['company'] != null) {
      company = <Company>[];
      json['company'].forEach((v) {
        company!.add(Company.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (villa != null) {
      data['villa'] = villa!.map((v) => v.toJson()).toList();
    }
    if (company != null) {
      data['company'] = company!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Villa {
  int? id;
  String? name;
  int? distance;
  int? businessUnitId;
  String? currencyId;
  String? currencyCode;

  Villa({
    this.id,
    this.name,
    this.distance,
    this.businessUnitId,
    this.currencyId,
    this.currencyCode,
  });

  Villa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    distance = json['distance'];
    businessUnitId = json['business_unit_id'];
    currencyId = json['currency_id'];
    currencyCode = json['currency_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['distance'] = distance;
    data['business_unit_id'] = businessUnitId;
    data['currency_id'] = currencyId;
    data['currency_code'] = currencyCode;
    return data;
  }
}

class Company {
  int? id;
  String? name;
  String? shortName;
  String? logo;
  String? currencyId;
  String? currencyCode;

  Company({
    this.id,
    this.name,
    this.shortName,
    this.logo,
    this.currencyId,
    this.currencyCode,
  });

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortName = json['short_name'];
    logo = json['logo'];
    currencyId = json['currency_id'];
    currencyCode = json['currency_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['short_name'] = shortName;
    data['logo'] = logo;
    data['currency_id'] = currencyId;
    data['currency_code'] = currencyCode;
    return data;
  }
}
