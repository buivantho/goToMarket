class Employee {
  int id;
  String name;
  String sex;

  Employee(this.id, this.name, this.sex);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'sex': sex,
    };
    return map;
  }

  Employee.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    sex = map['sex'];
  }
}
