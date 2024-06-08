import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/base_model.dart';

class FirestoreService<T extends BaseModel> {
  final CollectionReference _collection;

  FirestoreService(String path)
      : _collection = FirebaseFirestore.instance.collection(path);

  Future<void> addItem(T item) async {
    try {
      await _collection.add(item.toMap());
      print('Item added: ${item.toMap()}');
    } catch (e) {
      print('Error adding item: $e');
    }
  }

  Stream<List<T>> getItemsStream(T model) {
    return _collection.snapshots().map((QuerySnapshot snapshot) {
      return snapshot.docs.map((DocumentSnapshot doc) {
        return model.fromMap(doc.data() as Map<String, dynamic>, doc.id) as T;
      }).toList();
    });
  }

  Future<void> deleteItem(String id) async {
    try {
      await _collection.doc(id).delete();
      print('Item deleted with ID: $id');
    } catch (e) {
      print('Error deleting item: $e');
    }
  }

  Future<void> updateItem(String id, T item) async {
    try {
      await _collection.doc(id).update(item.toMap());
      print('Item updated with ID: $id');
    } catch (e) {
      print('Error updating item: $e');
    }
  }
}
