import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_library_fe/controller/library_notifier.dart';
import 'package:web_library_fe/di.dart';
import 'package:web_library_fe/service/export_service.dart';
import 'dart:html' as html;

class LibraryListActions extends ConsumerStatefulWidget {
  const LibraryListActions({super.key});

  @override
  _LibraryFilterState createState() => _LibraryFilterState();
}

class _LibraryFilterState extends ConsumerState<LibraryListActions> {
  final filterController = TextEditingController();
  FilterProperty selectedFilterProperty = FilterProperty.any;

  @override
  void initState() {
    super.initState();
    // Use post-frame callback to ensure DOM is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // This will be called after the widget tree has been built.
      _addIdsToElements();
    });
  }

  void _addIdsToElements() {
    // Here, we're adding the ID attributes to the elements after they have been rendered
    html.document.getElementById('pretraga')?.setAttribute('id', 'pretraga');
    html.document.getElementById('atribu')?.setAttribute('id', 'atribut');
    html.document.getElementById('reset')?.setAttribute('id', 'reset');
    // Add other elements here if needed
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 200,
          child: TextField(
            key: const ValueKey('pretraga'),
            controller: filterController,
            onChanged: _filterLibraries,
          ),
        ),
        const SizedBox(width: 50),
        DropdownMenu(
          key: const ValueKey('atribut'),
          dropdownMenuEntries: FilterProperty.values
              .map<DropdownMenuEntry<FilterProperty>>(
                (filterProperty) => DropdownMenuEntry<FilterProperty>(
                  value: filterProperty,
                  label: filterProperty.label,
                ),
              )
              .toList(),
          initialSelection: selectedFilterProperty,
          onSelected: (FilterProperty? property) {
            setState(() => selectedFilterProperty = property!);
          },
        ),
        const SizedBox(width: 50),
        ElevatedButton(
          key: Key('reset'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlue,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Merriweather',
            ),
          ),
          onPressed: _resetFilter,
          child: const Text("Reset filter"),
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
          onPressed: _exportToJSON,
          child: const Text("Export to JSON"),
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
          onPressed: _exportToCSV,
          child: const Text("Export to CSV"),
        ),
      ],
    );
  }

  void _filterLibraries(final String value) {
    ref.read(libraryNotifierProvider.notifier).filterData(
          selectedFilterProperty,
          value.toLowerCase(),
        );
  }

  void _resetFilter() {
    setState(() {
      selectedFilterProperty = FilterProperty.any;
      filterController.text = '';
    });
    ref.read(libraryNotifierProvider.notifier).resetFilter();
  }

  void _exportToJSON() {
    ref.read(libraryNotifierProvider.notifier).exportToJSON();
  }

  void _exportToCSV() {
    ref.read(libraryNotifierProvider.notifier).exportToCSV();
  }
}
