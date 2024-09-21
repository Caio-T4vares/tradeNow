import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/model/address.dart';

class AddressController extends GetxController {
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController neighborhoodController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var addresses = <Address>[].obs;
  var selectedAddress = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadAddresses();
  }

  Future<void> addAddress({required String city, 
  required String street, required String neighborhood, required String state}) async {
    try {
      String? uid = _auth.currentUser?.uid;
      if (uid == null) return;

      await _firestore.collection('users').doc(uid).collection('addresses').add({
        'estado': state,
        'cidade': city,
        'rua': street,
        'bairro': neighborhood,
        'isSelected': false
      });

      loadAddresses();
    } catch (e) {
      print('Erro ao adicionar endereço: $e');
    }
  }

  Future<void> loadAddresses() async {
    try {
      String? uid = _auth.currentUser?.uid;
      if (uid == null) return;

      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('addresses')
          .get();

      addresses.value = snapshot.docs
          .map((doc) => Address(
                id: doc.id,
                cidade: doc['cidade'],
                rua: doc['rua'],
                bairro: doc['bairro'],
                estado: doc['estado'],
                isSelected: doc['isSelected']
              ))
          .toList();
      
      for (var address in addresses) {
        if(address.isSelected) {
          selectedAddress.value = address.id!;
        }
      }
    } catch (e) {
      print('Erro ao carregar endereços: $e');
    }
  }

  Future<void> setDefaultAddress(String addressId) async {
    try {
      String? uid = _auth.currentUser?.uid;
      if (uid == null) return;

      await _firestore.collection('users').doc(uid).update({
        'defaultAddressId': addressId,
      });

      if(selectedAddress.value != '') {
        await _firestore.collection('users').doc(uid).collection('addresses').doc(selectedAddress.value)
          .update({
            'isSelected': false,
          });

          await _firestore.collection('users').doc(uid).collection('addresses').doc(addressId)
          .update({
            'isSelected': true,
          });
      }

      selectedAddress.value = addressId;
    } catch (e) {
      print('Erro ao definir endereço padrão: $e');
    }
  }

  Future<Address?> getDefaultAddress() async {
    try {
      String? uid = _auth.currentUser?.uid;
      if (uid == null) return null;

      DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();
      String? defaultAddressId = userDoc['defaultAddressId'];

      if (defaultAddressId != null) {
        DocumentSnapshot addressDoc = await _firestore
            .collection('users')
            .doc(uid)
            .collection('addresses')
            .doc(defaultAddressId)
            .get();

        if (addressDoc.exists) {
          return Address(
            id: addressDoc.id,
            cidade: addressDoc['cidade'],
            rua: addressDoc['rua'],
            bairro: addressDoc['bairro'],
            estado: addressDoc['estado']
          );
        }
      }
    } catch (e) {
      print('Erro ao obter endereço padrão: $e');
    }
    return null;
  }
}