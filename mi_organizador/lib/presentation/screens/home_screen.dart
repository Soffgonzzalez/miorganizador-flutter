import 'package:flutter/material.dart';
import 'package:mi_organizador/presentation/screens/new_activity_screen.dart';
import 'package:mi_organizador/presentation/screens/widgets/activity_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MiOrganizador'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mis actividades',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: const [
                  ActivityCard(
                    icon: Icons.school,
                    title: 'Estudiar Flutter',
                    description: 'Leer el material del Módulo 3.',
                    status: 'Pendiente',  
                  ),
                  ActivityCard(
                    icon: Icons.cases,
                    title: 'Preparar reunión',
                    description: 'Preparar los correos y hacer el informe.',
                    status: 'Pendiente',  
                  ),
                  ActivityCard(
                    icon: Icons.music_note,
                    title: 'Sacar entradas',
                    description: 'El miércoles se habilitan las entradas al concierto.',
                    status: 'Pendiente',  
                  ),
                ],
              ), 
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NewActivityScreen()),
                );
              },
              child: const Icon(Icons.add),
              ),
    );
  }
}
