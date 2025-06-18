// screens/result_screen.dart
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final Map<String, dynamic> result;

  ResultScreen(this.result);

  @override
  Widget build(BuildContext context) {
    List<dynamic> foods = result['foods'] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text("Alimentos encontrados")),
      body: ListView.builder(
        itemCount: foods.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(foods[index]['name']),
            subtitle: Text("Confiança: ${foods[index]['confidence'].toStringAsFixed(2)}%"),
          );
        },
      ),
    );
  }
}