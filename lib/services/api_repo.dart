
// import 'package:couchdb_test/models/data_model.dart';
import 'package:couchdb_test/services/api_services.dart';

class ApiRepository {
  final _provider = RemoteService();

  Future<dynamic> fetchData() {
    return _provider.getData();
  }

  Future <dynamic> addData(name,email,country,city){
    return _provider.addData(name, email,country: country,city: city);
  }

  removeDocs(docID,revID){
    return _provider.deleteDocument(docID, revID);
  }

  updateDoc(docID,rev,name,email,[country,zone,city]){
    return _provider.updateDocument(docID,rev,name,email,country,zone,city);
  }
}

class NetworkError extends Error {}