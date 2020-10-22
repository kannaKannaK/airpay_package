import 'package:airpay_package/model/user.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
class AirpayHome extends StatefulWidget{
  final User user;
  AirpayHome({Key key,@required this.user}) : super(key : key);

  @override
  _AirpayHomeState createState() => _AirpayHomeState();
}

class _AirpayHomeState extends State<AirpayHome> {
  var sha ;
  var md;
  var url ;
 void  _encryptSHA256()
  {
    var date = new DateTime.now();
    var format = DateFormat("yyyy-MM-dd");
    var formattedDate = format.format(date);
    var temp = utf8.encode('${widget.user.secret}@${widget.user.username}:|:${widget.user.password}');
    var privatekey =  sha256.convert(temp);
    var setAllData  = utf8.encode('${widget.user.email}${widget.user.fname}${widget.user.lname}${widget.user.fulladdress}${widget.user.city}${widget.user.state}${widget.user.country}${widget.user.amount}${widget.user.orderid}$formattedDate$privatekey');
    var checksum = md5.convert(setAllData);
    var protocolDomain = getProtoDomain(widget.user.successUrl);
    List<int> bytes =ascii.encode(protocolDomain);
    var encoded = base64.encode(bytes);
    // var decoded = base64.decode(encoded);
    /*print("protocolDomain $protocolDomain");
    print("bytes $bytes");
    print("base64encoded : $encoded");
    print("base64decoded $decoded");*/
    var user = widget.user;
     url = "<!DOCTYPE html>" +
        "<html>" +
        "<body onload='document.frm1.submit()'>" +
        "<form action='https://payments.airpay.ninja/pay/index.php' method='post' name='frm1'>" +
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

  /*  SecurityContext serverContext = new SecurityContext()
      ..useCertificateChain('path/to/my_cert.pem')
      ..usePrivateKey('path/to/my_key.pem');
  var server = await HttpServer.bindSecure('example.com',
  443, // usually, 443
  serverContext,
  backlog: 5);*/
    /* '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<p>
The navigation delegate is set to block navigation to the youtube website.
</p>
<ul>
<ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
<ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
</ul>
</body>
</html>
''';*/
    var sPostData = "mer_dom=" + encoded + "&currency=" + widget.user.currency + "&isocurrency=" + widget.user.isCurrency
        + "&orderid=" + widget.user.orderid + "&privatekey=" + privatekey.toString() + "&checksum=" + checksum.toString()
        + "&mercid=" + widget.user.merchantId + "&buyerEmail=" + widget.user.email + "&buyerPhone=" + widget.user.phone
        + "&buyerFirstName=" + widget.user.fname + "&buyerLastName=" + widget.user.lname + "&buyerAddress=" + widget.user.fulladdress
        + "&buyerCity=" + widget.user.city + "&buyerState=" + widget.user.state + "&buyerCountry=" + widget.user.country
        + "&buyerPinCode=" + widget.user.pincode + "&amount=" + widget.user.amount + "&chmod=" + widget.user.chMode
        + "&customvar=" + widget.user.customVar + "&txnsubtype=" + widget.user.txnSubtype
        + "&wallet=" + widget.user.wallet + widget.user.txnSubtype ;
    print("postdata : $sPostData");
    setState(() {
      sha = privatekey;
      md = checksum;
    });
  }

 String getProtoDomain(String sDomain)
 {
     int slashslash =sDomain.indexOf("//")+2;
     return sDomain.substring(0,sDomain.indexOf("/",slashslash));
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(32.0, 5.0, 32.0, 5.0),
                child: Text(widget.user.fname,style: TextStyle(
                    color: Colors.black,
                    fontSize: 24
                ),),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(32.0, 5.0, 32.0, 5.0),
                child: Text(widget.user.lname,style: TextStyle(
                    color: Colors.black,
                    fontSize: 24
                ),),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(32.0, 5.0, 32.0, 5.0),
                child: Text(widget.user.email,style: TextStyle(
                    color: Colors.black,
                    fontSize: 24
                ),),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(32.0, 5.0, 32.0, 5.0),
                child: Text(widget.user.phone,style: TextStyle(
                    color: Colors.black,
                    fontSize: 24
                ),),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(32.0, 5.0, 32.0, 5.0),
                child: Text(widget.user.city,style: TextStyle(
                    color: Colors.black,
                    fontSize: 24
                ),),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(32.0, 5.0, 32.0, 5.0),
                child: Text(widget.user.state,style: TextStyle(
                    color: Colors.black,
                    fontSize: 24
                ),),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(32.0, 5.0, 32.0, 5.0),
                child: Text(widget.user.country,style: TextStyle(
                    color: Colors.black,
                    fontSize: 24
                ),),
              ),
              Padding(
                padding: EdgeInsets.all(32.0),
                child:  RaisedButton(
                  onPressed: (){
                    _encryptSHA256();
                    Navigator.push(context, MaterialPageRoute(
                       builder:(context) => InAppWebView()
                    ));

                  },
                  child: Text('Encrypt',style: TextStyle(color: Colors.white,fontSize: 16.0),),
                  color: Colors.red,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(32.0, 5.0, 32.0, 5.0),
                child: Text('sha : $sha',style: TextStyle(
                    color: Colors.black,
                    fontSize: 24
                ),),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(32.0, 5.0, 32.0, 5.0),
                child: Text('md5 $md',style: TextStyle(
                    color: Colors.black,
                    fontSize: 24
                ),),
              ),

            ],
          ),
        ),
      ),
    );

  }}