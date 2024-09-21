
class Address {
  String? id;
  String? estado;
  String? cidade;
  String? rua;
  String? bairro;
  bool isSelected;

  Address({
    this.id,
    this.estado,
    this.cidade,
    this.rua,
    this.bairro,
    this.isSelected = false
  });
}