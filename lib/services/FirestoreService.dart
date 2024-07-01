import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sehatyaab/models/Doctor.dart';
import '../models/Appointments.dart';
import '../models/BaseModel.dart';

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

  Future<T> getItemById(String id, T model) async {
    try {
      DocumentSnapshot doc = await _collection.doc(id).get();
      if (doc.exists) {
        return model.fromMap(doc.data() as Map<String, dynamic>, doc.id) as T;
      } else {
        throw Exception('Document does not exist');
      }
    } catch (e) {
      debugPrint('Error getting item by ID: $e');
      throw e;
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

  Future<void> updateItem(String id, Map<String, dynamic> item) async {
    try {
      await _collection.doc(id).update(item);
      debugPrint('Item updated with ID: $id');
    } catch (e) {
      debugPrint('Error updating item: $e');
    }
  }

  Stream<List<Appointment>> getItemsByDoctorIdStream(String doctorId, T model) {
    try {
      return _collection
          .where('doctorId', isEqualTo: doctorId)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return model.fromMap(doc.data() as Map<String, dynamic>, doc.id)
              as Appointment;
        }).toList();
      });
    } catch (e) {
      debugPrint('Error getting items by doctor ID stream: $e');
      rethrow;
    }
  }

  Stream<List<Appointment>> getItemsByPatientIdStream(
      String patientId, T model) {
    try {
      return _collection
          .where('patientId', isEqualTo: patientId)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return model.fromMap(doc.data() as Map<String, dynamic>, doc.id)
              as Appointment;
        }).toList();
      });
    } catch (e) {
      debugPrint('Error getting items by patient ID stream: $e');
      rethrow;
    }
  }

  Future<List> getItemsByQuery(
      {required String field,
      required String value,
      required collection,
      required Doctor Function(dynamic data) fromMap}) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection(collection)
        .where(field, isEqualTo: value)
        .get();
    return querySnapshot.docs.map((doc) {
      return (T as dynamic).fromMap(doc.data());
    }).toList();
  }

  Future<void> updateAvailableSlots(
      String doctorId, List<String> availableSlots) async {
    try {
      await _collection
          .doc(doctorId)
          .update({'availableSlots': availableSlots});
      debugPrint('Available slots updated for doctor with ID: $doctorId');
    } catch (e) {
      debugPrint('Error updating available slots: $e');
    }
  }

  Future<void> updateDoctor(Doctor doctor) async {
    try {
      await _collection.doc(doctor.id).update(doctor.toMap());
      debugPrint('Doctor updated with ID: ${doctor.id}');
    } catch (e) {
      debugPrint('Error updating doctor: $e');
    }
  }
}
