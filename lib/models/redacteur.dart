import 'package:cloud_firestore/cloud_firestore.dart';

class Redacteur {
  final String? id;
  final String nom;
  final String specialite;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Redacteur({
    this.id,
    required this.nom,
    required this.specialite,
    this.createdAt,
    this.updatedAt,
  });

  factory Redacteur.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return Redacteur(
      id: doc.id,
      nom: (data['nom'] as String?) ?? '',
      specialite: (data['specialite'] as String?) ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toCreateMap() {
    return {
      'nom': nom,
      'specialite': specialite,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  Map<String, dynamic> toUpdateMap() {
    return {
      'nom': nom,
      'specialite': specialite,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  Redacteur copyWith({
    String? id,
    String? nom,
    String? specialite,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Redacteur(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      specialite: specialite ?? this.specialite,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
