import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:phone_auth_otp_ui/src/datas/datas.dart';
import 'package:phone_auth_otp_ui/src/screens/screens.dart';

import 'package:http/http.dart' as http;

import '../utils/styles.dart';

class EditNumberScreen extends StatefulWidget {
  const EditNumberScreen({Key? key, required this.navScreen}) : super(key: key);
  final Widget navScreen;

  @override
  State<EditNumberScreen> createState() => _EditNumberScreenState();
}

class _EditNumberScreenState extends State<EditNumberScreen> {
  final _enterPhoneNumber = TextEditingController();

  String? dataResult;
  late String data;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getCountryPhoneCode();
  }

  Future getCountryPhoneCode() async {
    var response = await http.get(Uri.parse('http://ip-api.com/json'));
    var jsonResponse = json.decode(response.body);
    final isoCode = jsonResponse['countryCode'];

    setState(() {
      data =
          "+${countryList.firstWhere((element) => element.isoCode == isoCode, orElse: () => countryList.first).phoneCode}";

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kAppColor,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: shadowContainer(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Verification',
              style: boldLabel(),
            ),
            Text(
              'Enter your mobile number to Login or Register',
              style: simpleLabel(),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                InkWell(
                  onTap: () async {
                    dataResult = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SelectCountryScreen()));

                    setState(() {
                      if (dataResult != null) {
                        data = dataResult!;
                      }
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 16),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 12),
                    decoration: codeContainer(),
                    child: Row(
                      children: [
                        isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : Text(data),
                        const Icon(Icons.arrow_drop_down, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _enterPhoneNumber,
                    decoration: textInputDecoration('Enter your mobile'),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                    child: Text(
                        'You will receive an OTP on the number you entered')),
                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OTPVerificationScreen(
                                  number: data + _enterPhoneNumber.text, navScreen: widget.navScreen,
                                )));
                  },
                  backgroundColor: kAppColor,
                  elevation: 0,
                  child: const Icon(Icons.arrow_forward),
                )
              ],
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  codeContainer() {
    return BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(width: 1, color: (Colors.grey[300])!));
  }
}
