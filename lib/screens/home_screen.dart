import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../models/article_model.dart';
import '../services/news_service.dart';
import '../widgets/article_card.dart';
import 'article_detail_screen.dart';

/// Main screen that displays a list of top news headlines
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Service to fetch news articles
  final NewsService _newsService = NewsService();

  // Controller for pull-to-refresh functionality
  final RefreshController _refreshController = RefreshController();

  // List to store fetched articles
  List<Article> _articles = [];

  // Controls whether the loading spinner should be shown
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNews(); // Load articles when screen first builds
  }

  /// Fetches top headlines and updates UI state
  Future<void> _loadNews() async {
    try {
      final articles = await _newsService.getTopHeadlines();
      setState(() {
        _articles = articles;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        // Show error message if news could not be loaded
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to load news'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    }
  }

  /// Refresh callback for pull-to-refresh action
  Future<void> _onRefresh() async {
    try {
      final articles = await _newsService.getTopHeadlines();
      setState(() => _articles = articles);
      _refreshController.refreshCompleted(); // Mark refresh as successful
    } catch (e) {
      _refreshController.refreshFailed(); // Mark refresh as failed
    }
  }

  @override
  void dispose() {
    _refreshController.dispose(); // Clean up the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top app bar with title
      appBar: AppBar(
        title: const Text(
          'News App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 2,
      ),

      // Main content area
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(), // Show spinner while loading
      )
          : SmartRefresher(
        controller: _refreshController, // Controls pull-to-refresh
        onRefresh: _onRefresh,           // Called when user pulls down
        header: const WaterDropHeader(
          waterDropColor: Colors.blue,   // Drop animation color
          complete: Icon(
            Icons.check,
            color: Colors.green,
          ),
        ),

        // If no articles available, show placeholder UI
        child: _articles.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.newspaper,
                size: 64,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              Text(
                'No news available',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: _onRefresh, // Retry button
                child: const Text('Refresh'),
              ),
            ],
          ),
        )

        // If articles available, show list of news cards
            : ListView.builder(
          padding: const EdgeInsets.only(top: 8),
          itemCount: _articles.length,
          itemBuilder: (context, index) {
            final article = _articles[index];
            return Hero(
              tag: article.url, // Hero tag for transition animation
              child: ArticleCard(
                article: article, // Display each article using a card
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ArticleDetailScreen(article: article), // Open detail page
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
