import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
   Future<bool> checkWordExists(String word) async {
    final querySnapshot = await _db
        .collection('words')
        .where('word', isEqualTo: word)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }
  Future<void> createStudent(String name, String id, double gpa) async {
    DocumentReference studentRef = _db.collection('students').doc(id);

    Map<String, dynamic> studentData = {
      "studentName": name,
      "studentID": id,
      "studentCGPA": gpa
    };

    DocumentSnapshot docSnapshot = await studentRef.get();
    if (docSnapshot.exists) {
      throw Exception('Student ID already exists');
    } else {
      await studentRef.set(studentData);
    }
  }

  Future<Map<String, dynamic>?> readStudent(String id) async {
    DocumentReference studentRef = _db.collection('students').doc(id);

    DocumentSnapshot snapshot = await studentRef.get();
    return snapshot.data() as Map<String, dynamic>?;
  }

  Future<void> updateStudent(String name, String id, double gpa) async {
    DocumentReference studentRef = _db.collection('students').doc(id);

    Map<String, dynamic> studentData = {
      "studentName": name,
      "studentID": id,
      "studentCGPA": gpa
    };

    await studentRef.update(studentData);
  }

  Future<void> deleteStudent(String id) async {
    DocumentReference studentRef = _db.collection('students').doc(id);
    await studentRef.delete();
  }

  Stream<QuerySnapshot> getStudentsStream() {
    return _db.collection('students').snapshots();
  }
}
