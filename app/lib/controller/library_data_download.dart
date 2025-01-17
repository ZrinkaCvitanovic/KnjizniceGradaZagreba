import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'library_notifier.dart';
import 'list_state.dart';

final libraryNotifierProvider = NotifierProvider<LibraryNotifier, ListState>(
  () => LibraryNotifier(),
);

class DownloadButtons extends ConsumerWidget {
  const DownloadButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final libraryNotifier = ref.watch(libraryNotifierProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            libraryNotifier.exportToJSON();
          },
          icon: const Icon(Icons.download),
          label: const Text("Preuzmi JSON filtrirani"),
        ),
        const SizedBox(width: 10),
        ElevatedButton.icon(
          onPressed: () {
            libraryNotifier.exportToCSV();
          },
          icon: const Icon(Icons.download),
          label: const Text("Preuzmi CSV filtrirani"),
        ),
        const SizedBox(width: 10),
        ElevatedButton.icon(
          onPressed: () {
            libraryNotifier.exportToJSON();
          },
          icon: const Icon(Icons.download),
          label: const Text("Preuzmi JSON"),
        ),
        const SizedBox(width: 10),
        ElevatedButton.icon(
          onPressed: () {
            libraryNotifier.exportToCSV();
          },
          icon: const Icon(Icons.download),
          label: const Text("Preuzmi CSV"),
        ),
      ],
    );
  }
}

class RefreshButton extends ConsumerWidget {
  const RefreshButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final libraryNotifier = ref.watch(libraryNotifierProvider.notifier);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlue,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Merriweather',
            ),
          ),
          onPressed: libraryNotifier.exportToJSON,
          child: const Text("Preuzmi osvježene preslike JSON"),
        ),
        const SizedBox(width: 50),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlue,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Merriweather',
            ),
          ),
          onPressed: libraryNotifier.exportToCSV,
          child: const Text("Preuzmi osvježene preslike CSV"),
        ),
      ],
    );
  }
}
