import 'package:flutter/material.dart';
import 'package:web_library_fe/model/library.dart';

class LibraryDataTable extends StatelessWidget {
  final List<Library> libraries;

  const LibraryDataTable({super.key, required this.libraries});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(
          label: Text("Naziv", style: TextStyle(fontWeight: FontWeight.w900)),
        ),
        DataColumn(
          label: Text("Adresa", style: TextStyle(fontWeight: FontWeight.w900)),
        ),
        DataColumn(
          label: Text("Kontakt telefon", style: TextStyle(fontWeight: FontWeight.w900)),
        ),
        DataColumn(
          label: Text("Kontakt mail", style: TextStyle(fontWeight: FontWeight.w900)),
        ),
        DataColumn(
          label: Text("Voditelj", style: TextStyle(fontWeight: FontWeight.w900)),
        ),
        DataColumn(
          label: Text("Radno vrijeme", style: TextStyle(fontWeight: FontWeight.w900)),
        ),
        DataColumn(
          label: Text("Ima WiFi", style: TextStyle(fontWeight: FontWeight.w900)),
        ),
        DataColumn(
          label: Text("Ponuda toplih napitaka", style: TextStyle(fontWeight: FontWeight.w900)),
        ),
        DataColumn(
          label: Text("Računalna oprema", style: TextStyle(fontWeight: FontWeight.w900)),
        ),
      ],
      rows: libraries
          .map(
            (library) => DataRow(
              cells: [
                DataCell(Text(library.name)),
                DataCell(Text(library.address)),
                DataCell(Text(library.phone)),
                DataCell(Text(library.mail)),
                DataCell(Text(library.manager)),
                DataCell(Text(library.workingTime.toString())),
                DataCell(Text(library.hasWifi)),
                DataCell(Text(library.hasWarmDrinks)),
                DataCell(Text(library.hasComputers)),
              ],
            ),
          )
          .toList(),
    );
  }
}
