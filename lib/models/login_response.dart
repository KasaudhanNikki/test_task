class LoginModel {
  Data? data;
  String? error;
  String? message;
  String? status;

  LoginModel({this.data, this.error, this.message, this.status});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? firstName;
  String? familyName;
  String? usageName;
  String? userType;
  String? emoticon;
  String? isClockIn;
  String? isTracker;
  String? status;
  List<BusinessUnits>? businessUnits;
  List<dynamic>? userRoles;
  List<String>? userPrivileges;
  String? authToken;

  Data({
    this.id,
    this.firstName,
    this.familyName,
    this.usageName,
    this.userType,
    this.emoticon,
    this.isClockIn,
    this.isTracker,
    this.status,
    this.businessUnits,
    this.userRoles,
    this.userPrivileges,
    this.authToken,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    familyName = json['family_name'];
    usageName = json['usage_name'];
    userType = json['user_type'];
    emoticon = json['emoticon'];
    isClockIn = json['is_clock_in'];
    isTracker = json['is_tracker'];
    status = json['status'];
    if (json['business_units'] != null) {
      businessUnits = <BusinessUnits>[];
      json['business_units'].forEach((v) {
        businessUnits!.add(BusinessUnits.fromJson(v));
      });
    }
    if (json['user_roles'] != null) {
      userRoles = <dynamic>[];
      json['user_roles'].forEach((v) {
        userRoles!.add(v);
      });
    }
    userPrivileges = json['user_privileges']?.cast<String>();
    authToken = json['auth_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['family_name'] = familyName;
    data['usage_name'] = usageName;
    data['user_type'] = userType;
    data['emoticon'] = emoticon;
    data['is_clock_in'] = isClockIn;
    data['is_tracker'] = isTracker;
    data['status'] = status;
    if (businessUnits != null) {
      data['business_units'] = businessUnits!.map((v) => v.toJson()).toList();
    }
    if (userRoles != null) {
      data['user_roles'] = userRoles;
    }
    data['user_privileges'] = userPrivileges;
    data['auth_token'] = authToken;
    return data;
  }
}

class BusinessUnits {
  int? id;
  String? name;

  BusinessUnits({this.id, this.name});

  BusinessUnits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
