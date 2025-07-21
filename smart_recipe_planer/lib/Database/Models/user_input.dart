class UserInput {
  final String id;
  final String? imageUrl;
  final String description;
  final DateTime createdDate;
  final String status; // pending, processing, completed

  UserInput({
    required this.id,
    this.imageUrl,
    required this.description,
    required this.createdDate,
    required this.status,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'description': description,
      'createdDate': createdDate.toIso8601String(),
      'status': status,
    };
  }

  factory UserInput.fromFirestore(
    Map<String, dynamic> data,
    String docId,
  ) {
    return UserInput(
      id: docId,
      imageUrl: data['imageUrl'],
      description: data['description'] ?? '',
      createdDate: DateTime.parse(data['createdDate']),
      status: data['status'] ?? 'pending',
    );
  }
}
