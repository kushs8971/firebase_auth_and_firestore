class MedicineModel{
  final String color;
  final String type;
  final String image;
  final String name;

  MedicineModel({required this.type,required this.name,required this.color, required this.image});

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      name: json['name'],
      color: json['color'],
      type: json['type'],
      image: json['image'],
    );
  }
}