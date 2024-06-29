import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/appointments.dart';
import '../models/Doctor.dart';
import '../../models/BaseModel.dart';

class FirestoreService<T extends BaseModel> {
  final CollectionReference _collection;

  FirestoreService(String path)
      : _collection = FirebaseFirestore.instance.collection(path);

  Future<void> addItem(T item) async {
    try {
      DocumentReference docRef = _collection.doc();
      item.id = docRef.id;
      await docRef.set(item.toMap());
      debugPrint('Item added with ID: ${item.id}');
    } catch (e) {
      debugPrint('Error adding item: $e');
    }
  }

  Future<void> addItemWithId(T item, String id) async {
    try {
      item.id = id;
      await _collection.doc(id).set(item.toMap());
      debugPrint('Item added with specified ID: $id');
    } catch (e) {
      debugPrint('Error adding item with specified ID: $e');
    }
  }

  Stream<List<T>> getItemsStream(T model) {
    try {
      return _collection.snapshots().map((QuerySnapshot snapshot) {
        return snapshot.docs.map((DocumentSnapshot doc) {
          return model.fromMap(doc.data() as Map<String, dynamic>, doc.id) as T;
        }).toList();
      });
    } catch (e) {
      debugPrint('Error getting items stream: $e');
      rethrow;
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      await _collection.doc(id).delete();
      debugPrint('Item deleted with ID: $id');
    } catch (e) {
      debugPrint('Error deleting item: $e');
    }
  }

  Future<void> updateItem(String id, T item) async {
    try {
      await _collection.doc(id).update(item.toMap());
      debugPrint('Item updated with ID: $id');
    } catch (e) {
      debugPrint('Error updating item: $e');
    }
  }
}

class AppointmentService extends FirestoreService<Appointment> {
  AppointmentService() : super('appointments');
}

class DoctorService extends FirestoreService<Doctor> {
  DoctorService() : super('doctors');
}
