// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../core/utils/image_picker_helper.dart';
import '../core/services/api_service.dart';
import 'result_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _loading = false;

  Future<void> _uploadAndAnalyze(BuildContext context) async {
    setState(() => _loading = true);
    final image = await pickImageFromGallery();
    if (image == null) return;

    try {
      final result = await ApiService().analyzeFood(image);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(result),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao processar imagem")),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Analise sua refeição")),
      body: Center(
        child: _loading
            ? CircularProgressIndicator()
            : ElevatedButton.icon(
                onPressed: () => _uploadAndAnalyze(context),
                icon: Icon(Icons.camera_alt),
                label: Text("Tirar foto ou escolher da galeria"),
              ),
      ),
    );
  }
}