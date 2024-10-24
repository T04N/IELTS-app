import 'package:ielts_tev/model/input.dart';
import 'package:firebase_database/firebase_database.dart';

class InputRepository {
  final DatabaseReference _databaseRef =
      FirebaseDatabase.instance.ref().child('input');

  Future<void> addInput(Input input) async {
    try {
      await _databaseRef.child(input.email).set(input.toMap());
    } catch (e) {
      throw Exception('Error adding input: $e');
    }
  }

  Stream<List<Input>> getInputs() {
    return _databaseRef.onValue.map((event) {
      final List<Input> inputs = [];
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        data.forEach((key, value) {
          final input = Input.fromMap(value, key);
          inputs.add(input);
        });
      }

      return inputs;
    });
  }

  Future<void> updateInput(String email, Input input) async {
    try {
      await _databaseRef.child(email).update(input.toMap());
    } catch (e) {
      throw Exception('Error updating input: $e');
    }
  }

  Future<void> deleteInput(String email) async {
    try {
      await _databaseRef.child(email).remove();
    } catch (e) {
      throw Exception('Error deleting input: $e');
    }
  }

  Future<Input?> getInputByEmail(String email) async {
    try {
      final snapshot = await _databaseRef.child(email).get();
      if (snapshot.exists) {
        return Input.fromMap(
            snapshot.value as Map<String, dynamic>, snapshot.key);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error fetching input: $e');
    }
  }
}
