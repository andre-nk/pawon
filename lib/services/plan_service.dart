part of 'services.dart';

class PlanService{
  CollectionReference planReference = FirebaseFirestore.instance
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection('plans');

  Future<void> createPlan({
    required List<String> recipes,
    required DateTime dateTime
  }) async {
    try {
      planReference.doc().set({
        "recipes": recipes,
        "dateTime": dateTime.toString()
      });
    } catch (e) {
      throw e;
    }
  }

  Future<void> updatePlan({
    required List<String> recipes,
    required DateTime dateTime
  }) async {
    try {
      planReference.doc().update({
        "recipes": recipes,
        "dateTime": dateTime.toString()
      });
    } catch (e) {
      throw e;
    }
  }
}