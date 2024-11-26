class CarteFiscale {
  final int? idP; // Laissez le type nullable
  final String nif;
  final String refP;
  final String status;
  final DateTime dateP;
  final DateTime createdAt;
  final String qrCode;

  CarteFiscale({
    this.idP, // idP est maintenant nullable
    required this.nif,
    required this.refP,
    required this.status,
    required this.dateP,
    required this.createdAt,
    required this.qrCode,
  });

  factory CarteFiscale.fromJson(Map<String, dynamic> json) {
    return CarteFiscale(
      idP: json['idP'] != null ? json['idP'] : null, // Gestion du cas où idP est nul
      nif: json['nif'],
      refP: json['refP'],
      status: json['status'],
      dateP: DateTime.parse(json['dateP']),
      createdAt: DateTime.parse(json['createdAt']),
      qrCode: json['qrCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idP': idP, // Pas de problème si idP est nul
      'nif': nif,
      'refP': refP,
      'status': status,
      'dateP': dateP.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'qrCode': qrCode,
    };
  }
}
