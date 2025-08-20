import 'package:case_fire/core/debugger/app_debug.dart';
import 'package:case_fire/modules/author/data/models/author_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthorFirestoreDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<AuthorModel?> getAuthorInfo(String userId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('users').doc(userId).get();
      final data = snapshot.data();
      return data != null ? AuthorModel.fromJson(data) : null;
    } catch (e) {
      AppDebug(message: 'Erro ao buscar dados do autor no Firestore: $e');
      return null;
    }
  }
}
