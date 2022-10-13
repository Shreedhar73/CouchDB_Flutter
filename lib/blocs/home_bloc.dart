import 'dart:developer';

import 'package:bloc/bloc.dart';
// import 'package:couchdb_test/models/data_model.dart';
import 'package:couchdb_test/services/api_repo.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';
part 'home_events.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{

 HomeBloc() : super (DataLoading()){
  final ApiRepository _apiRepo = ApiRepository();
  

  on<GetDataEvent>((event,emit) async {
    try{
      emit (DataLoading());
      final dataList = await _apiRepo.fetchData();
      emit(DataLoaded(dataList));
    } catch(e) {
      log(e.toString());
    }
  });


  on<AddDataEvent>((event,emit) async{
    try{
      emit (DataLoading());
      await _apiRepo.addData(event.name,event.email,event.country,event.city);
      final dataList = await _apiRepo.fetchData();
      emit(DataLoaded(dataList));
    }
    catch(e){
      log(e.toString());
    }
  });

 on<DeleteDataEvent>((event,emit) async{
  try{
    emit (DataLoading());
    await _apiRepo.removeDocs(event.docID, event.revID);
    final dataList = await _apiRepo.fetchData();
    emit(DataLoaded(dataList));
  }catch(e){
    log(e.toString());
  }
 });

 on<UpdateDocumentEvent>((event,emit)async{
  try{
    emit (DataLoading());
    await _apiRepo.updateDoc(event.docID,event.rev, event.name, event.email, event.country, event.city);
    final dataList = await _apiRepo.fetchData();
    emit(DataLoaded(dataList));
  }
  catch(e){
    log(e.toString());
  }
 });
 
//  on<ButtonPressedEvent>((event,emit)async {
//   try{
//     emit(ButtonLoading());

//     Future.delayed(const Duration(milliseconds: 20),(){
      
//      emit(ButtonLoadingComplete());
//      }
//     );
//   }catch(e){
//     log(e.toString());
//   }
//  });
 }

 
 
}



