import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lets_donate_web/models/donation.dart';
import 'package:lets_donate_web/services/firestore_service.dart';

class DonationService extends DatabaseService<Donation> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DonationService()
      : super(
            collection: FirestoreCollection.donations.name,
            fromDS: (id, data) => Donation.fromFirestore(id, data),
            toMap: (donation) => donation.toMap());

  Future<void> deleteAllDonationForOwnerId(String ownerID) async {
    try {
      var querySnapshot = await _db
          .collection(FirestoreCollection.donations.name)
          .where('ownerID', isEqualTo: ownerID)
          .get();

      for (var donation in querySnapshot.docs) {
        await removeItem(donation.id);
      }
    } catch (error) {
      rethrow;
    }
  }
}
