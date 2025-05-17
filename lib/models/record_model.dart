class RecordModel {
  final int id;
  final String vehicle;
  final String plate;
  final String description;
  final String imageUrl;
  final String faculty;

  RecordModel({
    required this.id,
    required this.vehicle,
    required this.plate,
    required this.description,
    required this.imageUrl,
    required this.faculty,
  });

  factory RecordModel.fromJson(Map<String, dynamic> json) {
    return RecordModel(
      id: json['id'],
      vehicle: json['namaMotor'],
      plate: json['platMotor'],
      description: json['deskripsi'],
      imageUrl: 'https://localhost:7211/uploads/${json['gambarPath']}',
      faculty: json['spot'],
    );
  }
}
