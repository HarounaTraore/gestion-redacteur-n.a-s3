import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/redacteur.dart';

class RedacteurController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _col => _db.collection('redacteurs');

  Stream<List<Redacteur>> streamAll() {
    return _col.orderBy('nom').snapshots().map((snap) {
      return snap.docs.map((d) => Redacteur.fromDoc(d)).toList();
    });
  }

  Future<void> create(Redacteur r) async {
    await _col.add(r.toCreateMap());
  }

  Future<void> update(Redacteur r) async {
    if (r.id == null) throw ArgumentError('id requis pour update');
    await _col.doc(r.id).update(r.toUpdateMap());
  }

  Future<void> delete(String id) async {
    await _col.doc(id).delete();
  }
}
