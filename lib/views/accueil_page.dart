import 'package:flutter/material.dart';
import 'redacteur_list_page.dart';
import 'redacteur_add_page.dart';

class AccueilPage extends StatelessWidget {
  const AccueilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Magazine Infos — Accueil')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text('Gestion des Rédacteurs', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Ajouter un Rédacteur'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RedacteurAddPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Informations des Rédacteurs'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RedacteurListPage()));
              },
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text('Magazine Infos', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Application MVC pour gérer les rédacteurs (Firestore temps réel).'),
          SizedBox(height: 16),
          _IconRow(),
        ],
      ),
    );
  }
}

class _IconRow extends StatelessWidget {
  const _IconRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        _IconItem(icon: Icons.phone, label: 'Tel'),
        _IconItem(icon: Icons.email, label: 'Mail'),
        _IconItem(icon: Icons.share, label: 'Partage'),
      ],
    );
  }
}

class _IconItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const _IconItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 32),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
