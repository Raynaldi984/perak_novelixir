import 'package:flutter/material.dart';

class WritePage extends StatelessWidget {
  const WritePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Write'),
        backgroundColor: Colors.grey[850],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
// Navigate to create new story editor
              },
              icon: const Icon(Icons.add),
              label: const Text(
                'Create New Story',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
// Navigate to continue writing editor
              },
              child: const Text(
                'Continue Writing',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
