
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

import '../services/api_services.dart';

class ConnectivityController{
  String result = '';
  String internet = '';
  ValueNotifier online = ValueNotifier(false);


  checkInitialConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      online.value = true;
    } else {
      online.value = false;
    }
    checkForConnectivityChange();
  }

  checkForConnectivityChange() async{
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result)async {
      if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
       var x = await RemoteService().getDataStoredInBox();
      if(x != null ) {
        await RemoteService().addDataOffline(x);
        x = null;
      }else{}
      online.value = true;
      await RemoteService().getData();

      }
      else{
        online.value = false;
      }
    });
  }
}