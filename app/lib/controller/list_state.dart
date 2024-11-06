import 'package:web_library_fe/model/library.dart';

sealed class ListState {}

class LoadingState extends ListState {}

class SuccessState extends ListState {
  final List<Library> list;

  SuccessState(this.list);
}

class ErrorState extends ListState {
  final String message;

  ErrorState(this.message);
}
