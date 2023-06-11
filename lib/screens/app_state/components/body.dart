import 'dart:async';
import 'package:chainlink_project/screens/ad_screen/ad_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:web3dart/web3dart.dart';
import 'package:chainlink_project/admodConsumer.g.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

int redIndex = 0;
List<String> textHolder = [
  "This app is powered by Chainlink, Google, and Transak",
  "Thank you so much for participating with us to support hundreds of people/animals/environment around the world",
  "Please gracefully enjoy today's journey"
];
late Timer timer;

Future<bool> checkContractStatus() async {
  await dotenv.load(fileName: "assets/.env");
  var rpcUrl =
      "https://polygon-mumbai.g.alchemy.com/v2/${dotenv.get('TokenID', fallback: 'Default fallback value')}";
  var wsUrl =
      "wss://polygon-mumbai.g.alchemy.com/v2/${dotenv.get('TokenID', fallback: 'Default fallback value')}";

  final client = Web3Client(rpcUrl, http.Client(), socketConnector: () {
    return IOWebSocketChannel.connect(wsUrl).cast<String>();
  });

  final EthereumAddress contractAddr =
      EthereumAddress.fromHex('0xe5F9A27e96267c7bdF62EB3FBd53a91e348dB6e8');

  final linkContract = AdmodConsumer(address: contractAddr, client: client);

  var isEligible = await linkContract.isEligible();

  return isEligible;
}

Future<int> fetchGoogleEarning() async {
  var logger = Logger();
  int earning;

  earning = await http
      .get(Uri.parse(
          'https://testapi.io/api/Hayden27/v1/accounts/pub-9988776655443322/networkReport'))
      .then((response) {
    Map<String, dynamic> data = jsonDecode(response.body);
    logger.d(data["row"]["metricValues"]["ESTIMATED_EARNINGS"]["microsValue"]);
    earning = data["row"]["metricValues"]["ESTIMATED_EARNINGS"]["microsValue"];

    return earning;
  });
  return earning;
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        redIndex++;
        if (redIndex > 2) redIndex = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: [
        Column(
          children: [
            Container(
              height: 200,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.blue[400],
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0)),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 10, color: Colors.black, offset: Offset(1, 3))
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "Current Status from AdmodConsumer Contract: ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const SizedBox(height: 12),
                  FutureBuilder(
                    future: checkContractStatus(),
                    builder: (c, s) {
                      if (s.hasData) {
                        var status = s.data == true ? "Active" : "Inactive";
                        return Text(
                          "Contract Status: $status",
                          style: TextStyle(
                              color: Colors.blue.shade900,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 145,
          left: 35,
          child: Container(
            width: 320,
            height: 200,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.blue.shade900,
              border: Border.all(width: 1.0, color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 10, color: Colors.black, offset: Offset(1, 3))
              ],
            ),
            child: Column(
              children: [
                const Text(
                  "Google Earning this week: ",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 0),
                  child: FutureBuilder(
                    future: fetchGoogleEarning(),
                    builder: (c, s) {
                      if (s.hasData) {
                        double earning = double.parse(s.data.toString());
                        if (earning != null) earning = earning! / 1000000;
                        return Text(
                          "$earning\$",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 26),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 350,
          child: Container(
            width: 350,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Column(
              children: [
                Text(
                  textHolder[redIndex],
                  style: TextStyle(
                    color: Colors.red[300],
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DancingScript',
                    fontSize: 28,
                    shadows: const [
                      Shadow(
                        blurRadius: 50.0,
                        color: Colors.blue,
                        offset: Offset(1.0, 1.0),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Admod()),
                  );
                },
                child: Text("Start game"),
                style: ButtonStyle(),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
