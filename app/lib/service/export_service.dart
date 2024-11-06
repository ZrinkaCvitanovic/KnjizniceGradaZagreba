import 'dart:convert';
import 'dart:html' as html;
import 'package:csv/csv.dart';
import 'package:web_library_fe/model/library.dart';

class ExportService {
  static void exportToCSV(final List<Library> listToExport) {
    List<List<dynamic>> rows = [
      [
        "ID",
        "Naziv",
        "Adresa",
        "KontaktTelefon",
        "KontaktEmail",
        "Voditelj",
        "RadnoVrijeme",
        "NudiWiFi",
        "NudiTopleNapitke",
        "NudiRacunalo",
      ]
    ];

    for (Library library in listToExport) {
      final workingHours = library.workingTime
          .map((time) => "${time.days}: ${time.hours}")
          .join(",");

      rows.add([
        library.id,
        library.name,
        library.address,
        library.phone,
        library.mail,
        library.manager,
        workingHours,
        library.hasWifi,
        library.hasWarmDrinks,
        library.hasComputers,
      ]);
    }

    String csvData = const ListToCsvConverter().convert(rows);

    _downloadFromBrowser(csvData, "csv");
  }

  static void exportToJSON(final List<Library> listToExport) {
    final String jsonData =
        jsonEncode(listToExport.map((library) => library.toJson()).toList());

    _downloadFromBrowser(jsonData, "json");
  }

  static void _downloadFromBrowser(String dataToExport, String fileExtension) {
    final bytes = utf8.encode(dataToExport);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    html.AnchorElement(href: url)
      ..setAttribute("download", "knjiznice.$fileExtension")
      ..click();

    html.Url.revokeObjectUrl(url);
  }
}
