class UserModel {
  final String id;
  String name;
  final String username;
  final String email;
  final List<String>? followers;
  final List<String>? following;
  String fcmToken;
  String? imageURL;
  bool hasNewNotifications;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    this.followers = const [],
    this.following = const [],
    required this.fcmToken,
    this.imageURL,
    this.hasNewNotifications = false,
  });

  static List<UserModel> mocks = [
    UserModel(id: '1', name: "", username: '', email: '', fcmToken: ''),
    UserModel(
        id: '2', name: "Ali Khan", username: "ali13", email: '', fcmToken: ''),
    UserModel(
        id: '3',
        name: "Zain ul Abidien",
        username: "zaini123",
        email: '',
        fcmToken: ''),
  ];

  factory UserModel.fromFirestore(String id, Map<String, dynamic> data) {
    return UserModel(
        id: id,
        name: data['name'] ?? '',
        username: data['username'],
        email: data['email'] ?? '',
        followers: (data['followers'] as List<dynamic>?)?.cast<String>() ?? [],
        following: (data['following'] as List<dynamic>?)?.cast<String>() ?? [],
        fcmToken: data['fcmToken'] ?? '',
        imageURL: data['imageURL'] ?? '',
        hasNewNotifications: data['hasNewNotifications'] ?? false);
  }

  // Method to convert User object to Firestore data
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'followers': followers,
      'following': following,
      'fcmToken': fcmToken,
      'imageURL': imageURL,
      'hasNewNotifications': hasNewNotifications
    };
  }
}
