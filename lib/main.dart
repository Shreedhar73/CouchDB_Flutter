import 'package:couchdb_test/models/data_model.dart';
import 'package:couchdb_test/utils/connectivity_controller.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'utils/styles.dart';
import 'views/home.dart';

void main() async{
  Hive.registerAdapter(DbDataAdapter());

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ValueNotifier online = ValueNotifier(true);
  // String internet = '';
  final ConnectivityController connectionController = ConnectivityController();
  // This widget is the root of your application.
  @override
  void initState() {
    connectionController.checkInitialConnectivity();
    connectionController.checkForConnectivityChange();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CouchDB_Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            ValueListenableBuilder(
              valueListenable: connectionController.online,
              builder: (context,a,b)=>  
              Positioned(
                // top: kToolbarHeight+530,
                bottom:0,
                child: Visibility(
                  maintainSize: true, 
                  maintainAnimation: true,
                  maintainState: true,
                  visible: !connectionController.online.value,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 20,
                    child: FloatingActionButton(
                      shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.zero
                      ),
                      backgroundColor: red,
                      onPressed: (){},
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Center(child: Text('Offline',style: TextStyle(color: white, fontSize: 12.0, letterSpacing: 3)))
                      ),
                    ),
                  ),
                )
              ) ,
            )
          ],
        );
      },
    );
  }

  // checkInitialConnectivity() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
  //      online.value = true;
  //     // navigatorAfterConnection();
  //   } else {
  //     online.value = false;
  //   }
  // }

  // checkForConnectivityChange() {
  //   Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
  //     if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
  //       // if connected after disconnection
  //       if (internet == '') {
  //         online.value = true;
  //         // Navigator.pop(context);
  //       }
  //       // on first load
  //       else {
  //         online.value = false;
  //         // navigatorAfterConnection();
  //       }
  //     } else {
  //       setState(() {
  //         internet = 'false';
  //         online.value = false;
  //       });
  //       // showNoInternetDialog();
  //     }
  //   });
  // }
}
