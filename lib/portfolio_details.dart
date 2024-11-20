import 'package:flutter/material.dart';

class PortfolioDetails extends StatelessWidget {
  final String balance;
  final bool isDarkTheme;

  const PortfolioDetails({
    super.key,
    required this.balance,
    required this.isDarkTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio Details'),
        backgroundColor: isDarkTheme ? Colors.grey[900] : Colors.blue[600],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkTheme
                ? [Colors.blueGrey[900]!, Colors.blueGrey[700]!]
                : [Colors.blue[50]!, Colors.blue[100]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Balance Display
              Text(
                'Balance',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: isDarkTheme ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                balance,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isDarkTheme ? Colors.tealAccent : Colors.green,
                ),
              ),
              const SizedBox(height: 16),
              // Placeholder for Portfolio Assets
              Expanded(
                child: Center(
                  child: Text(
                    'Portfolio details coming soon!',
                    style: TextStyle(
                      fontSize: 18,
                      color: isDarkTheme ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
