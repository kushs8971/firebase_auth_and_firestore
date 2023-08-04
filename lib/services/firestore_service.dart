import 'package:adhicine/constants/utils.dart';
import 'package:adhicine/models/medicine_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirestoreService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addMedicine(String name, String color, String type, String image) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final userId = sharedPreferences.getString('userId');
    if(userId==null){
      return;
    }
    final userRef = _firestore.collection('users').doc(userId);
    await userRef.collection('medicines').add({
      'name': name,
      'color': color,
      'type': type,
      'image': image,
    });
  }

  Future<List<MedicineModel>> getAllMedicines() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final userId = sharedPreferences.getString('userId');
    if(userId==null){
      return [];
    }
    List<MedicineModel> medicines = [];
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('medicines')
          .get();

      for (QueryDocumentSnapshot document in snapshot.docs) {
        final medicine = MedicineModel.fromJson(document.data() as Map<String, dynamic>);
        medicines.add(medicine);
      }
    } catch (error) {
      print('Error fetching medicines: $error');
    }

    return medicines;
  }

}