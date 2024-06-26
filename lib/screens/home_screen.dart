import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/student_model.dart';
import 'package:myapp/services/firestore_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _gpaController = TextEditingController();

  final FirestoreService _firestoreService = FirestoreService();

  void _createStudent() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String id = _idController.text;
      double gpa = double.tryParse(_gpaController.text) ?? 0.0;

      _firestoreService.createStudent(name, id, gpa).then((_) {
        Fluttertoast.showToast(msg: '$name created');
      }).catchError((error) {
        Fluttertoast.showToast(msg: error.toString());
      });
    }
  }

  void _readStudent() {
    String id = _idController.text;

    _firestoreService.readStudent(id).then((data) {
      if (data != null) {
        Fluttertoast.showToast(
          msg: 'Name: ${data['studentName']}, ID: ${data['studentID']}, CGPA: ${data['studentCGPA']}',
        );
      } else {
        Fluttertoast.showToast(msg: 'No data found for ID: $id');
      }
    });
  }

  void _updateStudent() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String id = _idController.text;
      double gpa = double.tryParse(_gpaController.text) ?? 0.0;

      _firestoreService.updateStudent(name, id, gpa).then((_) {
        Fluttertoast.showToast(msg: '$name updated');
      });
    }
  }

  void _deleteStudent() {
    if (_formKey.currentState!.validate()) {
      String id = _idController.text;

      _firestoreService.deleteStudent(id).then((_) {
        Fluttertoast.showToast(msg: 'Student with ID: $id deleted');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        centerTitle: true,
        title: const Text(
          'C R U D',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green.shade400),
                    ),
                    prefixIcon: Icon(Icons.person, color: Colors.green.shade400),
                    border: const UnderlineInputBorder(),
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.green.shade400),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _idController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Student ID';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green.shade400),
                    ),
                    prefixIcon: Icon(Icons.school, color: Colors.green.shade400),
                    border: const UnderlineInputBorder(),
                    labelText: 'Student ID',
                    labelStyle: TextStyle(color: Colors.green.shade400),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _gpaController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter CGPA';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green.shade400),
                    ),
                    prefixIcon: Icon(Icons.newspaper, color: Colors.green.shade400),
                    border: const UnderlineInputBorder(),
                    labelText: 'CGPA',
                    labelStyle: TextStyle(color: Colors.green.shade400),
                  ),
                ),
                const SizedBox(height: 30),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: _createStudent,
                        child: const Text('CREATE'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: _readStudent,
                        child: const Text('READ'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        onPressed: _updateStudent,
                        child: const Text('UPDATE'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: _deleteStudent,
                        child: const Text('DELETE'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 50),
                const Text(
                  'Student Records',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                StreamBuilder<QuerySnapshot>(
                  stream: _firestoreService.getStudentsStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
        
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No students created yet'));
                    }
        
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot studentDoc = snapshot.data!.docs[index];
                        Student student = Student.fromMap(
                            studentDoc.data() as Map<String, dynamic>);
                        return Row(
                          children: [
                            Expanded(
                              child: Text(
                                student.name,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                student.id,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                student.gpa.toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
