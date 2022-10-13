import 'dart:convert';
import 'dart:developer';

// import 'package:couchdb_test/utils/connectivity.dart';
import 'package:couchdb_test/widgets/toastmessage.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:couchdb_test/models/data_model.dart';
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
  var savedData;
  
  
  getData()async{
    await openBox();
    try{
    //  ConnectivityController().checkForConnectivityChange();
      
    var response = await client.get(Uri.parse('$baseURL/test1/_design/basicinfo/_view/idx?include_docs=true'),
      headers: {'authorization': authHeader},
    );
    if(response.statusCode == 200){
      await box!.put(0, response.body);
      var data = dbDataFromJson(response.body);
      mainList = data.rows as List;
      return mainList;
    }
    } catch(e){
      log(e.toString());
      var data = box!.get(0);
      
      return dbDataFromJson(data).rows;
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
      jsonEncode({
          "name": name,
          "email": email,
          "address":{
            "country": country,
            "zone": zone,
            "city": city
          },
          "country": country,
        }));
        showToastMessage('Data Added');
    }
  }
  
  getDataStoredInBox() async {
    await openBox();
    savedData = box!.get(1);
    box!.delete(1);
    return savedData;
  }
  addDataOffline(encodedData)async{
    try{
     await getUUID();
      var response = await client.put(Uri.parse('$baseURL/test1/$uuid'),
        headers: {'authorization': authHeader},
        body: encodedData
      );
      if(response.statusCode == 201){
        showToastMessage('Data Added');
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