class UserModel {
  final String
  uid; // Firebase'den gelen benzersiz kimlik, her kullanıcı sadece kendi verisine ulaşacak
  final String name; // Kullanıcının adı
  final String email; // Kullanıcının e-postası
  final String profilePic; // Profil resmi linki (şimdilik boş kalabilir)
  final DateTime createdAt; // Hesabın oluşturulma tarihi

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.profilePic,
    required this.createdAt,
  });

  // 1. Nesneden Map'e (Firestore'a veri gönderirken)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profilePic': profilePic,
      'createdAt': createdAt
          .toIso8601String(), //Tarihi metin formatına çevirir, Firestore'da DateTime olarak saklanır ancak Map'e çevrilirken string yapılır.
    };
  }

  // 2. Map'ten Nesneye (Firestore'dan veri çekerken)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      profilePic: map['profilePic'] ?? '',
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
    );
  }
}
