// import 'package:bloc/bloc.dart';

// import '../services/api_services.dart';

// class DataCubit extends Cubit<dynamic> {
//   DataCubit() : super(null);

//   void getPosts() async {
//     // await RemoteService().openBox();
//     // var savedData = RemoteService().box!.get(1);
//     //   if(savedData != null ){
//     //     addOfflineData(savedData);
//     //   }else{}
//     RemoteService().getData().then((value) {
//       emit(value);
//     });
//   }

//   removePosts(docID,revID) async {
//     RemoteService().deleteDocument(docID, revID).then((value) {
//       getPosts();
//       // emit(value);
//     });
//   }

//   addDocs(name,email,{country,zone,city}) async{
//     RemoteService().addData(name, email,country: country,city: city,zone: zone).then((value) {
//       getPosts();
//     });
//   }

//   addOfflineData(encodedData) async{
//     RemoteService().addDataOffline(encodedData).then((value) {
//       getPosts();
//     });
//   }

//   // void getPostsID(id) async {
//   //   RemoteServices().fetchPostsID(id).then((value) {
//   //     emit(value);
//   //   });
//   // }
//   Future<void> handleRefresh() async {
//     // await Future.delayed(const Duration(seconds: 1));
//     getPosts();
//   }
// }