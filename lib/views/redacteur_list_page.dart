import 'package:flutter/material.dart';
import '../controllers/redacteur_controller.dart';
import '../widgets/redacteur_card.dart';
import 'redacteur_edit_page.dart';
import 'redacteur_delete_page.dart';

class RedacteurListPage extends StatelessWidget {
  const RedacteurListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = RedacteurController();

    return Scaffold(
      appBar: AppBar(title: const Text('Informations des Rédacteurs')),
      body: StreamBuilder(
        stream: controller.streamAll(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final redacteurs = snapshot.data!;
          if (redacteurs.isEmpty) {
            return const Center(child: Text('Aucun rédacteur pour le moment.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemCount: redacteurs.length,
            itemBuilder: (context, index) {
              final r = redacteurs[index];
              return RedacteurCard(
                redacteur: r,
                onEdit: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => RedacteurEditPage(redacteur: r),
                  ));
                },
                onDelete: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => RedacteurDeletePage(redacteur: r),
                  ));
                },
              );
            },
          );
        },
      ),
    );
  }
}
