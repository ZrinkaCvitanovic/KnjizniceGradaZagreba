import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_library_fe/api/api_client.dart';
import 'package:web_library_fe/controller/list_state.dart';
import 'package:web_library_fe/di.dart';
import 'package:web_library_fe/service/export_service.dart';

class LibraryNotifier extends Notifier<ListState> {
  late final ApiClient _apiClient;

  @override
  ListState build() {
    _apiClient = ref.watch(httpClientProvider);
    fetchLibraries();
    return LoadingState();
  }

  void fetchLibraries() async {
    try {
      state = LoadingState();

      final result = await _apiClient.getLibraries();
      state = SuccessState(result);
    } catch (e) {
      state = ErrorState("Dogodila se pogreška.");
    }
  }

  void filterData(final FilterProperty filter, final String query) async {
    final result = await _apiClient.getLibraries();
    switch (filter) {
      case FilterProperty.any:
        final queryResult = result
            .where((library) =>
                library.name.toLowerCase().contains(query) ||
                library.address.toLowerCase().contains(query) ||
                library.phone.toLowerCase().contains(query) ||
                library.mail.toLowerCase().contains(query) ||
                library.manager.toLowerCase().contains(query) ||
                library.hasWifi.contains(query) ||
                library.hasWarmDrinks.contains(query) ||
                library.hasComputers.contains(query))
            .toList();
        state = SuccessState(queryResult);
      case FilterProperty.name:
        final queryResult = result
            .where((library) => library.name.toLowerCase().contains(query))
            .toList();
        state = SuccessState(queryResult);
      case FilterProperty.address:
        final queryResult = result
            .where((library) => library.address.toLowerCase().contains(query))
            .toList();
        state = SuccessState(queryResult);
      case FilterProperty.phone:
        final queryResult = result
            .where((library) => library.phone.toLowerCase().contains(query))
            .toList();
        state = SuccessState(queryResult);
      case FilterProperty.email:
        final queryResult = result
            .where((library) => library.mail.toLowerCase().contains(query))
            .toList();
        state = SuccessState(queryResult);
      case FilterProperty.manager:
        final queryResult = result
            .where((library) => library.manager.toLowerCase().contains(query))
            .toList();
        state = SuccessState(queryResult);
      case FilterProperty.workingDay:
        final queryResult = result
            .where((library) => library.workingTime
                .contains((time) => time.days.toLowerCase() == query))
            .toList(); //TODO: Fix this
        state = SuccessState(queryResult);
      case FilterProperty.workingHours:
        final queryResult = result
            .where((library) => library.workingTime
                .contains((time) => time.hours.toLowerCase() == query))
            .toList(); //TODO: Fix this
        state = SuccessState(queryResult);
      case FilterProperty.hasWifi:
        final queryResult =
            result.where((library) => library.hasWifi.contains(query)).toList();
        state = SuccessState(queryResult);
      case FilterProperty.hasDrinks:
        final queryResult = result
            .where((library) => library.hasWarmDrinks.contains(query))
            .toList();
        state = SuccessState(queryResult);
      case FilterProperty.hasComputers:
        final queryResult = result
            .where((library) => library.hasComputers.contains(query))
            .toList();
        state = SuccessState(queryResult);
    }
  }

  void resetFilter() => fetchLibraries();

  void exportToJSON() {
    if (state is SuccessState) {
      final listToExport = (state as SuccessState).list;
      listToExport.forEach((lib) => print(lib.name));
      ExportService.exportToJSON(listToExport);
    }
  }

  void exportToCSV() {
    if (state is SuccessState) {
      final listToExport = (state as SuccessState).list;
      listToExport.forEach((lib) => print(lib.name));
      ExportService.exportToCSV(listToExport);
    }
  }
}

enum FilterProperty {
  any("Sva polja (wildcard)"),
  name("Naziv"),
  address("Adresa"),
  phone("Kontakt telefon"),
  email("Kontakt mail"),
  manager("Voditelj"),
  workingDay("Radno vrijeme - Dan"),
  workingHours("Radno vrijeme - Sati"),
  hasWifi("Ima WiFi"),
  hasDrinks("Ponuda toplih napitaka"),
  hasComputers("Računalna oprema");

  final String label;

  const FilterProperty(this.label);
}
