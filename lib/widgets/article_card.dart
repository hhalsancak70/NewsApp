import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart'; // For optimized image loading and caching
import 'package:intl/intl.dart'; // For formatting the published date
import '../models/article_model.dart'; // Importing the Article model

/// A reusable UI widget that displays an article's preview inside a styled card
class ArticleCard extends StatelessWidget {
  final Article article; // The article data to display
  final VoidCallback onTap; // Callback when the card is tapped

  const ArticleCard({
    super.key,
    required this.article,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Parse and format the article's publication date
    final publishedDate = DateTime.parse(article.publishedAt);
    final formattedDate = DateFormat.yMMMMd().format(publishedDate);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2, // Elevation for shadow effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: InkWell(
        onTap: onTap, // Handle tap interactions
        borderRadius: BorderRadius.circular(12), // Ripple effect matches border radius
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display article image if available
            if (article.urlToImage != null)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: CachedNetworkImage(
                  imageUrl: article.urlToImage!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover, // Cover the width of the card
                  placeholder: (context, url) => Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: CircularProgressIndicator(), // Show loader while image loads
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    height: 200,
                    child: const Icon(
                      Icons.error,
                      size: 48,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            // Article content (title, description, source, date)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Article title
                  Text(
                    article.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2, // Limit title lines
                    overflow: TextOverflow.ellipsis, // Add "..." if too long
                  ),
                  const SizedBox(height: 8),
                  // Article description (if available)
                  if (article.description != null) ...[
                    Text(
                      article.description!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                  ],
                  // Row for article source and published date
                  Row(
                    children: [
                      // Source (if available)
                      if (article.source != null) ...[
                        Icon(
                          Icons.source,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            article.source!,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text('•'), // Separator
                        const SizedBox(width: 8),
                      ],
                      // Published date
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        formattedDate, // Formatted publication date
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
