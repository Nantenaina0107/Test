// models/user.dart
class User {
  String email;
  String nom;
  String prenom;
  int cin;
  String sexe;
  String situation;
  String password;
  String tel;
  String datenaiss;
  String lieunaiss;
  List<Activite> activites;
  List<Siege> sieges;

  User({
    required this.email,
    required this.nom,
    required this.prenom,
    required this.cin,
    required this.sexe,
    required this.situation,
    required this.password,
    required this.tel,
    required this.datenaiss,
    required this.lieunaiss,
    required this.activites,
    required this.sieges,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "nom": nom,
        "prenom": prenom,
        "cin": cin,
        "sexe": sexe,
        "situation": situation,
        "password": password,
        "tel": tel,
        "datenaiss": datenaiss,
        "lieunaiss": lieunaiss,
        "activites": activites.map((a) => a.toJson()).toList(),
        "sieges": sieges.map((s) => s.toJson()).toList(),
      };
}

class Activite {
  String secteur;
  String description;
  bool isInvestisseur;
  String secteurInv;

  Activite({
    required this.secteur,
    required this.description,
    required this.isInvestisseur,
    required this.secteurInv,
  });

  Map<String, dynamic> toJson() => {
        "secteur": secteur,
        "description": description,
        "isInvestisseur": isInvestisseur,
        "secteurInv": secteurInv,
      };
}

class Siege {
  String adresse;
  String fokontany;
  String commune;
  String region;

  Siege({
    required this.adresse,
    required this.fokontany,
    required this.commune,
    required this.region,
  });

  Map<String, dynamic> toJson() => {
        "adresse": adresse,
        "fokontany": fokontany,
        "commune": commune,
        "region": region,
      };
}
