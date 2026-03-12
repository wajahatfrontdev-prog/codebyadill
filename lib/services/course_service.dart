import 'package:dio/dio.dart';
import 'api_service.dart';

class CourseService {
  final ApiService _apiService = ApiService();

  // List all public courses
  Future<List<dynamic>> listPublicCourses() async {
    try {
      final response = await _apiService.get('/students/courses');
      return response.data['courses'] ?? [];
    } catch (e) {
      print('Error listing public courses: $e');
      rethrow;
    }
  }

  // Get course details by ID
  Future<Map<String, dynamic>> getCourseDetails(String courseId) async {
    try {
      final response = await _apiService.get('/students/courses/$courseId');
      return response.data['course'];
    } catch (e) {
      print('Error getting course details: $e');
      rethrow;
    }
  }

  // Buy/Enroll in a course
  Future<Map<String, dynamic>> buyCourse(String courseId) async {
    try {
      print('Attempting to buy course: $courseId');
      final response = await _apiService.post('/students/courses/enrollments', {
        'courseId': courseId,
      });
      print('Buy course response: ${response.data}');
      return response.data;
    } on DioException catch (e) {
      print('Error buying course - Status: ${e.response?.statusCode}');
      print('Error buying course - Data: ${e.response?.data}');
      print('Error buying course - Message: ${e.message}');
      rethrow;
    } catch (e) {
      print('Error buying course: $e');
      rethrow;
    }
  }

  // Get my purchased courses
  Future<List<dynamic>> myPurchases() async {
    try {
      final response = await _apiService.get('/students/courses/enrollments/my');
      // Backend returns { success, count, items }
      return response.data['items'] ?? response.data['enrollments'] ?? [];
    } catch (e) {
      print('Error getting my purchases: $e');
      rethrow;
    }
  }

  // Update course progress
  Future<Map<String, dynamic>> updateProgress(String enrollmentId, Map<String, dynamic> data) async {
    try {
      final response = await _apiService.put('/students/courses/enrollments/$enrollmentId/progress', data);
      return response.data;
    } catch (e) {
      print('Error updating progress: $e');
      rethrow;
    }
  }

  // Get my certificates
  Future<List<dynamic>> myCertificates() async {
    try {
      final response = await _apiService.get('/students/courses/certificates/my');
      return response.data['certificates'] ?? [];
    } catch (e) {
      print('Error getting my certificates: $e');
      rethrow;
    }
  }
}
