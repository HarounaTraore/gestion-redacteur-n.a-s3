import 'package:flutter/material.dart';
import '../controllers/redacteur_controller.dart';
import '../models/redacteur.dart';

class RedacteurEditPage extends StatefulWidget {
  final Redacteur redacteur;
  const RedacteurEditPage({super.key, required this.redacteur});

  @override
  State<RedacteurEditPage> createState() => _RedacteurEditPageState();
}

class _RedacteurEditPageState extends State<RedacteurEditPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nom;
  late final TextEditingController _specialite;
  final _controller = RedacteurController();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _nom = TextEditingController(text: widget.redacteur.nom);
    _specialite = TextEditingController(text: widget.redacteur.specialite);
  }

  @override
  void dispose() {
    _nom.dispose();
    _specialite.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final updated = widget.redacteur.copyWith(nom: _nom.text.trim(), specialite: _specialite.text.trim());
      await _controller.update(updated);
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (c) => AlertDialog(
          title: const Text('Modifié'),
          content: const Text('Les informations ont été mises à jour.'),
          actions: [TextButton(onPressed: () => Navigator.of(c).pop(), child: const Text('OK'))],
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur : $e')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Modifier un Rédacteur')),
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
              onPressed: _saving ? null : _save,
              child: Text(_saving ? 'Enregistrement...' : 'Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}
