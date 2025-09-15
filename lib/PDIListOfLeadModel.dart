
class PdiListOfLeadModel {
  String? pdiId;
  String? pdiPartnerId;
  String? pdiLeadId;
  String? pdiCheckId;
  String? pdiImageUpload;
  String? pdiComment;
  String? pdiUpdatedId;
  String? pdiCreatedId;
  String? pcId;
  String? pcName;
  String? pcOrderId;
  String? pcIsMandatory;
  String? pcIsBoth;
  String? pcStatus;
  String? pcUpdatedOn;
  String? pcCreatedOn;

  PdiListOfLeadModel({this.pdiId, this.pdiPartnerId, this.pdiLeadId, this.pdiCheckId, this.pdiImageUpload, this.pdiComment, this.pdiUpdatedId, this.pdiCreatedId, this.pcId, this.pcName, this.pcOrderId, this.pcIsMandatory, this.pcIsBoth, this.pcStatus, this.pcUpdatedOn, this.pcCreatedOn});

  PdiListOfLeadModel.fromJson(Map<String, dynamic> json) {
    if(json["pdi_id"] is String) {
      pdiId = json["pdi_id"];
    }
    if(json["pdi_partner_id"] is String) {
      pdiPartnerId = json["pdi_partner_id"];
    }
    if(json["pdi_lead_id"] is String) {
      pdiLeadId = json["pdi_lead_id"];
    }
    if(json["pdi_check_id"] is String) {
      pdiCheckId = json["pdi_check_id"];
    }
    if(json["pdi_image_upload"] is String) {
      pdiImageUpload = json["pdi_image_upload"];
    }
    if(json["pdi_comment"] is String) {
      pdiComment = json["pdi_comment"];
    }
    if(json["pdi_updated_id"] is String) {
      pdiUpdatedId = json["pdi_updated_id"];
    }
    if(json["pdi_created_id"] is String) {
      pdiCreatedId = json["pdi_created_id"];
    }
    if(json["pc_id"] is String) {
      pcId = json["pc_id"];
    }
    if(json["pc_name"] is String) {
      pcName = json["pc_name"];
    }
    if(json["pc_order_id"] is String) {
      pcOrderId = json["pc_order_id"];
    }
    if(json["pc_is_mandatory"] is String) {
      pcIsMandatory = json["pc_is_mandatory"];
    }
    if(json["pc_is_both"] is String) {
      pcIsBoth = json["pc_is_both"];
    }
    if(json["pc_status"] is String) {
      pcStatus = json["pc_status"];
    }
    if(json["pc_updated_on"] is String) {
      pcUpdatedOn = json["pc_updated_on"];
    }
    if(json["pc_created_on"] is String) {
      pcCreatedOn = json["pc_created_on"];
    }
  }

  static List<PdiListOfLeadModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(PdiListOfLeadModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["pdi_id"] = pdiId;
    _data["pdi_partner_id"] = pdiPartnerId;
    _data["pdi_lead_id"] = pdiLeadId;
    _data["pdi_check_id"] = pdiCheckId;
    _data["pdi_image_upload"] = pdiImageUpload;
    _data["pdi_comment"] = pdiComment;
    _data["pdi_updated_id"] = pdiUpdatedId;
    _data["pdi_created_id"] = pdiCreatedId;
    _data["pc_id"] = pcId;
    _data["pc_name"] = pcName;
    _data["pc_order_id"] = pcOrderId;
    _data["pc_is_mandatory"] = pcIsMandatory;
    _data["pc_is_both"] = pcIsBoth;
    _data["pc_status"] = pcStatus;
    _data["pc_updated_on"] = pcUpdatedOn;
    _data["pc_created_on"] = pcCreatedOn;
    return _data;
  }
}