import 'dart:io';
import 'package:airpay_package/airpay_package.dart';
import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final bool isSandbox;
  Home({this.isSandbox});

  @override
  _HomeState createState() => _HomeState(isSandbox: isSandbox);
}

class _HomeState extends State<Home> {
  final bool isSandbox;
  _HomeState({this.isSandbox});

  bool isSuccess = false;
  bool isVisible = false;
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController orderId = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController fullAddress = TextEditingController();

  void _showAddress() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  void initState() {
    super.initState();

    fname.text = "Yagnesh";
    lname.text = "Londhe";
    email.text = "yagnesh.londhe@wwindia.com";
    phone.text = "9870884171";
    fullAddress.text = "Mumbai";
    pincode.text = "600011";
    orderId.text = "2428";
    amount.text = "1.00";
    city.text = "testCity";
    state.text = "Maharastra";
    country.text = "India";
  }

  onComplete(status, response) {
    Navigator.pop(context);
    if (status == true) {
      if (response.sTATUS == '200') {
        _showAlert(context, "Your payment is successful");
      } else {
        _showAlert(context,
            "Your payment is failed due to \n ${response.tRANSACTIONREASON}");
      }
    } else {
      _showAlert(context, "This payment is failed");
    }
    _showAlert(context, '${response.toJson()}');
  }

