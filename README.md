# Airpay Flutter

Airpay Flutter plugin for payment integeration.


## Usage
Add `airpay_package` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

You can now include a airpayPackage widget in your widget tree. See the
[airpayPackage](https://pub.dev/packages/airpay_package/)
widget's Dartdoc for more details on how to use the widget.

## Installation

This plugin is available on Pub: [https://pub.dev/packages/airpay_package/](https://pub.dev/packages/airpay_package/)

Add this to `dependencies` in your app's `pubspec.yaml`

```yaml
airpay_package: ^1.0.0
```

**Note**: For android make sure that the minimum API level for your app is 19 or higher.

## Usage

- Learn about the <a href="https://www.airpay.co.in/" target="_blank">Airpay Payment</a>.
 - Sign up <a href="https://www.airpay.co.in/services/subscription">Airpay Account</a> and generate the API Keys from the Razorpay Dashboard. Using the Test keys helps simulate a sandbox environment. No actual monetary transaction happens when using the Test keys. Use Live keys once you have thoroughly tested the application and are ready to go live.
 

```dart
String domainPath = '##PLACE_YOUR_KEY_HERE##';

    String kAirPaySecretKey = '##PLACE_YOUR_KEY_HERE##';

    String kAirPayUserName = '##PLACE_YOUR_KEY_HERE##';

    String kAirPayPassword = '##PLACE_YOUR_KEY_HERE##';

    String merchantID = '##PLACE_YOUR_KEY_HERE##';

    String successURL = '##PLACE_YOUR_KEY_HERE##';

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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => new AirPay(
            user: user,
            closure: (status, response) => {onComplete(status, response)}),
      ),
    );
```

## Android and iOS Platform Example Views
The Airpay flutter package is a lighweight WebView is relying on
[Platform Views](https://flutter.dev/docs/development/platform-integration/platform-views) to embed
the Android’s webview within the Flutter app. By default a Virtual Display based platform view
backend is used,

### Using Airpay

For example:

```dart
import 'dart:io';

import 'package:airpay_package/airpay_package.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState(isSandbox: isSandbox);
}

class _HomeState extends State<Home> {
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

  @override
  void initState() {
    super.initState();
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
   
    String domainPath = '##Your Domain##';

    String kAirPaySecretKey = '##Secret Key##';

    String kAirPayUserName = '##UserName##';

    String kAirPayPassword = 'Password';

    String merchantID = '##MerchantID##';

    String successURL = '##SuccessURL##';

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
        String title = "Airpay";
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
    return Scaffold(,
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

```

Airpay `SurfaceAndroidWebView()` requires [API level 19](https://developer.android.com/studio/releases/platforms?hl=th#4.4). The plugin itself doesn't enforce the API level, so if you want to make the app available on devices running this API level or above, add the following to `<your-app>/android/app/build.gradle`:

```gradle
android {
    defaultConfig {
        // Required by the Flutter WebView plugin.
        minSdkVersion 19
    }
  }
```
