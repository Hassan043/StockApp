import 'package:flutter/material.dart';

class StocksList extends StatelessWidget {
  final bool isDarkTheme;
  final List<Map<String, dynamic>> stocks;
  final bool showSearchBar;

  const StocksList({
    super.key,
    required this.isDarkTheme,
    required this.stocks,
    required this.showSearchBar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showSearchBar)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search stocks...',
                filled: true,
                fillColor:
                    isDarkTheme ? Colors.blueGrey[800] : Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (query) {
                // Logic to filter stocks based on search
              },
            ),
          ),
        Expanded(
          child: ListView.builder(
            itemCount: stocks.length,
            itemBuilder: (context, index) {
              final stock = stocks[index];
              final stockName = stock['name'];
              final stockPrice = stock['price'];
              final stockChange = stock['change'];

              return GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Viewing details for $stockName'),
                    ),
                  );
                  // Navigate to stock details page (if needed)
                },
                child: Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(
                      vertical: 6.0, horizontal: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: isDarkTheme
                      ? Colors.blueGrey[800]
                      : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Stock Name and Price
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stockName,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDarkTheme
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${stockPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 16,
                                color: isDarkTheme
                                    ? Colors.white70
                                    : Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        // Stock Change Indicator
                        Row(
                          children: [
                            Icon(
                              stockChange >= 0
                                  ? Icons.trending_up
                                  : Icons.trending_down,
                              color: stockChange >= 0
                                  ? (isDarkTheme
                                      ? Colors.tealAccent
                                      : Colors.green)
                                  : (isDarkTheme
                                      ? Colors.redAccent
                                      : Colors.red),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${stockChange >= 0 ? '+' : ''}${stockChange.toStringAsFixed(2)}%',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: stockChange >= 0
                                    ? (isDarkTheme
                                        ? Colors.tealAccent
                                        : Colors.green)
                                    : (isDarkTheme
                                        ? Colors.redAccent
                                        : Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
