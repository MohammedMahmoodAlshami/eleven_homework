import 'dart:convert';
import 'dart:async' as async;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../core/exceptions.dart';

class ApiService {
  static const String apiUrl = 'https://fakestoreapi.com/products';

  Future<List<Product>> fetchProducts() async {
    int maxRetries = 2;
    int currentRetry = 0;

    while (currentRetry <= maxRetries) {
      try {
        final response = await http
            .get(Uri.parse(apiUrl))
            .timeout(const Duration(seconds: 15));

        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          if (data.isEmpty) {
            throw ServerException('Empty API response');
          }
          return data.map((json) => Product.fromJson(json)).toList();
        } else if (response.statusCode >= 500) {
          throw ServerException('Server error', response.statusCode);
        } else if (response.statusCode == 404) {
          throw ServerException('Resource not found', response.statusCode);
        } else {
          throw ServerException('Failed to load products', response.statusCode);
        }
      } on SocketException {
        throw NetworkException('No internet connection');
      } on async.TimeoutException {
        if (currentRetry == maxRetries) throw TimeoutException('Request timed out after 15 seconds');
      } on FormatException {
        throw ServerException('Invalid JSON response');
      } catch (e) {
        if (e is ServerException && e.statusCode != null && e.statusCode! >= 500) {
          // proceed to retry
        } else if (e is NetworkException || e is ServerException) {
          rethrow; // Don't retry 4xx errors or if network is completely off
        } else if (currentRetry == maxRetries) {
          rethrow;
        }
      }
      
      currentRetry++;
      if (currentRetry <= maxRetries) {
        debugPrint('Retry $currentRetry/$maxRetries...');
        await Future.delayed(Duration(seconds: 2 * currentRetry));
      }
    }
    throw ServerException('Failed after retries');
  }
}
