import 'package:flutter/material.dart';
import 'package:web_library_fe/model/library.dart';

class LibraryDataTable extends StatelessWidget {
  final List<Library> libraries;

  const LibraryDataTable({super.key, required this.libraries});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical, // Enables vertical scrolling
        child: DataTable(
          columnSpacing: 20, // Adjusts spacing between columns, if needed
          dataRowMinHeight: 20, // Adjusts the height of each data row
          columns: const [
            DataColumn(
              label:
                  Text("Naziv", style: TextStyle(fontWeight: FontWeight.w900)),
            ),
            DataColumn(
              label:
                  Text("Adresa", style: TextStyle(fontWeight: FontWeight.w900)),
            ),
            DataColumn(
              label: Text(
                "Telefon",
                style: TextStyle(fontWeight: FontWeight.w900),
                overflow: TextOverflow.visible,
                softWrap: true,
              ),
            ),
            DataColumn(
              label: Text(
                "Mail",
                style: TextStyle(fontWeight: FontWeight.w900),
                overflow: TextOverflow.visible,
                softWrap: true,
              ),
            ),
            DataColumn(
              label: Text("Voditelj",
                  style: TextStyle(fontWeight: FontWeight.w900)),
            ),
            DataColumn(
              label: Text("Radno vrijeme",
                  style: TextStyle(fontWeight: FontWeight.w900)),
            ),
            DataColumn(
              label:
                  Text("WiFi", style: TextStyle(fontWeight: FontWeight.w900)),
            ),
            DataColumn(
              label:
                  Text("Kava", style: TextStyle(fontWeight: FontWeight.w900)),
            ),
            DataColumn(
              label: Text("Računalo",
                  style: TextStyle(fontWeight: FontWeight.w900)),
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
        ));
  }
}
