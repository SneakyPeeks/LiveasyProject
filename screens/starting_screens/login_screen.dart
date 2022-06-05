import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../main_screens/home_screen.dart';

enum LoginScreen { showMobileWidget, showOtpWidget }

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  LoginScreen currentState = LoginScreen.showMobileWidget;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationID = "";

  void signOutME() async {
    await _auth.signOut();
  }

  void signInWithPhoneAuthCred(AuthCredential phoneAuthCredential) async {
    try {
      final authCred = await _auth.signInWithCredential(phoneAuthCredential);

      if (authCred.user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home(),),);
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Some Error Occurred. Try Again Later')));
    }
  }

  showMobilePhoneWidget(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        SizedBox(
          height: 200,
          child: Lottie.network(
              "https://assets1.lottiefiles.com/packages/lf20_ctVPin.json"),
        ),
        const SizedBox(
          height: 20.0,
        ),
        const Text(
          "Verify Your Phone Number",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: TextField(
            controller: phoneController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(10)),
              prefix: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '+91',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              suffixIcon: const Icon(
                Icons.phone,
                color: Colors.green,
                size: 30,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 28,
        ),
        ElevatedButton(
          onPressed: () async {
            await _auth.verifyPhoneNumber(
                phoneNumber: "+91${phoneController.text}",
                verificationCompleted: (phoneAuthCredential) async {},
                verificationFailed: (verificationFailed) {},
                codeSent: (verificationID, resendingToken) async {
                  setState(() {
                    currentState = LoginScreen.showOtpWidget;
                    this.verificationID = verificationID;
                  });
                },
                codeAutoRetrievalTimeout: (verificationID) async {});
          },
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(14.0),
            child: Text(
              'Send OTP For Verification',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Spacer()
      ],
    );
  }

  showOtpFormWidget(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        SizedBox(
          width: 300,
          child: Lottie.network(
              "https://assets3.lottiefiles.com/packages/lf20_tvcrgegy.json"),
        ),
        const Text(
          'Verification',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          "Enter Your OTP Code Number",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black38,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: TextField(
            controller: otpController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              helperStyle: const TextStyle(),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black12),
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: "Enter Your OTP",
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            AuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
                verificationId: verificationID, smsCode: otpController.text);
            signInWithPhoneAuthCred(phoneAuthCredential);
          },
          child: const Padding(
            padding: EdgeInsets.all(14.0),
            child: Text(
              'Verify OTP',
              style: TextStyle(fontSize: 16),
            ),
          ),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.blueAccent),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Spacer()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: currentState == LoginScreen.showMobileWidget
          ? showMobilePhoneWidget(context)
          : showOtpFormWidget(context),
    );
  }
}
