import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitbit Connect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Fitbit connect'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Fitbit Connect"),
          onPressed: () {
            _fitbitConnect();
        },)
      ),
    );
  }

  _fitbitConnect() async {
    const fitbitClientID = "";
    const fitbitCallbackURL = ""; //"https://www.server.com/fitbit/fitbit_callback/";
    String? loginID = "";
    String? urlScheme = "";
    String? code;

    Uri url = Uri.https("www.fitbit.com", "/oauth2/authorize",
        {"response_type": "code", "client_id": fitbitClientID, "redirect_uri": fitbitCallbackURL, "state": loginID, "scope": "activity sleep settings"});
    try {
      final result = await FlutterWebAuth.authenticate(url: url.toString(), callbackUrlScheme: urlScheme, preferEphemeral: true);
      code = Uri.parse(result).queryParameters['code'];
      if (kDebugMode) {
        print("code: $code");
      }
    } catch (e) {
      //print("error: " + e.toString());
      return false;
    }
    if (code == "200") {
      try {


      } catch (e) {
        if (kDebugMode) {
          print("Couldn't connect to Fitbit : $e");
        }
        return false;
      }
    } else {
      if (kDebugMode) {
        print("error code $code, could not connect");
      }
      return false;
    }
  }
}
