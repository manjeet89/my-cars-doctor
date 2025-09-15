class AllcarModel {
  String? brandId;
  String? brandName;
  String? brandImagePath;
  String? brandStatus;
  String? brandCreatedOn;
  String? brandUpdatedOn;
  String? modelId;
  String? modelName;
  String? modelPrice;
  String? modelStatus;
  String? modelCreatedOn;
  String? modelUpdatedOn;
  String? foId;
  String? foName;
  String? foStatus;
  String? foUpdatedOn;
  String? foCreatedOn;
  String? ttId;
  String? ttName;
  String? ttStatus;
  String? ttUpdatedOn;
  String? ttCreatedOn;
  String? leadId;
  String? customerPhoneNumber;
  String? customerOtp;
  String? isVerified;
  String? leadUserId;
  String? manufacturingYear;
  String? leadPaidAmount;
  String? leadDiscount;
  String? leadAssignPartnerId;
  String? leadDocument;
  String? isNewCar;
  String? leadStatus;
  String? leadUpdatedOn;
  String? leadCreatedOn;
  String? userId;
  String? userName;
  String? userEmployeeId;
  String? userEmployeeType;
  String? employeeType;
  String? userFullName;
  String? gender;
  String? userEmailId;
  String? userPhoneNumber;
  String? userPassword;
  String? projectLocationId;
  String? reportingManager;
  String? countryId;
  String? stateId;
  String? districtId;
  String? cityName;
  String? userAddress;
  String? pinCode;
  String? isUserVerified;
  String? userOtp;
  String? userOtpTried;
  String? userToken;
  String? firebaseUserToken;
  String? userStatus;
  String? userUpdatedOn;
  String? userCreatedOn;

  AllcarModel({
    this.brandId,
    this.brandName,
    this.brandImagePath,
    this.brandStatus,
    this.brandCreatedOn,
    this.brandUpdatedOn,
    this.modelId,
    this.modelName,
    this.modelPrice,
    this.modelStatus,
    this.modelCreatedOn,
    this.modelUpdatedOn,
    this.foId,
    this.foName,
    this.foStatus,
    this.foUpdatedOn,
    this.foCreatedOn,
    this.ttId,
    this.ttName,
    this.ttStatus,
    this.ttUpdatedOn,
    this.ttCreatedOn,
    this.leadId,
    this.customerPhoneNumber,
    this.customerOtp,
    this.isVerified,
    this.leadUserId,
    this.manufacturingYear,
    this.leadPaidAmount,
    this.leadDiscount,
    this.leadAssignPartnerId,
    this.leadDocument,
    this.isNewCar,
    this.leadStatus,
    this.leadUpdatedOn,
    this.leadCreatedOn,
    this.userId,
    this.userName,
    this.userEmployeeId,
    this.userEmployeeType,
    this.employeeType,
    this.userFullName,
    this.gender,
    this.userEmailId,
    this.userPhoneNumber,
    this.userPassword,
    this.projectLocationId,
    this.reportingManager,
    this.countryId,
    this.stateId,
    this.districtId,
    this.cityName,
    this.userAddress,
    this.pinCode,
    this.isUserVerified,
    this.userOtp,
    this.userOtpTried,
    this.userToken,
    this.firebaseUserToken,
    this.userStatus,
    this.userUpdatedOn,
    this.userCreatedOn,
  });

  AllcarModel.fromJson(Map<String, dynamic> json) {
    brandId = json['brand_id'];
    brandName = json['brand_name'];
    brandImagePath = json['brand_image_path'];
    brandStatus = json['brand_status'];
    brandCreatedOn = json['brand_created_on'];
    brandUpdatedOn = json['brand_updated_on'];
    modelId = json['model_id'];
    modelName = json['model_name'];
    modelPrice = json['model_price'];
    modelStatus = json['model_status'];
    modelCreatedOn = json['model_created_on'];
    modelUpdatedOn = json['model_updated_on'];
    foId = json['fo_id'];
    foName = json['fo_name'];
    foStatus = json['fo_status'];
    foUpdatedOn = json['fo_updated_on'];
    foCreatedOn = json['fo_created_on'];
    ttId = json['tt_id'];
    ttName = json['tt_name'];
    ttStatus = json['tt_status'];
    ttUpdatedOn = json['tt_updated_on'];
    ttCreatedOn = json['tt_created_on'];
    leadId = json['lead_id'];
    customerPhoneNumber = json['customer_phone_number'];
    customerOtp = json['customer_otp'];
    isVerified = json['is_verified'];
    leadUserId = json['lead_user_id'];
    manufacturingYear = json['manufacturing_year'];
    leadPaidAmount = json['lead_paid_amount'];
    leadDiscount = json['lead_discount'];
    leadAssignPartnerId = json['lead_assign_partner_id'];
    leadDocument = json['lead_document'];
    isNewCar = json['is_new_car'];
    leadStatus = json['lead_status'];
    leadUpdatedOn = json['lead_updated_on'];
    leadCreatedOn = json['lead_created_on'];
    userId = json['user_id'];
    userName = json['user_name'];
    userEmployeeId = json['user_employee_id'];
    userEmployeeType = json['user_employee_type'];
    employeeType = json['employee_type'];
    userFullName = json['user_full_name'];
    gender = json['gender'];
    userEmailId = json['user_email_id'];
    userPhoneNumber = json['user_phone_number'];
    userPassword = json['user_password'];
    projectLocationId = json['project_location_id'];
    reportingManager = json['reporting_manager'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    districtId = json['district_id'];
    cityName = json['city_name'];
    userAddress = json['user_address'];
    pinCode = json['pin_code'];
    isUserVerified = json['is_user_verified'];
    userOtp = json['user_otp'];
    userOtpTried = json['user_otp_tried'];
    userToken = json['user_token'];
    firebaseUserToken = json['firebase_user_token'];
    userStatus = json['user_status'];
    userUpdatedOn = json['user_updated_on'];
    userCreatedOn = json['user_created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_id'] = this.brandId;
    data['brand_name'] = this.brandName;
    data['brand_image_path'] = this.brandImagePath;
    data['brand_status'] = this.brandStatus;
    data['brand_created_on'] = this.brandCreatedOn;
    data['brand_updated_on'] = this.brandUpdatedOn;
    data['model_id'] = this.modelId;
    data['model_name'] = this.modelName;
    data['model_price'] = this.modelPrice;
    data['model_status'] = this.modelStatus;
    data['model_created_on'] = this.modelCreatedOn;
    data['model_updated_on'] = this.modelUpdatedOn;
    data['fo_id'] = this.foId;
    data['fo_name'] = this.foName;
    data['fo_status'] = this.foStatus;
    data['fo_updated_on'] = this.foUpdatedOn;
    data['fo_created_on'] = this.foCreatedOn;
    data['tt_id'] = this.ttId;
    data['tt_name'] = this.ttName;
    data['tt_status'] = this.ttStatus;
    data['tt_updated_on'] = this.ttUpdatedOn;
    data['tt_created_on'] = this.ttCreatedOn;
    data['lead_id'] = this.leadId;
    data['customer_phone_number'] = this.customerPhoneNumber;
    data['customer_otp'] = this.customerOtp;
    data['is_verified'] = this.isVerified;
    data['lead_user_id'] = this.leadUserId;
    data['manufacturing_year'] = this.manufacturingYear;
    data['lead_paid_amount'] = this.leadPaidAmount;
    data['lead_discount'] = this.leadDiscount;
    data['lead_assign_partner_id'] = this.leadAssignPartnerId;
    data['lead_document'] = this.leadDocument;
    data['is_new_car'] = this.isNewCar;
    data['lead_status'] = this.leadStatus;
    data['lead_updated_on'] = this.leadUpdatedOn;
    data['lead_created_on'] = this.leadCreatedOn;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_employee_id'] = this.userEmployeeId;
    data['user_employee_type'] = this.userEmployeeType;
    data['employee_type'] = this.employeeType;
    data['user_full_name'] = this.userFullName;
    data['gender'] = this.gender;
    data['user_email_id'] = this.userEmailId;
    data['user_phone_number'] = this.userPhoneNumber;
    data['user_password'] = this.userPassword;
    data['project_location_id'] = this.projectLocationId;
    data['reporting_manager'] = this.reportingManager;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['district_id'] = this.districtId;
    data['city_name'] = this.cityName;
    data['user_address'] = this.userAddress;
    data['pin_code'] = this.pinCode;
    data['is_user_verified'] = this.isUserVerified;
    data['user_otp'] = this.userOtp;
    data['user_otp_tried'] = this.userOtpTried;
    data['user_token'] = this.userToken;
    data['firebase_user_token'] = this.firebaseUserToken;
    data['user_status'] = this.userStatus;
    data['user_updated_on'] = this.userUpdatedOn;
    data['user_created_on'] = this.userCreatedOn;
    return data;
  }
}
