import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../models/article_model.dart';

/// Screen that shows the full details of a selected news article.
class ArticleDetailScreen extends StatelessWidget {
  final Article article; // The article to display

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    // Parse the published date string into a DateTime object
    final publishedDate = DateTime.parse(article.publishedAt);
    // Format the date in a readable way (e.g., July 6, 2025)
    final formattedDate = DateFormat.yMMMMd().format(publishedDate);

    return Scaffold(
      // Use a scrollable view with advanced app bar behavior
      body: CustomScrollView(
        slivers: [
          // A collapsible app bar that stays pinned when scrolling
          SliverAppBar(
            expandedHeight: 200.0, // Height of expanded app bar
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              // Overlay article title with semi-transparent background
              title: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5), // Semi-transparent black background
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  article.title, // Show article title
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 2, // Prevent overflow with ellipsis
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // Display the article image in the background with a smooth transition
              background: Hero(
                tag: article.url, // Use article URL as a unique tag for hero animation
                child: article.urlToImage != null
                    ? CachedNetworkImage(
                  imageUrl: article.urlToImage!, // Load article image from network
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[300], // Light gray placeholder background
                    child: const Center(
                      child: CircularProgressIndicator(), // Show loading spinner
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.error, // Show error icon if image fails to load
                      size: 48,
                      color: Colors.grey,
                    ),
                  ),
                )
                    : Container(
                  color: Colors.grey[300], // If no image URL, show default placeholder
                  child: const Icon(
                    Icons.newspaper, // Use newspaper icon as fallback
                    size: 48,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),

          // Main article content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display publication date
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        formattedDate, // Formatted publish date
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),

                  // Display author info if available
                  if (article.author != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.person, size: 16),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'By ${article.author}', // Author name
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],

                  // Display source info if available
                  if (article.source != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.source, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          article.source!, // Source name
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],

                  const SizedBox(height: 16),

                  // Show article description if available
                  if (article.description != null) ...[
                    Text(
                      article.description!,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Show full article content if available
                  if (article.content != null)
                    Text(
                      article.content!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
