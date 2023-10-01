import 'package:cloud_firestore/cloud_firestore.dart';

class SkillServices {
  Future<List> getSkills() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('skills')
          .orderBy('time')
          .get();

      return snapshot.docs;
    } catch (e) {
      throw Exception('Falied to load data $e');
    }
  }
}
