// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:developer';

// import 'package:couchdb_test/utils/connectivity.dart';
import 'package:couchdb_test/widgets/toastmessage.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
// import 'package:couchdb_test/models/data_model.dart';
import 'package:path_provider/path_provider.dart';

class RemoteService {
  Box? box;
  var client = http.Client();
  var authHeader = 'Basic ' + base64Encode('admin:admin'.codeUnits);
  var baseURL = 'http://192.168.2.148:5984'; // use local ip address where
  var uuid = '';
  var mainList = [];
  Future openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('data');
    return;
  }
  List savedData = [] ;
  
  
  getData()async{
    await openBox();
    try{
    //  ConnectivityController().checkForConnectivityChange();
      
    var response = await client.get(Uri.parse('$baseURL/test1/_design/basicinfo/_view/idx?include_docs=true'),
      headers: {'authorization': authHeader},
    );
    if(response.statusCode == 200){
      var rawResponse = response.body;
      await box!.put(0,jsonDecode(rawResponse)['rows']);
      var data = jsonDecode(rawResponse)['rows'];
      mainList = data as List;
      return mainList;
    }
    } catch(e){
      log(e.toString());
      var data = await getDataStoredInBox();
      return List<dynamic>.from(data[0]);
    }
  }

  addData(name,email,{country,zone,city}) async{
    await openBox();
    // var online = ConnectivityController().checkForConnectivityChange();
    try{
      await getUUID();
      var response = await client.put(Uri.parse('$baseURL/test1/$uuid'),
        headers: {'authorization': authHeader},
        body: jsonEncode({
          "name": name,
          "email": email,
          "address":{
            "country": country,
            "zone": zone,
            "city": city
          },
          "country": country,
        })
      );
      if(response.statusCode == 201){
        showToastMessage('Data Added');
      }
      
    } catch (e){
      log(e.toString());
      box!.put(1,
     {
      "value" : {
        "name" : name,
        "email": email,
      },
      "doc" : {
          "name": name,
          "email": email,
          "address":{
            "country": country,
            "zone": zone,
            "city": city
          },
          "country": country,
        }
      }
      );
        showToastMessage('Data Added');
    }
  }
  
  getDataStoredInBox() async {
    await openBox();
    // savedData = [];
    var oldData = box!.get(0);
    var boxData = box!.get(1);
    boxData != null ? savedData.add( box!.get(1)) : null;
    if(savedData != null) { 
      // oldData.add(savedData);
      savedData.forEach((element) {
        oldData.add(element);
      });
     
    }
    // box!.delete(1);
    return [oldData,savedData];
  }
  addDataOffline(encodedData)async{
    try{
     await getUUID();
      var response = await client.put(Uri.parse('$baseURL/test1/$uuid'),
        headers: {'authorization': authHeader},
        body: jsonEncode({
          "name": encodedData['name'],
          "email": encodedData['email'],
          "address":{
            "country": encodedData['country'],
            "zone": encodedData['zone'],
            "city": encodedData['city']
          },
          "country": encodedData['country'],
        })
      );
      if(response.statusCode == 201){
        showToastMessage('Data Added');
        savedData = [];
        box!.delete(1);
      }} catch(e){
        log(e.toString());
      }

  }

  getUUID() async{
    try{
      var response = await client.get(Uri.parse('$baseURL/_uuids'),
        headers: {'authorization': authHeader},
      );
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        uuid = data['uuids'][0];
      }
    } catch (e){
      log(e.toString());
    }
  }

  deleteDocument(docID,revID) async{
    try{
      var response = await client.delete(Uri.parse('$baseURL/test1/$docID?rev=$revID',),
        headers: {'authorization': authHeader},
      );
      if(response.statusCode == 200){
        showToastMessage('Data Deleted');
      }
    } catch (e){
      log(e.toString());
    }

  }
  
  updateDocument(docID,rev,name,email,[country,zone,city]) async{
    try{
      var response = await client.put(Uri.parse('$baseURL/test1/$docID'),
        headers: {'authorization': authHeader},
        body: jsonEncode({
          "_id": docID,
          "_rev": rev,
          "name": name,
          "email": email,
          "address":{
            "country": country,
            "zone": zone,
            "city": city
          },
          "country": country,
        })

      );
      if(response.statusCode == 201){
        showToastMessage("Data Updated");
      }

    }
    catch(e){
      log(e.toString());
    }
  }


 
}