import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth_otp_ui/src/utils/styles.dart';

enum Status { waiting, error }

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen(
      {Key? key, required this.number, required this.navScreen})
      : super(key: key);
  final String number;
  final Widget navScreen;

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final _textEditingController = TextEditingController();
  var _status = Status.waiting;
  String? _verificationId;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _verifyPhoneNumber();
  }

  Future<void> _verifyPhoneNumber() async {
    _auth.verifyPhoneNumber(
        phoneNumber: widget.number.trim(),
        verificationCompleted:
            (PhoneAuthCredential phonesAuthCredentials) async {},
        verificationFailed: (FirebaseAuthException verificationFailed) async {
          print('fffffffffffffffffffffffffffffff $verificationFailed ');
        },
        codeSent: (String verificationId, int? resendingToken) async {
          print('eeeeeeeeeeeeeeeeeeeeeeeeeeeee $verificationId');
          setState(() {
            _verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) async {});
  }

  Future _sendCodeToFirebase({String? code}) async {
    if (_verificationId != null) {
      var credential = PhoneAuthProvider.credential(
          verificationId: _verificationId!, smsCode: code!);

      await _auth
          .signInWithCredential(credential)
          .then((value) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => widget.navScreen));
          })
          .whenComplete(() {})
          .onError((error, stackTrace) {
            setState(() {
              _textEditingController.text = "";
              _status = Status.error;
            });
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kAppColor,
      ),
      body: _status != Status.error
          ? Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: shadowContainer(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'OTP Verification',
                    style: boldLabel(),
                  ),
                  Text(
                    'Enter 6 digit code sent to your mobile number',
                    style: simpleLabel(),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.number,
                    style: const TextStyle(
                        fontSize: 18, fontFamily: 'medium', color: kAppColor),
                  ),
                  const SizedBox(height: 20),
                  CupertinoTextField(
                    onChanged: (value) async {
                      if (value.length == 6) {
                        _sendCodeToFirebase(code: value);
                      }
                    },
                    textAlign: TextAlign.center,
                    style: const TextStyle(letterSpacing: 30, fontSize: 30),
                    maxLength: 6,
                    controller: _textEditingController,
                    keyboardType: TextInputType.number,
                    autofillHints: const <String>[
                      AutofillHints.telephoneNumber
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text('Didn\'t receive the OTP?'),
                          TextButton(
                            onPressed: () async {
                              setState(() {
                                _status = Status.waiting;
                              });
                              _verifyPhoneNumber();
                            },
                            child: const Text(
                              'RESEND OTP',
                            ),
                          ),
                        ],
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          _sendCodeToFirebase(
                              code: _textEditingController.text);
                        },
                        backgroundColor: kAppColor,
                        elevation: 0,
                        child: const Icon(Icons.arrow_forward),
                      )
                    ],
                  )
                ],
              ),
            )
          : Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: shadowContainer(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'OTP Verification',
                    style: boldLabel(),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'The code used is invalid!',
                    style: TextStyle(
                        fontSize: 18, fontFamily: 'medium', color: Colors.red),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Edit Number')),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Didn\'t receive the OTP?'),
                      TextButton(
                        onPressed: () async {
                          setState(() {
                            _status = Status.waiting;
                          });
                          _verifyPhoneNumber();
                        },
                        child: const Text(
                          'RESEND OTP',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