  void _sendDatas() {
    /* User user = User(username :'8419743',password : 'JRLcAz5Y',secret: '74QpNYaT1oyqhxdL',merchantId : '1',fname : fname.text,
      lname :lname.text, email :email.text,phone :phone.text,fulladdress : full_address.text,
      pincode:pincode.text,orderid: order_id.text,amount: amount.text,city : city.text,state :state.text,country :country.text,
      currency: "356",isCurrency: "INR",chMode: "",customVar: "",txnSubtype: "",wallet: "0",successUrl: "http://www.theroadiesstore.in/airpay/transact/response"
        //,failedUrl: "https://cos.stfc.in/COS/COS_UI/COS_PaymentReceive.aspx"
    );*/

    String domainPath = '';

    String kAirPaySecretKey = '';

    String kAirPayUserName =  '';

    String kAirPayPassword = '';

    String merchantID = '';

    String successURL = '';
    UserRequest user = UserRequest(
        username: kAirPayUserName,
        password: kAirPayPassword,
        secret: kAirPaySecretKey,
        merchantId: merchantID,
        protoDomain: domainPath,
        fname: fname.text,
        lname: lname.text,
        email: email.text,
        phone: phone.text,
        fulladdress: fullAddress.text,
        pincode: pincode.text,
        orderid: orderId.text,
        amount: amount.text,
        city: city.text,
        state: state.text,
        country: country.text,
        currency: "356",
        isCurrency: "INR",
        chMode: "",
        customVar: "",
        txnSubtype: "",
        wallet: "0",
        isStaging: false, //True for the Staging
        successUrl: successURL);

//         String errMsg = "";
// if (user.secret.isEmpty) {
//   errMsg = 'Enter your AirPay Secret Key in kAirPaySecretKey';
// }
// else if (user.merchantId.isEmpty) {
//   errMsg = 'Enter your AirPay MerchantID';
// }
// else if (user.password.isEmpty) {
//   errMsg = 'Enter your AirPay password';
// }
// else if (user.username.isEmpty) {
//   errMsg = 'Enter your AirPay Username';
// }
// else if (user.successUrl.isEmpty) {
//   errMsg = 'Enter your AirPay successUrl';
// }
// else if (user.protoDomain.isEmpty) {
//   errMsg = 'Enter your AirPay protoDomain';
// }
// if (errMsg.isNotEmpty) {
//     _showAlert(context, errMsg + '\n to proceed with the demo app you must enter the required details to proceed.');
//     return;
// }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => new AirPay(
            user: user,
            closure: (status, response) => {onComplete(status, response)}),
      ),
    );
  }

  // ignore: unused_element
  _showLoader(context, message) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "Server Manager";
        String message1 = message;
        return Platform.isIOS
            ? new CupertinoAlertDialog(
                title: Text(title),
                content: Text(message1),
                actions: <Widget>[
                  new Container(
                    color: Colors.white60,
                    width: 30.0,
                    height: 80.0,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                ],
              )
            : alert(
                context,
                title: Text(title),
                content: Text(message1),
                textOK: Text('Okay'),
              );
      },
    );
  }

  _showAlert(context, message) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "Airpay";
        String message1 = message;
        return Platform.isIOS
            ? new CupertinoAlertDialog(
                title: Text(title),
                content: Text(message1),
                actions: <Widget>[
                  new Container(
                    margin: EdgeInsets.all(8.0),
                    child: RaisedButton(
                      padding: EdgeInsets.all(12.0),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.blue[900],
                      child: Text(
                        'Okay',
                        style: TextStyle(color: Colors.white, fontSize: 24.0),
                      ),
                    ),
                  )
                ],
              )
            : new AlertDialog(
                title: Text(title),
                content: Container(
                    height: 140.0,
                    width: 400.0,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return new Column(children: <Widget>[
                            Text(message1),
                          ]);
                        })),
                actions: <Widget>[
                  new Container(
                    margin: EdgeInsets.all(8.0),
                    child: RaisedButton(
                      padding: EdgeInsets.all(2.0),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.blue[900],
                      child: Text(
                        'Okay',
                        style: TextStyle(color: Colors.white, fontSize: 24.0),
                      ),
                    ),
                  )
                ],
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            'assets/airpays.png',
            height: 40,
            color: Colors.white,
            width: 200,
          ),
          backgroundColor: Colors.blue[900],
        ),
        backgroundColor: Colors.grey[400],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  margin: EdgeInsets.fromLTRB(8.0, 8, 8.0, 4),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Personal Information',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              'First Name *',
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.blue[900]),
                            )),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Text(
                                'Last Name *',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.blue[900]),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: TextFormField(
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                hintText: 'First Name',
                                //   contentPadding: EdgeInsets.all(2.0),
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 15.0),
                              ),
                              controller: fname,
                            )),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  hintText: 'Last Name',
                                  // contentPadding: EdgeInsets.all(2.0),
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 15.0),
                                ),
                                controller: lname,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Container(
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Email Id',
                              // contentPadding: EdgeInsets.all(2.0),
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 15.0),
                            ),
                            controller: email,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Container(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Phone',
                              // contentPadding: EdgeInsets.all(2.0),
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 15.0),
                            ),
                            controller: phone,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.fromLTRB(8.0, 8, 8.0, 4),
                  color: Colors.white,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(8.0, 8, 8.0, 4),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Address',
                                style: TextStyle(
                                    color: Colors.blue[900],
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                onPressed: () {
                                  _showAddress();
                                },
                                icon: isVisible
                                    ? Icon(Icons.arrow_drop_up)
                                    : Icon(Icons.arrow_drop_down),
                                color: Colors.black,
                              )
                            ],
                          ),
                          Visibility(
                            visible: isVisible,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'Full Address',
                                      // contentPadding: EdgeInsets.all(2.0),
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 15.0),
                                    ),
                                    controller: fullAddress,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Container(
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'City Name',
                                      // contentPadding: EdgeInsets.all(2.0),
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 15.0),
                                    ),
                                    controller: city,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      'State Name',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.blue[900]),
                                    )),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Country Name',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.blue[900]),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: TextFormField(
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        hintText: 'State',
                                        //   contentPadding: EdgeInsets.all(2.0),
                                        hintStyle: TextStyle(
                                            color: Colors.grey, fontSize: 15.0),
                                      ),
                                      controller: state,
                                    )),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          hintText: 'Country ',
                                          // contentPadding: EdgeInsets.all(2.0),
                                          hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15.0),
                                        ),
                                        controller: country,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Container(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: 'PinCode',
                                      // contentPadding: EdgeInsets.all(2.0),
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 15.0),
                                    ),
                                    controller: pincode,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
                Card(
                  margin: EdgeInsets.all(8.0),
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Transaction Information',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              'Order Id *',
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.blue[900]),
                            )),
                            SizedBox(
                              width: 8.0,
                            ),
                            Expanded(
                              child: Text(
                                'Amount *',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.blue[900]),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: TextFormField(
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                hintText: 'Order Id',
                                //   contentPadding: EdgeInsets.all(2.0),
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 15.0),
                              ),
                              controller: orderId,
                            )),
                            SizedBox(
                              width: 8.0,
                            ),
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: 'Amount',
                                  // contentPadding: EdgeInsets.all(2.0),
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 15.0),
                                ),
                                controller: amount,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(2.0, 11.0, 2.0, 11.0),
                    onPressed: () {
                      _sendDatas();
                    },
                    color: Colors.blue[900],
                    child: Text(
                      'NEXT',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(2.0, 11.0, 2.0, 11.0),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.blue[900],
                    child: Text(
                      'BACK',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
