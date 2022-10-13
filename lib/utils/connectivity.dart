import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:couchdb_test/utils/styles.dart';
import 'package:couchdb_test/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class CheckConnection extends StatefulWidget {
  const CheckConnection({Key? key}) : super(key: key);

  @override
  _CheckConnectionState createState() => _CheckConnectionState();
  static const String routeName = '/connectivity';
}

class _CheckConnectionState extends State<CheckConnection> {

  String result = '';
  String internet = '';
  @override
  void initState() {
    //check when app opens for first time
    checkInitialConnectivity();
    //checking for change in connectivity
    checkForConnectivityChange();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: black.withOpacity(0.5),
      body: Container(
        decoration: const BoxDecoration(
          color: black
          // image: DecorationImage(
          //   image: const AssetImage("assets/images/background.png"),
          //   fit: BoxFit.cover,
          //   colorFilter: filter,
          // ),
        ),
        width: _width,
        height: _height
      )
    );
  }

  checkInitialConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      navigatorAfterConnection();
    } else {
      showNoInternetDialog();
    }
  }

  checkForConnectivityChange() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
        // if connected after disconnection
        if (internet == 'false') {
          Navigator.pop(context);
        }
        // on first load
        else {
          navigatorAfterConnection();
        }
      } else {
        setState(() {
          internet = 'false';
        });
        showNoInternetDialog();
      }
    });
  }

  navigatorAfterConnection() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
    // var apiToken = read('apiToken');
    // if(apiToken != '') {
      
    // }
    // else{
    //   Get.back();
    // }
  }

  void showNoInternetDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        child: WillPopScope(
          onWillPop: () async {
            Future.value(false);
            return false;
          },
          child: Container(
            height: 200.0,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: const [
                 Icon(MaterialIcons.wifi_off, size: 50.0),
                Padding(
                  padding:  EdgeInsets.only(left: 10.0),
                  child: Text('No Internet Connection'),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
  
}
