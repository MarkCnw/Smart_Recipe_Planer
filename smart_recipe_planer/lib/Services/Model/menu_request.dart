// Model ปรับปรุงเล็กน้อยเพื่อความสมบูรณ์
import 'package:cloud_firestore/cloud_firestore.dart';

class MenuRequest {
  final String id;
  final String? imageUrl;
  final String description;
  final DateTime createdAt;
  final AIResponse? aiResponse;
  final RequestStatus status; // เพิ่ม status tracking
  final int? processingTimeMs; // เวลาที่ AI ใช้ประมวลผล

  MenuRequest({
    required this.id,
    required this.imageUrl,
    required this.description,
    required this.createdAt,
    this.aiResponse,
    this.status = RequestStatus.pending,
    this.processingTimeMs,
  });

  factory MenuRequest.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MenuRequest(
      id: doc.id,
      imageUrl: data['imageUrl'],
      description: data['description'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      aiResponse: data['aiResponse'] != null
          ? AIResponse.fromMap(data['aiResponse'])
          : null,
      status: RequestStatus.values.firstWhere(
        (e) => e.toString().split('.').last == data['status'],
        orElse: () => RequestStatus.pending,
      ),
      processingTimeMs: data['processingTimeMs'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'description': description,
      'createdAt': Timestamp.fromDate(createdAt),
      'aiResponse': aiResponse?.toMap(),
      'status': status.toString().split('.').last,
      if (processingTimeMs != null) 'processingTimeMs': processingTimeMs,
    };
  }

  // Helper method สำหรับอัพเดท AI response
  MenuRequest copyWithAIResponse(AIResponse response, int processingTime) {
    return MenuRequest(
      id: id,
      imageUrl: imageUrl,
      description: description,
      createdAt: createdAt,
      aiResponse: response,
      status: RequestStatus.completed,
      processingTimeMs: processingTime,
    );
  }
}

// Enum สำหรับ tracking status
enum RequestStatus {
  pending,    // รอ AI ประมวลผล
  processing, // AI กำลังทำงาน
  completed,  // เสร็จแล้ว
  failed      // เกิดข้อผิดพลาด
}

// AIResponse Model ปรับปรุง
class AIResponse {
  final String name;
  final List<String> ingredients;
  final List<String> instructions; // แยกเป็น step แต่ละขั้น
  final String? tip;
  final RecipeMetadata metadata; // ข้อมูลเพิ่มเติม

  AIResponse({
    required this.name,
    required this.ingredients,
    required this.instructions,
    this.tip,
    required this.metadata,
  });

  factory AIResponse.fromMap(Map<String, dynamic> map) {
    return AIResponse(
      name: map['name'] ?? '',
      ingredients: List<String>.from(map['ingredients'] ?? []),
      instructions: List<String>.from(map['instructions'] ?? []),
      tip: map['tip'],
      metadata: RecipeMetadata.fromMap(map['metadata'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ingredients': ingredients,
      'instructions': instructions,
      if (tip != null) 'tip': tip,
      'metadata': metadata.toMap(),
    };
  }
}

// เพิ่ม Metadata สำหรับข้อมูลเสริม
class RecipeMetadata {
  final int estimatedTime; // นาที
  final String difficulty; // easy, medium, hard
  final int servings;
  final List<String> tags; // ["quick", "healthy", "spicy"]

  RecipeMetadata({
    required this.estimatedTime,
    required this.difficulty,
    required this.servings,
    required this.tags,
  });

  factory RecipeMetadata.fromMap(Map<String, dynamic> map) {
    return RecipeMetadata(
      estimatedTime: map['estimatedTime'] ?? 30,
      difficulty: map['difficulty'] ?? 'medium',
      servings: map['servings'] ?? 2,
      tags: List<String>.from(map['tags'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'estimatedTime': estimatedTime,
      'difficulty': difficulty,
      'servings': servings,
      'tags': tags,
    };
  }
}