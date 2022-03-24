class UserRequest {
  bool? isStaging;
  String? fname;
  String? lname;
  String? phone;
  String? email;
  String? fulladdress;
  String? city;
  String? state;
  String? country;
  String? pincode;
  String? orderid;
  String? amount;
  String? username;
  String? password;
  String? secret;
  String? merchantId;
  String? protoDomain;
  String? currency;
  String? isCurrency;
  String? chMode;
  String? customVar;
  String? txnSubtype;
  String? wallet;
  String? successUrl;
  String? failedUrl;
  UserRequest(
      {this.username,
      this.isStaging,
      this.password,
      this.secret,
      this.merchantId,
      this.protoDomain,
      this.fname,
      this.lname,
      this.email,
      this.phone,
      this.fulladdress,
      this.city,
      this.state,
      this.country,
      this.pincode,
      this.amount,
      this.orderid,
      this.currency,
      this.isCurrency,
      this.chMode,
      this.customVar,
      this.txnSubtype,
      this.wallet,
      this.successUrl,
      this.failedUrl});
}
