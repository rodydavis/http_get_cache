import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_get_cache/http_get_cache.dart';
import 'package:http_get_cache/http_image_provider.dart';
import 'package:signals/signals_flutter.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final client = httpClient();

  static const target = 'https://jsonplaceholder.typicode.com/todos';
  final requestCount$ = signal(0);
  late final items$ = client
      .get(Uri.parse(target))
      .then((res) => res.statusCode == 200 ? jsonDecode(res.body) as List : [])
      .then((items) => items.cast<Map<String, Object?>>())
      .then(
        (r) => () {
          requestCount$.value++;
          return r;
        }(),
      )
      .toSignal();

  @override
  Widget build(BuildContext context) {
    final state = items$.watch(context);
    final count = requestCount$.watch(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Items: $count')),
        body: state.map(
          data: (items) {
            if (items.isEmpty) {
              return const Center(child: Text('No items found'));
            }
            const height = 100;
            return ListView.builder(
              itemCount: items.length,
              itemExtent: height.toDouble(),
              itemBuilder: (context, index) {
                final item = items[index];
                final title = item['title'] as String;
                return ListTile(
                  title: Image(
                    image: HttpImageProvider(
                      Uri.parse(
                          'https://via.assets.so/img.jpg?w=400&h=$height&t=$title'),
                      client: client,
                    ),
                  ),
                );
              },
            );
          },
          error: (error) => Center(child: Text('Error loading items: $error')),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: items$.refresh,
          tooltip: 'Refresh items',
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}
