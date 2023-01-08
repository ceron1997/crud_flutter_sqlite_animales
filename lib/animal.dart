// ignore_for_file: non_constant_identifier_names

class Animal {
  final String name;
  final String especie;
  final int? id;

  Animal({
    required this.id,
    required this.name,
    required this.especie,
  });

  // convert to Map
  Map<String, dynamic> toMap() => {
        "name": name,
        "especie": especie,
        "id": id,
      };
  // convert Map to Employee
  factory Animal.toEmp(Map<String, dynamic> map) =>
      Animal(id: map["id"], name: map["name"], especie: map["especie"]);
}
