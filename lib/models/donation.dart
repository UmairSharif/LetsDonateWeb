import 'package:cloud_firestore/cloud_firestore.dart';

class Donation {
  String id;
  String title, description;
  String ownerID;
  List<String> tags;
  double amountRequired;
  double? amountCollected;
  DateTime lastDate;
  List<String> images = [];
  String? videoURL;
  String bankName;
  String accountName;
  String iban;
  DateTime createdAt;
  bool isArchived = false;

  Donation({
    required this.id,
    required this.title,
    required this.description,
    required this.ownerID,
    this.tags = const [],
    required this.amountRequired,
    required this.amountCollected,
    required this.lastDate,
    this.images = const [],
    this.videoURL,
    required this.bankName,
    required this.accountName,
    required this.iban,
    required this.createdAt,
  }) {
    // Check if lastDate has passed or amountRequired and amountCollected are equal
    isArchived =
        DateTime.now().add(const Duration(days: -1)).isAfter(lastDate) ||
            amountRequired == (amountCollected ?? 0);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'ownerID': ownerID,
      'tags': tags,
      'amountRequired': amountRequired,
      'amountCollected': amountCollected,
      'lastDate': lastDate,
      'images': images,
      'videoURL': videoURL,
      'bankName': bankName,
      'accountName': accountName,
      'iban': iban,
      'createdAt': createdAt
    };
  }

  factory Donation.fromFirestore(String id, Map<String, dynamic> data) {
    return Donation(
        id: id,
        title: data['title'] ?? '',
        description: data['description'],
        ownerID: data['ownerID'] ?? '',
        tags: (data['tags'] as List<dynamic>).cast<String>(),
        amountRequired: data['amountRequired'].toDouble() ?? 0.0,
        amountCollected: data['amountCollected'].toDouble() ?? 0.0,
        lastDate: (data['lastDate'] as Timestamp).toDate(),
        images: (data['images'] as List<dynamic>).cast<String>(),
        videoURL: data['videoURL'] ?? '',
        bankName: data['bankName'] ?? '',
        accountName: data['accountName'] ?? '',
        iban: data['iban'] ?? '',
        createdAt: (data['createdAt'] as Timestamp).toDate());
  }

  static List<Donation> mocks = [
    Donation(
      id: '1',
      title: 'Food supply for flood victims',
      description:
          "A charitable purpose is the reason a charity has been set up, and what its activities work towards achieving. Some people also refer to it as their charity's mission. All registered charities must have a charitable purpose. This purpose is usually set out in the charity's governing document.",
      ownerID: 'AMsb2bbgoaUfdyyTZ1ngkKfRkGm2',
      amountRequired: 1000.0,
      amountCollected: 500.0,
      lastDate: DateTime.now().add(const Duration(days: 30)),
      bankName: 'Example Bank',
      accountName: 'Donation Fund',
      iban: 'GBXX XXXX XXXX XXXX XXXX XX',
      createdAt: DateTime.now(),
    ),
    Donation(
      id: '2',
      title: 'Another Donation Cause',
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin consequat tellus vel mauris eleifend, a tempus libero varius.",
      ownerID: 'sIop7qiHkCfQXqH0pIbwoIGYdor2',
      amountRequired: 2000.0,
      amountCollected: 800.0,
      lastDate: DateTime.now().add(const Duration(days: 45)),
      bankName: 'Sample Bank',
      accountName: 'Community Fund',
      iban: 'USXX XXXX XXXX XXXX XXXX XX',
      createdAt: DateTime.now(),
    ),
    Donation(
      id: '3',
      title: 'Support Education Initiative',
      description:
          "Education is the most powerful weapon which you can use to change the world. - Nelson Mandela",
      ownerID: 'AMsb2bbgoaUfdyyTZ1ngkKfRkGm2',
      amountRequired: 5000.0,
      amountCollected: 2500.0,
      lastDate: DateTime.now().add(const Duration(days: 60)),
      bankName: 'Education Bank',
      accountName: 'Learning Foundation',
      iban: 'DEXX XXXX XXXX XXXX XXXX XX',
      createdAt: DateTime.now(),
    ),
  ];
}

extension FilterDonationsExtension on List<Donation> {
  List<Donation> filterByArchived({bool isArchived = false}) {
    return isArchived
        ? where((donation) => donation.isArchived).toList()
        : where((donation) => !donation.isArchived).toList();
  }
}
