import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CardWidgetState createState() => _CardWidgetState();
}


class _CardWidgetState extends State<CardWidget> {
  bool _isDescriptionVisible = false;

  void _toggleDescriptionVisibility() {
    setState(() {
      _isDescriptionVisible = !_isDescriptionVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Card Widget'),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    'data:image/jpeg;base64,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',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 12.0),
                const Text(
                  'Тема',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                if (_isDescriptionVisible)
                  const Text(
                    'Какая то подтема',
                    style: TextStyle(fontSize: 16.0, color: Colors.black87),
                  ),
                const SizedBox(height: 12.0),
                ElevatedButton(
                  onPressed: _toggleDescriptionVisibility,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    _isDescriptionVisible ? "Hide Details" : "Show Details",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
