import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_library_fe/api/api_client.dart';
import 'package:web_library_fe/controller/library_notifier.dart';
import 'package:web_library_fe/controller/list_state.dart';

final httpClientProvider = Provider<ApiClient>(
  (ref) => ApiClient(),
);

final libraryNotifierProvider = NotifierProvider<LibraryNotifier, ListState>(
  () => LibraryNotifier(),
);
