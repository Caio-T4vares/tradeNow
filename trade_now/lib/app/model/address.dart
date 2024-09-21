import 'package:cloud_firestore/cloud_firestore.dart';

class Address {
  String? id;
  String? estado;
  String? cidade;
  String? rua;
  String? bairro;
  String? userId;
  bool isSelected;

  Address({
    this.id,
    this.estado,
    this.cidade,
    this.rua,
    this.bairro,
    this.userId,
    this.isSelected = false
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      estado: json['estado'],
      cidade: json['cidade'],
      rua: json['rua'],
      bairro: json['bairro'],
      userId: json['userId'],
      isSelected: json['isSelected'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'estado': estado,
      'cidade': cidade,
      'rua': rua,
      'bairro': bairro,
      'userId': userId,
      'isSelected': isSelected,
    };
  }

  factory Address.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Address(
      id: doc.id,
      cidade: data['cidade'] ?? '',
      rua: data['rua'] ?? '',
      bairro: data['bairro'] ?? '',
      estado: data['estado'] ?? '',
    );
  }
}