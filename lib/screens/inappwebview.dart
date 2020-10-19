import 'dart:io';

import 'package:airpay_package/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

typedef void Closure(bool val);

class AirPay extends StatefulWidget {
  final User user;
  final Closure callback;

  AirPay({Key key, @required this.user, this.callback}) : super(key: key);
  @override
  _AirPayState createState() => new _AirPayState();
}

class _AirPayState extends State<AirPay> {
  var URL = 'https://google.com.tr';
  String url = "";
  double progress = 0;
  var postdata = "";
  // var domainNameFrom = getProtoDomain(widget.user.successUrl);
  // var failuerdomainNameFrom = getProtoDomain(widget.user.failedUrl);
  String loadData() {
    var date = new DateTime.now();
    var format = DateFormat("yyyy-MM-dd");
    var formattedDate = format.format(date);
    var temp = utf8.encode(
        '${widget.user.secret}@${widget.user.username}:|:${widget.user.password}');
    var privatekey = sha256.convert(temp);
    var setAllData = utf8.encode(
        '${widget.user.email}${widget.user.fname}${widget.user.lname}${widget.user.fulladdress}${widget.user.city}${widget.user.state}${widget.user.country}${widget.user.amount}${widget.user.orderid}$formattedDate$privatekey');
    var checksum = md5.convert(setAllData);
    var protocolDomain =
        getProtoDomain(widget.user.protoDomain);//'http://www.theroadiesstore.in/airpay/transact/response'); //https://apmerchantapp.nowpay.co.in/index.html
    List<int> bytes = ascii.encode(protocolDomain);
    var encoded = base64
        .encode(bytes); // 'https://apmerchantapp.nowpay.co.in/index.html';
    var user = widget.user;
    /*  postdata = 'mer_dom=$encoded&currency=${user.currency}&isocurrency=${user.isCurrency}'+
        '&orderid=${user.orderid}&privatekey=${privatekey.toString()}&checksum=${checksum.toString()}'
        +'mercid=${user.merchantId}&buyerEmail=${user.email}&buyerPhone=${user.phone}'
        +'&buyerFirstName=${user.fname}&buyerLastName=${user.lname}&buyerAddress=${user.fulladdress}'
        +'&buyerCity=${user.city}&buyerState=${user.state}&buyerCountry=${user.country}'
        +'&buyerPinCode=${user.pincode}&amount=${user.amount}&chmod=${user.chMode}'
        +'&customvar=${user.customVar}&txnsubtype=${user.txnSubtype}'
        +'&wallet=${user.wallet}${user.txnSubtype}&surchargeAmount=';
    print('post data : $postdata');*/
    // print('encoded : ${utf8.encode(postdata)}');
    // return utf8.encode(postdata);
    var url = "<!DOCTYPE html>" +
        "<html>" +
        "<body onload='document.frm1.submit()'>" +
        "<form action='https://payments.airpay.co.in/pay/index.php' method='post' name='frm1'>" +
        "  <input type='hidden' name='mer_dom' value='$encoded'><br>" +
        "  <input type='hidden' name='currency' value='${user.currency}'><br>" +
        "  <input type='hidden' name='isocurrency' value='${user.isCurrency}'><br>" +
        "  <input type='hidden' name='orderid' value='${user.orderid}'><br>" +
        "  <input type='hidden' name='privatekey' value='$privatekey'><br>" +
        "  <input type='hidden' name='checksum' value='$checksum'><br>" +
        "  <input type='hidden' name='mercid' value='${user.merchantId}'><br>" +
        "  <input type='hidden' name='buyerEmail' value='${user.email}'><br>" +
        "  <input type='hidden' name='buyerPhone' value='${user.phone}'><br>" +
        "  <input type='hidden' name='buyerFirstName' value='${user.fname}'><br>" +
        "  <input type='hidden' name='buyerLastName' value='${user.lname}'><br>" +
        "  <input type='hidden' name='buyerAddress' value='${user.fulladdress}'><br>" +
        "  <input type='hidden' name='buyerCity' value='${user.city}'><br>" +
        "  <input type='hidden' name='buyerState' value='${user.state}'><br>" +
        "  <input type='hidden' name='buyerCountry' value='${user.country}'><br>" +
        "  <input type='hidden' name='buyerPinCode' value='${user.pincode}'><br>" +
        "  <input type='hidden' name='amount' value='${user.amount}'><br>" +
        "  <input type='hidden' name='chmod' value='${user.chMode}'><br>" +
        "  <input type='hidden' name='customvar' value='${user.customVar}'><br>" +
        "  <input type='hidden' name='txnsubtype' value='${user.txnSubtype}'><br>" +
        "  <input type='hidden' name='wallet' value='${user.wallet + user.txnSubtype}'><br>" +
        "</form>" +
        "</body>" +
        "</html>";
    return url;
  }

