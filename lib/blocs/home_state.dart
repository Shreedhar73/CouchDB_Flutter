part of 'home_bloc.dart';
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class DataLoading extends HomeState {
  // @override
  // List<Object?> get props => [];
}

class DataLoaded extends HomeState {
  final dynamic data;
  const DataLoaded(this.data);  
}

class DataError extends HomeState {
  final String ? message;
  const DataError(this.message);
}

class ButtonLoading extends HomeState{}

class ButtonLoadingComplete extends HomeState{}