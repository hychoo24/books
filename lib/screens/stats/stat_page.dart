import 'package:books/providers/stat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'book_stat.dart';
import 'inventory_stat.dart';

class StatPage extends StatefulWidget {
  const StatPage({super.key});

  @override
  State<StatPage> createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<StatProvider>(context, listen: false).fetchStats();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Statistik Homepage")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            BookStat(),
            SizedBox(height: 24),
            InventoryStat(),
          ],
        ),
      ),
    );
  }
}
