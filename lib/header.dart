import 'package:flutter/material.dart';
import 'portfolio_card.dart';
import 'stocks_list.dart';

class PortfolioHeader extends StatefulWidget {
  const PortfolioHeader({super.key});

  @override
  State<PortfolioHeader> createState() => _PortfolioHeaderState();
}

class _PortfolioHeaderState extends State<PortfolioHeader> {
  bool isDarkTheme = false;

  // Mock data for market stocks
  final List<Map<String, dynamic>> marketStocks = [
    {'name': 'Apple', 'price': 150.75, 'change': 1.2},
    {'name': 'Tesla', 'price': 700.3, 'change': -2.5},
    {'name': 'Amazon', 'price': 3200.5, 'change': 0.8},
  ];

  // Mock data for favorite stocks
  final List<Map<String, dynamic>> favoriteStocks = [
    {'name': 'NVIDIA', 'price': 430.5, 'change': 2.3},
    {'name': 'Meta', 'price': 278.4, 'change': -0.9},
    {'name': 'Netflix', 'price': 390.2, 'change': 1.7},
  ];

  void _navigateToStocks(BuildContext context, List<Map<String, dynamic>> stocks, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StocksPage(
          title: title,
          stocks: stocks,
          isDarkTheme: isDarkTheme,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkTheme ? Colors.grey[900] : Colors.grey[300],
        elevation: 0,
        title: const Text(
          'Market Overview',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              isDarkTheme ? Icons.dark_mode : Icons.light_mode,
              color: Colors.blue,
            ),
            onPressed: () {
              setState(() {
                isDarkTheme = !isDarkTheme;
              });
            },
          ),
        ],
      ),
      backgroundColor: isDarkTheme ? Colors.grey[850] : Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Portfolio Card
            PortfolioCard(
              isDarkTheme: isDarkTheme,
              percentageChange: 5.6,
            ),
            const SizedBox(height: 16),
            // Market Stocks Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Market Stocks',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkTheme ? Colors.white : Colors.black87,
                  ),
                ),
                TextButton(
                  onPressed: () => _navigateToStocks(context, marketStocks, 'All Market Stocks'),
                  child: const Text(
                    'View All',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            LimitedBox(
              maxHeight: 150,
              child: Stack(
                children: [
                  StocksList(
                    isDarkTheme: isDarkTheme,
                    stocks: marketStocks,
                    showSearchBar: false,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            isDarkTheme ? Colors.grey[850]! : Colors.grey[200]!,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Favorite Stocks Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Favorite Stocks',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkTheme ? Colors.white : Colors.black87,
                  ),
                ),
                TextButton(
                  onPressed: () => _navigateToStocks(context, favoriteStocks, 'Favorite Stocks'),
                  child: const Text(
                    'View All',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            LimitedBox(
              maxHeight: 150,
              child: Stack(
                children: [
                  StocksList(
                    isDarkTheme: isDarkTheme,
                    stocks: favoriteStocks,
                    showSearchBar: false,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            isDarkTheme ? Colors.grey[850]! : Colors.grey[200]!,
                          ],
                        ),
                      ),
                    ),
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

class StocksPage extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> stocks;
  final bool isDarkTheme;

  const StocksPage({
    super.key,
    required this.title,
    required this.stocks,
    required this.isDarkTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: isDarkTheme ? Colors.grey[900] : Colors.blue[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StocksList(
          isDarkTheme: isDarkTheme,
          stocks: stocks,
          showSearchBar: true, // Show search bar on this page
        ),
      ),
    );
  }
}
