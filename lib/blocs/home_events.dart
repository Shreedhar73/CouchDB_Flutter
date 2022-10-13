// ignore_for_file: prefer_typing_uninitialized_variables

part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetDataEvent extends HomeEvent{}
class AddDataEvent extends HomeEvent{
  const AddDataEvent({this.name,this.email,this.country,this.city});
  final name;
  final email;
  final country;
  final city;
}

class DeleteDataEvent extends HomeEvent{
  const DeleteDataEvent({this.docID,this.revID});
  final docID;
  final revID;
}

class UpdateDocumentEvent extends HomeEvent{
  const UpdateDocumentEvent({this.docID,this.id,this.rev,this.name,this.email,this.country,this.zone,this.city});
  final docID;
  final id;
  final rev;
  final name;
  final email;
  final country;
  final city;
  final zone;
}

// class ButtonPressedEvent extends HomeEvent{
//   const ButtonPressedEvent({ this.onpressed });
//   final onpressed;
// }