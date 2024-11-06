import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_library_fe/controller/list_state.dart';
import 'package:web_library_fe/di.dart';
import 'package:web_library_fe/pages/widgets/library_data_table.dart';

class LibraryTable extends ConsumerWidget {
  const LibraryTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final libraries = ref.watch(libraryNotifierProvider);
    switch (libraries) {
      case LoadingState():
        return const Center(child: CircularProgressIndicator.adaptive());
      case SuccessState(list: var libraries):
        return LibraryDataTable(libraries: libraries);
      case ErrorState(message: var errorMessage):
        return Text(
          errorMessage,
          style: const TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        );
    }
  }
}
