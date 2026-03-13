class BillModel {
  String? id;
  String institutionName; // Kurum Adı
  double amount; // Tutar
  DateTime date; // Tarih
  String billType; // Tür (Elektrik, Su vb.)

  BillModel({
    this.id,
    required this.institutionName,
    required this.amount,
    required this.date,
    required this.billType,
  });

  // Model → Firebase
  Map<String, dynamic> toMap() {
    return {
      'institutionName': institutionName,
      'amount': amount,
      'date': date.toIso8601String(),
      'billType': billType,
    };
  }

  // Firebase → Model
  factory BillModel.fromMap(Map<String, dynamic> map, String documentId) {
    return BillModel(
      id: documentId,
      institutionName: map['institutionName'] ?? '',
      amount: (map['amount'] ?? 0).toDouble(),
      date: DateTime.parse(map['date']),
      billType: map['billType'] ?? '',
    );
  }
}
