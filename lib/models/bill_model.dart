class BillModel {
  String? id; // Firestore doküman ID'si
  String institutionName; // Kurum adı (İSKİ, Türk Telekom vb.)
  double amount; // Fatura Tutarı
  DateTime date; // Fatura Tarihi
  String category; // Kategori (Su, Elektrik, İnternet)
  String description; // Not/Açıklama

  BillModel({
    this.id,
    required this.institutionName,
    required this.amount,
    required this.date,
    required this.category,
    required this.description,
  });

  // 1. Map'ten Nesneye (Firestore'dan veri çekerken kullanılır)
  factory BillModel.fromMap(Map<String, dynamic> map, String documentId) {
    return BillModel(
      id: documentId,
      institutionName: map['institutionName'] ?? '',
      amount: (map['amount'] ?? 0).toDouble(),
      date: map['date'] != null ? DateTime.parse(map['date']) : DateTime.now(),
      category: map['category'] ?? 'Genel',
      description: map['description'] ?? '',
    );
  }

  // 2. Nesneden Map'e (Firestore'a veri gönderirken kullanılır)
  Map<String, dynamic> toMap() {
    return {
      'institutionName': institutionName,
      'amount': amount,
      'date': date.toIso8601String(), // Tarihi metin formatına çevirir
      'category': category,
      'description': description,
    };
  }
}
