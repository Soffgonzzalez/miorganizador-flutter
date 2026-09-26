import 'package:flutter/material.dart';

class NewActivityScreen extends StatelessWidget {
  const NewActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva actividad')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),

            const Icon(Icons.edit_note, size: 72, color: Colors.indigo),

            const SizedBox(height: 24),

            const Text(
              'Nueva actividad',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            const Text(
              'En los próximos módulos implementaremos el formulario para crear actividades.',
              textAlign: TextAlign.center,
            ),

            const Spacer(),

            FilledButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}