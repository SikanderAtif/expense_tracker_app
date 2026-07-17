import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_app/models/expense.dart';

class FireStoreService {
  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUserProfile(String userId, List<Expense> expenses, List<dynamic> budget, String name) {
    return users.doc(userId).set({
      'name': name,
      'expenses': expenses,
      'budget': budget,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<DocumentSnapshot> getUserData(String userId) async {
    return await users.doc(userId).get();
  }

  Future<void> updateData(String userId, List<Expense> expenses, List<Map<String, dynamic>> budgetMap) {
    return users.doc(userId).update({
      'expenses': expenses.map((e) => e.toMap()).toList(),
      'budget': budgetMap,
    });
  }

  Future<void> deleteUser(String userId) {
    return users.doc(userId).delete();
  }
}