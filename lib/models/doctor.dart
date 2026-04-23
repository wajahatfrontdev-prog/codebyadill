import 'user.dart';

class Doctor {
  final String id;
  final User user;
  final String? specialization;
  final List<String> consultationType;
  final List<String> languages;
  final List<String> degrees;
  final String? experience;
  final String? licenseNumber;
  final String? pmdcNumber;
  final String? clinicName;
  final String? clinicAddress;
  final List<String> availableDays;
  final AvailableTime? availableTime;
  final bool isApproved;
  final List<double> ratings;
  final List<String> reviews;

  Doctor({
    required this.id,
    required this.user,
    this.specialization,
    this.consultationType = const [],
    this.languages = const [],
    this.degrees = const [],
    this.experience,
    this.licenseNumber,
    this.pmdcNumber,
    this.clinicName,
    this.clinicAddress,
    this.availableDays = const [],
    this.availableTime,
    this.isApproved = false,
    this.ratings = const [],
    this.reviews = const [],
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    // Handle consultationType - can be String or List
    List<String> parseConsultationType(dynamic value) {
      if (value == null) return [];
      if (value is String) return [value];
      if (value is List) return List<String>.from(value);
      return [];
    }

    // Handle both nested user object and flat format from backend
    Map<String, dynamic> userJson;
    if (json['user'] != null && json['user'] is Map) {
      userJson = json['user'] as Map<String, dynamic>;
    } else {
      userJson = {
        '_id': json['_id'] ?? json['id'] ?? '',
        'name': json['name'] ?? '',
        'email': json['email'] ?? '',
        'phoneNumber': json['phoneNumber'] ?? '',
        'role': json['role'] ?? 'doctor',
      };
    }

    return Doctor(
      id: json['_id'] ?? json['id'] ?? '',
      user: User.fromJson(userJson),
      specialization: json['specialization'],
      consultationType: parseConsultationType(json['consultationType']),
      languages: json['languages'] != null
          ? List<String>.from(json['languages'])
          : [],
      degrees: json['degrees'] != null
          ? List<String>.from(json['degrees'])
          : [],
      experience: json['experience'],
      licenseNumber: json['licenseNumber'],
      pmdcNumber: json['pmdcNumber'],
      clinicName: json['clinicName'],
      clinicAddress: json['clinicAddress'],
      availableDays: json['availableDays'] != null
          ? List<String>.from(json['availableDays'])
          : (json['availability']?['availableDays'] != null
              ? List<String>.from(json['availability']['availableDays'])
              : []),
      availableTime: json['availableTime'] != null
          ? (json['availableTime'] is String
              ? _parseTimeString(json['availableTime'])
              : AvailableTime.fromJson(json['availableTime']))
          : (json['availability']?['availableTime'] != null
              ? AvailableTime.fromJson(json['availability']['availableTime'])
              : null),
      isApproved: json['isApproved'] ?? false,
      ratings: json['ratings'] != null
          ? (json['ratings'] is List
              ? List<double>.from(json['ratings'].map((r) => (r as num).toDouble()))
              : [((json['ratings'] as num).toDouble())])
          : (json['rating'] != null
              ? [(json['rating'] as num).toDouble()]
              : []),
      reviews: json['reviews'] != null
          ? List<String>.from(json['reviews'])
          : [],
    );
  }

  static AvailableTime _parseTimeString(String timeStr) {
    // Parse "9:00 AM - 5:00 PM" format
    final parts = timeStr.split(' - ');
    return AvailableTime(
      start: parts.isNotEmpty ? parts[0].trim() : '',
      end: parts.length > 1 ? parts[1].trim() : '',
    );
  }

  double get averageRating {
    if (ratings.isEmpty) return 0.0;
    return ratings.reduce((a, b) => a + b) / ratings.length;
  }

  int get reviewCount => reviews.length;
}

class AvailableTime {
  final String start;
  final String end;

  AvailableTime({required this.start, required this.end});

  factory AvailableTime.fromJson(Map<String, dynamic> json) {
    return AvailableTime(start: json['start'] ?? '', end: json['end'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'start': start, 'end': end};
  }
}
