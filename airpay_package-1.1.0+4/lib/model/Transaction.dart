class Transaction {
  String? sTATUS;
  String? tXNMODE;
  String? tXNDATETIME;
  String? tXNCURRENCYCODE;
  String? tRANSACTIONID;
  String? tRANSACTIONAMT;
  String? tRANSACTIONSTATUS;
  String? sTATUSMSG;
  String? tRANSACTIONVARIANT;
  String? mERCHANTTRANSACTIONID;
  String? mERCHANTKEY;
  String? cUSTOMVAR;
  String? aPSECUREHASH;
  String? cHMOD;
  String? fULLNAME;
  String? eMAIL;
  String? cONTACTNO;
  String? iSRISK;
  String? bANKNAME;
  CARDDETAILS? cARDDETAILS;
  String? eMIDETAILS;
  String? mERCHANTNAME;
  String? sETTLEMENTDATE;
  String? sURCHARGE;
  String? bILLEDAMOUNT;
  String? rRN;
  String? tRANSACTIONREASON;

  Transaction(
      {this.sTATUS,
      this.tXNMODE,
      this.tXNDATETIME,
      this.tXNCURRENCYCODE,
      this.tRANSACTIONID,
      this.tRANSACTIONAMT,
      this.tRANSACTIONSTATUS,
      this.sTATUSMSG,
      this.tRANSACTIONVARIANT,
      this.mERCHANTTRANSACTIONID,
      this.mERCHANTKEY,
      this.cUSTOMVAR,
      this.aPSECUREHASH,
      this.cHMOD,
      this.fULLNAME,
      this.eMAIL,
      this.cONTACTNO,
      this.iSRISK,
      this.bANKNAME,
      this.cARDDETAILS,
      this.eMIDETAILS,
      this.mERCHANTNAME,
      this.sETTLEMENTDATE,
      this.sURCHARGE,
      this.bILLEDAMOUNT,
      this.rRN,
      this.tRANSACTIONREASON});

  Transaction.fromJson(Map<String, dynamic> json) {
    sTATUS = json['STATUS'];
    tXNMODE = json['TXN_MODE'];
    tXNDATETIME = json['TXN_DATE_TIME'];
    tXNCURRENCYCODE = json['TXN_CURRENCY_CODE'];
    tRANSACTIONID = json['TRANSACTIONID'];
    tRANSACTIONAMT = json['TRANSACTIONAMT'];
    tRANSACTIONSTATUS = json['TRANSACTIONSTATUS'];
    sTATUSMSG = json['STATUSMSG'];
    if (json['TRANSACTIONVARIANT'] != null) {
      tRANSACTIONVARIANT = json['TRANSACTIONVARIANT'];
    }
    mERCHANTTRANSACTIONID = json['MERCHANTTRANSACTIONID'];
    mERCHANTKEY = json['MERCHANTKEY'];
    if (json['CUSTOMVAR'] != null) {
      cUSTOMVAR = json['CUSTOMVAR'];
    }
    aPSECUREHASH = json['AP_SECUREHASH'];
    cHMOD = json['CHMOD'];
    fULLNAME = json['FULLNAME'];
    eMAIL = json['EMAIL'];
    cONTACTNO = json['CONTACTNO'];
    iSRISK = json['ISRISK'];
    bANKNAME = json['BANKNAME'];
    cARDDETAILS = json['CARD_DETAILS'] != null
        ? new CARDDETAILS.fromJson(json['CARD_DETAILS'])
        : null;
    if (json['EMI_DETAILS'] != null && json['EMI_DETAILS'] is String) {
      eMIDETAILS = json['EMI_DETAILS'];
    }
    mERCHANTNAME = json['MERCHANT_NAME'];
    if (json['SETTLEMENT_DATE'] != null) {
      sETTLEMENTDATE = json['SETTLEMENT_DATE'];
    }
    sURCHARGE = json['SURCHARGE'];
    bILLEDAMOUNT = json['BILLEDAMOUNT'];
    rRN = json['RRN'];
    tRANSACTIONREASON = json['TRANSACTIONREASON'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STATUS'] = this.sTATUS;
    data['TXN_MODE'] = this.tXNMODE;
    data['TXN_DATE_TIME'] = this.tXNDATETIME;
    data['TXN_CURRENCY_CODE'] = this.tXNCURRENCYCODE;
    data['TRANSACTIONID'] = this.tRANSACTIONID;
    data['TRANSACTIONAMT'] = this.tRANSACTIONAMT;
    data['TRANSACTIONSTATUS'] = this.tRANSACTIONSTATUS;
    data['STATUSMSG'] = this.sTATUSMSG;
    if (this.tRANSACTIONVARIANT != null) {
      data['TRANSACTIONVARIANT'] = this.tRANSACTIONVARIANT;
    }
    data['MERCHANTTRANSACTIONID'] = this.mERCHANTTRANSACTIONID;
    data['MERCHANTKEY'] = this.mERCHANTKEY;
    if (this.cUSTOMVAR != null) {
      data['CUSTOMVAR'] = this.cUSTOMVAR;
    }
    data['AP_SECUREHASH'] = this.aPSECUREHASH;
    data['CHMOD'] = this.cHMOD;
    data['FULLNAME'] = this.fULLNAME;
    data['EMAIL'] = this.eMAIL;
    data['CONTACTNO'] = this.cONTACTNO;
    data['ISRISK'] = this.iSRISK;
    data['BANKNAME'] = this.bANKNAME;
    if (this.cARDDETAILS != null) {
      data['CARD_DETAILS'] = this.cARDDETAILS!.toJson();
    }
    if (this.eMIDETAILS != null) {
      data['EMI_DETAILS'] = this.eMIDETAILS;
    }
    data['MERCHANT_NAME'] = this.mERCHANTNAME;
    if (this.sETTLEMENTDATE != null) {
      data['SETTLEMENT_DATE'] = this.sETTLEMENTDATE;
    }
    data['SURCHARGE'] = this.sURCHARGE;
    data['BILLEDAMOUNT'] = this.bILLEDAMOUNT;
    data['RRN'] = this.rRN;
    data['TRANSACTIONREASON'] = this.tRANSACTIONREASON;
    return data;
  }
}

class CARDDETAILS {
  String? pRIACCNOSTART;
  String? pRIACCNOEND;
  String? cARDISSUER;
  String? cARDTYPE;
  String? cARDCOUNTRY;

  CARDDETAILS(
      {this.pRIACCNOSTART,
      this.pRIACCNOEND,
      this.cARDISSUER,
      this.cARDTYPE,
      this.cARDCOUNTRY});

  CARDDETAILS.fromJson(Map<String, dynamic> json) {
    pRIACCNOSTART = json['PRI_ACC_NO_START'];
    pRIACCNOEND = json['PRI_ACC_NO_END'];
    cARDISSUER = json['CARDISSUER'];
    cARDTYPE = json['CARDTYPE'];
    cARDCOUNTRY = json['CARDCOUNTRY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PRI_ACC_NO_START'] = this.pRIACCNOSTART;
    data['PRI_ACC_NO_END'] = this.pRIACCNOEND;
    data['CARDISSUER'] = this.cARDISSUER;
    data['CARDTYPE'] = this.cARDTYPE;
    data['CARDCOUNTRY'] = this.cARDCOUNTRY;
    return data;
  }
}
