import 'package:flutter/material.dart';
import '../controllers/redacteur_controller.dart';
import '../models/redacteur.dart';

class RedacteurAddPage extends StatefulWidget {
  const RedacteurAddPage({super.key});

  @override
  State<RedacteurAddPage> createState() => _RedacteurAddPageState();
}

class _RedacteurAddPageState extends State<RedacteurAddPage> {
  final _formKey = GlobalKey<FormState>();
  final _nom = TextEditingController();
  final _specialite = TextEditingController();
  final _controller = RedacteurController();
  bool _sending = false;

  @override
  void dispose() {
    _nom.dispose();
    _specialite.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _sending = true);
    try {
      await _controller.create(Redacteur(nom: _nom.text.trim(), specialite: _specialite.text.trim()));
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (c) => AlertDialog(
          title: const Text('Succès'),
          content: const Text('Le rédacteur a été ajouté.'),
          actions: [TextButton(onPressed: () => Navigator.of(c).pop(), child: const Text('OK'))],
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur : $e')));
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter un Rédacteur')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nom,
              decoration: const InputDecoration(labelText: 'Nom', border: OutlineInputBorder()),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Le nom est requis' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _specialite,
              decoration: const InputDecoration(labelText: 'Spécialité', border: OutlineInputBorder()),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'La spécialité est requise' : null,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _sending ? null : _submit,
              child: Text(_sending ? 'Ajout...' : 'Ajouter'),
            ),
          ],
        ),
      ),
    );
  }
}
