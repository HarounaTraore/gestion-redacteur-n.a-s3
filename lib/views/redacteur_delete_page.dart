import 'package:flutter/material.dart';
import '../controllers/redacteur_controller.dart';
import '../models/redacteur.dart';

class RedacteurDeletePage extends StatefulWidget {
  final Redacteur redacteur;
  const RedacteurDeletePage({super.key, required this.redacteur});

  @override
  State<RedacteurDeletePage> createState() => _RedacteurDeletePageState();
}

class _RedacteurDeletePageState extends State<RedacteurDeletePage> {
  final _controller = RedacteurController();
  bool _deleting = false;

  Future<void> _delete() async {
    setState(() => _deleting = true);
    try {
      await _controller.delete(widget.redacteur.id!);
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (c) => AlertDialog(
          title: const Text('Supprimé'),
          content: const Text('Le rédacteur a été supprimé.'),
          actions: [TextButton(onPressed: () => Navigator.of(c).pop(), child: const Text('OK'))],
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur : ' + e.toString())));
    } finally {
      if (mounted) setState(() => _deleting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirmer la suppression')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Voulez-vous vraiment supprimer \"${widget.redacteur.nom}\" ?'),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _deleting ? null : _delete,
              icon: const Icon(Icons.delete_outline),
              label: Text(_deleting ? 'Suppression...' : 'Supprimer'),
            ),
          ],
        ),
      ),
    );
  }
}
