part of 'services.dart';

class PlanService{
  CollectionReference planReference = FirebaseFirestore.instance
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection('plans');

  Future<void> createPlan({
    required Map<String, int> recipes,
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

  Stream<List<PlanModel>> fetchPlan(){
    try {
      final snapshot = planReference.snapshots().map((planList){
        return planList.docs.map((plan){
          return PlanModel.fromJson(
            plan.id,
            plan.data() as Map<String, dynamic>
          ); 
        }).toList(); 
      });
      return snapshot;
    } catch (e) {
      throw e;
    }
  }

  Future<void> deletePlan(String planID) async {
    try {
      planReference.doc(planID).delete();
    } catch (e) {
      throw e;
    }
  }

  Future<void> updatePlan({
    required String id,
    required Map<String, int> recipes,
    required DateTime dateTime
  }) async {
    try {
      planReference.doc().update({
        "id": id,
        "recipes": recipes,
        "dateTime": dateTime.toString()
      });
    } catch (e) {
      throw e;
    }
  }
}