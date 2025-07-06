import 'dart:convert'; // For decoding JSON data
import 'package:http/http.dart' as http; // HTTP package for making API calls
import '../models/article_model.dart'; // Importing the Article model

/// A service class responsible for fetching news data from the NewsAPI
class NewsService {
  // Base URL of the NewsAPI
  static const String _baseUrl = 'https://newsapi.org/v2';

  // API key required to access the NewsAPI (you should replace it with your actual key)
  static const String _apiKey = 'YOUR_API_KEY';

  /// Fetches top headlines from the NewsAPI (for country: US)
  Future<List<Article>> getTopHeadlines() async {
    try {
      // Perform GET request to the top-headlines endpoint
      final response = await http.get(
        Uri.parse('$_baseUrl/top-headlines?country=us&apiKey=$_apiKey'),
      );

      // Check if the response is successful (status code 200)
      if (response.statusCode == 200) {
        // Decode the JSON response body
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> articles = data['articles'];

        // Convert each article JSON object to an Article instance
        return articles.map((json) => Article.fromJson(json)).toList();
      } else {
        // If the response was not OK, throw an error
        throw Exception('Failed to load news');
      }
    } catch (e) {
      // Handle any exceptions during the HTTP call or JSON decoding
      throw Exception('Error fetching news: $e');
    }
  }

  /// Searches for news articles matching the provided query
  Future<List<Article>> searchNews(String query) async {
    try {
      // Perform GET request to the everything endpoint with a search query
      final response = await http.get(
        Uri.parse('$_baseUrl/everything?q=$query&apiKey=$_apiKey'),
      );

      // Check for a successful response
      if (response.statusCode == 200) {
        // Decode the response and extract articles
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> articles = data['articles'];

        // Map the JSON articles to Article model instances
        return articles.map((json) => Article.fromJson(json)).toList();
      } else {
        // Throw an error if the response code isn't 200
        throw Exception('Failed to search news');
      }
    } catch (e) {
      // Catch and rethrow any exception with additional context
      throw Exception('Error searching news: $e');
    }
  }
}
