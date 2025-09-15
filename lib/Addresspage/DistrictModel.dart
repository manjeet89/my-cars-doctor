class Districtmodel {
  String? districtId;
  String? stateId;
  String? districtName;
  String? districtStatus;
  String? districtUpdatedOn;
  String? districtCreatedOn;

  Districtmodel({
    this.districtId,
    this.stateId,
    this.districtName,
    this.districtStatus,
    this.districtUpdatedOn,
    this.districtCreatedOn,
  });

  Districtmodel.fromJson(Map<String, dynamic> json) {
    districtId = json['district_id'];
    stateId = json['state_id'];
    districtName = json['district_name'];
    districtStatus = json['district_status'];
    districtUpdatedOn = json['district_updated_on'];
    districtCreatedOn = json['district_created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district_id'] = this.districtId;
    data['state_id'] = this.stateId;
    data['district_name'] = this.districtName;
    data['district_status'] = this.districtStatus;
    data['district_updated_on'] = this.districtUpdatedOn;
    data['district_created_on'] = this.districtCreatedOn;
    return data;
  }
}
