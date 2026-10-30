class Produit {
  final int? id;
  final String nom;
  final double prix;
  final int quantite;
  final bool disponible;
  final DateTime dateAjout;
  final int categorieId;

  const Produit({
    this.id,
    required this.nom,
    required this.prix,
    this.quantite = 0,
    this.disponible = true,
    required this.dateAjout,
    required this.categorieId,
  });

  factory Produit.fromMap(Map<String, dynamic> map) {
    return Produit(
      id: map['id'] as int?,
      nom: map['nom'] as String,
      // Gestion robuste du prix (évite l'erreur si SQLite renvoie un int)[cite: 1]
      prix: (map['prix'] as num).toDouble(),
      quantite: map['quantite'] as int,
      // Conversion INTEGER (1/0) vers bool[cite: 1]
      disponible: (map['disponible'] as int) == 1,
      // Conversion TEXT vers DateTime[cite: 1]
      dateAjout: DateTime.parse(map['date_ajout'] as String),
      // Conversion snake_case (SQL) vers camelCase (Dart)[cite: 1]
      categorieId: map['categorie_id'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'nom': nom,
      'prix': prix,
      'quantite': quantite,
      'disponible': disponible ? 1 : 0,
      'date_ajout': dateAjout.toIso8601String(),
      'categorie_id': categorieId,
    };
  }

  @override
  String toString() {
    return 'Produit(id: $id, nom: $nom, prix: $prix, quantite: $quantite, disponible: $disponible)';
  }
}