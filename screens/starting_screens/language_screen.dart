import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'login_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _selected;
  final List<Map> _myJson = [
    {
      "id": '1',
      "image": "assets/banks/affinbank.png",
      "name": "English",
    },
    {
      "id": '2',
      "image": "assets/banks/ambank.png",
      "name": "Hindi",
    },
    {
      "id": '3',
      "image": "assets/banks/bankislam.png",
      "name": "Bank Isalm",
    },
    {
      "id": '4',
      "image": "assets/banks/bankrakyat.png",
      "name": "Bank Rakyat",
    },
    {
      "id": '5',
      "image": "assets/banks/bsn.png",
      "name": "Bank Simpanan Nasional",
    },
    {
      "id": '6',
      "image": "assets/banks/cimb.png",
      "name": "CIMB Bank",
    },
    {
      "id": '7',
      "image": "assets/banks/hong-leong-connect.png",
      "name": "Hong Leong Bank"
    },
    {
      "id": '8',
      "image": "assets/banks/hsbc.png",
      "name": "HSBC",
    },
    {
      "id": '9',
      "image": "assets/banks/maybank.png",
      "name": "MayBank2U",
    },
    {
      "id": '10',
      "image": "assets/banks/public-bank.png",
      "name": "Public Bank",
    },
    {
      "id": '11',
      "image": "assets/banks/rhb-now.png",
      "name": "RHB NOW",
    },
    {
      "id": '12',
      "image": "assets/banks/standardchartered.png",
      "name": "Standard Chartered",
    },
    {
      "id": '13',
      "image": "assets/banks/uob.png",
      "name": "United Oversea Bank",
    },
    {
      "id": '14',
      "image": "assets/banks/ocbc.png",
      "name": "OCBC Bank",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 300.0,
            width: 300.0,
            child: Lottie.network(
                "https://assets6.lottiefiles.com/packages/lf20_ggyfnp78.json"),
          ),
          Center(
            child: Container(
              width: 300.0,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.grey),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<String>(
                          isDense: true,
                          hint: const Text("Select Language"),
                          value: _selected,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selected = newValue!;
                            });
                          },
                          items: _myJson.map((Map map) {
                            return DropdownMenuItem<String>(
                              value: map["id"].toString(),
                              // value: _mySelection,
                              child: Row(
                                children: <Widget>[
                                  Image.asset(
                                    map["image"],
                                    width: 25,
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Text(map["name"])),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          SizedBox(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
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
              child: const Padding(
                padding: EdgeInsets.all(14.0),
                child: Text(
                  'Start Registration',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
