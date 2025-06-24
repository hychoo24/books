import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/inventory_provider.dart';
import 'inventory_form.dart';
import 'inventory_detail.dart';


class InventoryTable extends StatefulWidget {
  const InventoryTable({super.key});

  @override
  State<InventoryTable> createState() => _InventoryTableState();
}

class _InventoryTableState extends State<InventoryTable> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InventoryProvider>(context);
    final items = provider.inventories.where((item) {
      final query = _searchController.text.toLowerCase();
      return item.name.toLowerCase().contains(query);
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        labelText: 'Search Inventory',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Add Inventory'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple, // Warna ungu
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      minimumSize: const Size(150, 37), // Lebar & tinggi minimum tombol
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const InventoryForm(),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: DataTable(
                    columnSpacing: 32,
                    columns: const [
                      DataColumn(label: SizedBox(width: 60, child: Text('ID'))),
                      DataColumn(label: SizedBox(width: 220, child: Text('Name'))),
                      DataColumn(label: SizedBox(width: 120, child: Text('Total'))),
                      DataColumn(label: SizedBox(width: 180, child: Text('Category'))),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows: items.map((item) {
                      return DataRow(cells: [
                        DataCell(SizedBox(width: 60, child: Text(item.id.toString()))),
                        DataCell(SizedBox(width: 220, child: Text(item.name))),
                        DataCell(SizedBox(width: 120, child: Text(item.quantity.toString()))),
                        DataCell(SizedBox(width: 180, child: Text(item.category?.name ?? '-'))),
                        DataCell(Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.visibility),
                              tooltip: 'See More',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => InventoryDetail(inventory: item),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              tooltip: 'Edit',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => InventoryForm(inventory: item),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              tooltip: 'Delete',
                              onPressed: () {
                                provider.deleteInventory(item.id);
                              },
                            ),
                          ],
                        )),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
