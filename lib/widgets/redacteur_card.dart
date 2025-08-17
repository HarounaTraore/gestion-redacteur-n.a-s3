import 'package:flutter/material.dart';
import '../models/redacteur.dart';

class RedacteurCard extends StatelessWidget {
  final Redacteur redacteur;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const RedacteurCard({
    super.key,
    required this.redacteur,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(redacteur.nom, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Spécialité : ${redacteur.specialite}'),
        trailing: Wrap(
          spacing: 8,
          children: [
            IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
            IconButton(icon: const Icon(Icons.delete_outline), onPressed: onDelete),
          ],
        ),
      ),
    );
  }
}
