class PdiCheckPointModel {
  String? pcId;
  String? pcName;
  String? pcOrderId;
  String? pcIsMandatory;
  String? pcIsBoth;
  String? pcStatus;
  String? pcUpdatedOn;
  String? pcCreatedOn;

  PdiCheckPointModel({
    this.pcId,
    this.pcName,
    this.pcOrderId,
    this.pcIsMandatory,
    this.pcIsBoth,
    this.pcStatus,
    this.pcUpdatedOn,
    this.pcCreatedOn,
  });

  PdiCheckPointModel.fromJson(Map<String, dynamic> json) {
    pcId = json['pc_id'];
    pcName = json['pc_name'];
    pcOrderId = json['pc_order_id'];
    pcIsMandatory = json['pc_is_mandatory'];
    pcIsBoth = json['pc_is_both'];
    pcStatus = json['pc_status'];
    pcUpdatedOn = json['pc_updated_on'];
    pcCreatedOn = json['pc_created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pc_id'] = this.pcId;
    data['pc_name'] = this.pcName;
    data['pc_order_id'] = this.pcOrderId;
    data['pc_is_mandatory'] = this.pcIsMandatory;
    data['pc_is_both'] = this.pcIsBoth;
    data['pc_status'] = this.pcStatus;
    data['pc_updated_on'] = this.pcUpdatedOn;
    data['pc_created_on'] = this.pcCreatedOn;
    return data;
  }
}
