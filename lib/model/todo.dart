import 'package:HouseCleaning/repository/database_creator.dart';

class Todo {
  int id;
  String name;
   bool isDeleted;

  Todo(
    this.id,
    this.name,
     this.isDeleted,
  );

  Todo.fromJson(Map<String, dynamic> json) {
    this.id = json[DatabaseCreator.id];
    this.name = json[DatabaseCreator.name];
    this.isDeleted = json[DatabaseCreator.isDeleted] == 1;
  }
}
