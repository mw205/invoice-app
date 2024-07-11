class UnitModel {
  final int id;
  final String? name;

  UnitModel({required this.id, this.name});
  factory UnitModel.fromJson(jsonData) {
    return UnitModel(id: jsonData["id"], name: jsonData["name"]);
  }
}
