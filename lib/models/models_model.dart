class ModelsModel {
  final String id;
  final String created;
  final String root;

  ModelsModel({
    required this.id,
    required this.root,
    required this.created,
});
  factory ModelsModel.fromJson(Map<String, dynamic> json) => ModelsModel (
    id: json['id'],
    root: json['root'],
    created: json['created'],
  );
  static List<ModelsModel> modelsFromSnapshot(List modelSnapshot){
    return modelSnapshot.map((data) => ModelsModel.fromJson(data)).toList();
  }
}

// class ModelsModel {
//   final int userId;
//   final int id;
//   final String title;
//
//   const ModelsModel({
//     required this.userId,
//     required this.id,
//     required this.title,
//   });
//
//   factory ModelsModel.fromJson(Map<String, dynamic> json) {
//     return ModelsModel(
//       userId: json['userId'],
//       id: json['id'],
//       title: json['title'],
//     );
//   }
// }