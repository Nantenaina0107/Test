class Declaration {
  final int id;
  final String nif;  // Modifié pour être un String
  final double chiffreAffaires;
  final double montantInvestissement;
  final int anneFiscal;
  final double montantImpot;
  final String status;
  final DateTime dateDec;  // Date de déclaration
  final DateTime dateLimite;  // Date limite

  Declaration({
    required this.id,
    required this.nif,  // Modifié pour être un String
    required this.chiffreAffaires,
    required this.montantInvestissement,
    required this.anneFiscal,
    required this.montantImpot,
    required this.status,
    required this.dateDec,
    required this.dateLimite,
  });

  factory Declaration.fromJson(Map<String, dynamic> json) {
    return Declaration(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      nif: json['nif'].toString(),  // Convertir toujours en String
      chiffreAffaires: json['chiffreAffaires'] is double
          ? json['chiffreAffaires']
          : double.parse(json['chiffreAffaires'].toString()),
      montantInvestissement: json['montantInvestissement'] is double
          ? json['montantInvestissement']
          : double.parse(json['montantInvestissement'].toString()),
      anneFiscal: json['anneFiscal'] is int
          ? json['anneFiscal']
          : int.parse(json['anneFiscal'].toString()),
      montantImpot: json['montantImpot'] is double
          ? json['montantImpot']
          : double.parse(json['montantImpot'].toString()),
      status: json['status'],
      dateDec: DateTime.parse(json['dateDeclaration']),
      dateLimite: DateTime.parse(json['dateLimite']),
    );
  }
}