  String getProtoDomain(String sDomain) {
    int slashslash = sDomain.indexOf("//") + 2;
    return sDomain.substring(0, sDomain.indexOf("/", slashslash));
  }
  
  
  _showConfirmation(context, message) async {
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
                    margin: EdgeInsets.all(0),
                    child: RaisedButton(
                      padding: EdgeInsets.all(12.0),
                      onPressed: () {
                        Navigator.pop(context);
                        print("Go Back");
                        widget.callback(false);
                        Navigator.pop(context);
                      },
                      color: Colors.blue[900],
                      child: Text(
                        'Yes',
                        style: TextStyle(color: Colors.white, fontSize: 24.0),
                      ),
                    ),
                  ),new Container(
                    margin: EdgeInsets.all(0),
                    child: RaisedButton(
                      padding: EdgeInsets.all(12.0),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.blue[900],
                      child: Text(
                        'No',
                        style: TextStyle(color: Colors.white, fontSize: 24.0),
                      ),
                    ),
                  )
                ],
              )
            : new AlertDialog(
                title: Text(title),
                content: new Container(
                    height: 140.0,
                    child: new Column(
                      children: [
                        Text(message1),
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
                              style: TextStyle(
                                  color: Colors.white, fontSize: 24.0),
                            ),
                          ),
                        )
                      ],
                    )),
                actions: <Widget>[],
              );
      },
    );
  }

  InAppWebViewController _webViewController;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            child: Column(children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                child: progress < 1.0
                    ? LinearProgressIndicator(value: progress)
                    : Container()),
          Expanded(
         
            child: InAppWebView(
              //initialUrl: URL,
              initialData: InAppWebViewInitialData(
                data: loadData(),
              ),
              initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                debuggingEnabled: true,
                javaScriptEnabled: true,
              )),
              onTitleChanged: (InAppWebViewController controller, String url) {
                setState(() {
                  print("onTitleChanged : $url");
                });
              },
              onWebViewCreated: (InAppWebViewController controller) {},
              onLoadStart: (InAppWebViewController controller, String url) {
                setState(() {
                  print("onLoadStart : $url");
                  if (getProtoDomain(widget.user.successUrl) == getProtoDomain(url)) {
                    _webViewController.stopLoading();
                    widget.callback(true);
                    print("onLoadStart : Success");
                    Navigator.pop(context);
                  }
                  else if (getProtoDomain(widget.user.failedUrl) == getProtoDomain(url)) {
                    _webViewController.stopLoading();
                    widget.callback(false);
                    print("onLoadStart : Failed");
                    Navigator.pop(context);
                  }
                });
              },
              onLoadStop:
                  (InAppWebViewController controller, String url) async {
                /* int result1 = await controller.evaluateJavascript(source: "10 + 20;");
                        print(result1); // 30

                        String result2 = await controller.evaluateJavascript(source: """
                        var firstname = "Foo";
                        var lastname = "Bar";
                        firstname + " " + lastname;
                      """);
                        print(result2);*/
                String ht = await controller.evaluateJavascript(
                    source:
                        "javascript:window.droid.print(document.getElementsByClassName('alert')[0].innerHTML);");

                setState(() {
                  this.url = url;
                  if (url
                      .startsWith('https://payments.airpay.ninja/error.php')) {
                    setState(() {
                      controller.loadUrl(url: ht);
                      print('ht: $url');
                      print('onLoad Stop in - $url');
                      widget.callback(false);
                      Navigator.pop(context);
                    });
                  } else {
                    print('on Load Stop: not error URL: \n $url');
                  }
                });
              },
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                setState(() {
                  this.progress = progress / 100;
                });
              },
            ),
          ),
          ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Icon(Icons.arrow_back),
                  onPressed: () {
                    _showConfirmation(context,"Did you want to cancel this transaction ?");
                    // if (webView != null) {
                    //   webView.goBack();
                    // }
                  },
                )]
          ),
        ])),
      ),
    );
  }
}

   /* child:InAppWebView(
                      initialUrl: URL,
                      initialData: InAppWebViewInitialData(
                         // data: loadData(),
                      ),
                      initialOptions: InAppWebViewGroupOptions(
                          crossPlatform: InAppWebViewOptions(
                            debuggingEnabled: true,
                          )
                      ),
                      onWebViewCreated: (InAppWebViewController controller) {
                        _webViewController = controller;
                     //   _webViewController.postUrl(url: "https://payments.airpay.ninja/pay/index.php", postData: loadData());
                        _webViewController.addJavaScriptHandler(handlerName:'handlerFoo', callback: (args) {
                          // return data to JavaScript side!
                          return {
                            'bar': 'bar_value', 'baz': 'baz_value'
                          };
                        });

                        _webViewController.addJavaScriptHandler(handlerName: 'handlerFooWithArgs', callback: (args) {
                          print(args);
                          // it will print: [1, true, [bar, 5], {foo: baz}, {bar: bar_value, baz: baz_value}]
                        });
                      },
                      onLoadStart:(InAppWebViewController controller, String url) {
                        setState(() {
                          this.url = url;
                          setState(() {
                            print('onLoadStart current url : $url');
                          });
                        });
                      },
                      onLoadStop: (InAppWebViewController controller, String url) async {
                        setState(() {
                          this.url = url;
                          setState(() {
                            print('onLoadStop current url : $url');
                          });
                        });
                      },
                      onProgressChanged: (InAppWebViewController controller, int progress) {
                        setState(() {
                          this.progress = progress / 100;
                        });
                      },
                      onConsoleMessage: (controller, consoleMessage) {
                        print(consoleMessage);
                        // it will print: {message: {"bar":"bar_value","baz":"baz_value"}, messageLevel: 1}
                      },
                      onReceivedServerTrustAuthRequest: (InAppWebViewController controller, ServerTrustChallenge challenge) async {
                        return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
                      },
                    ),*/