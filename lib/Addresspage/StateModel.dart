class Statemodel {
  String? stateId;
  String? stateName;
  String? countryId;
  String? countryCode;
  String? countryName;
  String? stateCode;
  String? type;
  String? latitude;
  String? longitude;

  Statemodel({
    this.stateId,
    this.stateName,
    this.countryId,
    this.countryCode,
    this.countryName,
    this.stateCode,
    this.type,
    this.latitude,
    this.longitude,
  });

  Statemodel.fromJson(Map<String, dynamic> json) {
    stateId = json['state_id'];
    stateName = json['state_name'];
    countryId = json['country_id'];
    countryCode = json['country_code'];
    countryName = json['country_name'];
    stateCode = json['state_code'];
    type = json['type'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state_id'] = this.stateId;
    data['state_name'] = this.stateName;
    data['country_id'] = this.countryId;
    data['country_code'] = this.countryCode;
    data['country_name'] = this.countryName;
    data['state_code'] = this.stateCode;
    data['type'] = this.type;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
