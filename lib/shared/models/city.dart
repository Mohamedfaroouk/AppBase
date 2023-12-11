class Cites {
  int? id;
  String? name;

  Cites({
    this.id,
    this.name,
  });

  Cites.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
