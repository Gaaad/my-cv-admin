import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectsServices {
  Future<List> getProjects() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('projects')
          .orderBy('time')
          .get();

      return snapshot.docs;
    } catch (e) {
      throw Exception('Falied to load data $e');
    }
  }
}
