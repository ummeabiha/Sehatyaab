abstract class BaseModel {
  String id;

  BaseModel({required this.id});

  Map<String, dynamic> toMap();
  BaseModel fromMap(Map<String, dynamic> map, String id);
}
