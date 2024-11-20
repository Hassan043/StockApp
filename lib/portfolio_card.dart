import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'portfolio_details.dart';

class PortfolioCard extends StatefulWidget {
  final bool isDarkTheme;
  final double percentageChange;

  const PortfolioCard({
    super.key,
    required this.isDarkTheme,
    required this.percentageChange,
  });

  @override
  _PortfolioCardState createState() => _PortfolioCardState();
}

class _PortfolioCardState extends State<PortfolioCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isBalanceVisible = true;

  // Mocked data for portfolio visualization
  final Map<String, dynamic> _mockData = {
    'balance': 25342.89,
    'chartData': [
      const FlSpot(0, 1),
      const FlSpot(1, 1.8),
      const FlSpot(2, 1.6),
      const FlSpot(3, 2.4),
      const FlSpot(4, 2.2),
      const FlSpot(5, 2.8),
      const FlSpot(6, 3.0),
    ],
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PortfolioDetails(
                balance: '\$${_mockData['balance']}',
                isDarkTheme: widget.isDarkTheme,
              ),
            ),
          );
        },
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: widget.isDarkTheme
                  ? [Colors.blueGrey[800]!, Colors.blueGrey[600]!]
                  : [Colors.blue[200]!, Colors.purple[200]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.isDarkTheme
                    ? Colors.black54
                    : Colors.grey.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left Side: Portfolio Details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Balance',
                          style: TextStyle(
                            fontSize: 28,
                            color: widget.isDarkTheme
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        const SizedBox(width: 4),
                        IconButton(
                          icon: Icon(
                            _isBalanceVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: widget.isDarkTheme
                                ? Colors.white
                                : Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              _isBalanceVisible = !_isBalanceVisible;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isBalanceVisible
                          ? '\$${_mockData['balance']}'
                          : '******',
                      style: TextStyle(
                        color: widget.isDarkTheme
                            ? Colors.white
                            : Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          widget.percentageChange >= 0
                              ? Icons.trending_up
                              : Icons.trending_down,
                          color: widget.percentageChange >= 0
                              ? (widget.isDarkTheme
                                  ? Colors.teal
                                  : Colors.green)
                              : (widget.isDarkTheme
                                  ? Colors.redAccent
                                  : Colors.red),
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${widget.percentageChange >= 0 ? '+' : ''}${widget.percentageChange.toStringAsFixed(1)}%',
                          style: TextStyle(
                            color: widget.percentageChange >= 0
                                ? (widget.isDarkTheme
                                    ? Colors.teal
                                    : Colors.green)
                                : (widget.isDarkTheme
                                    ? Colors.redAccent
                                    : Colors.red),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Right Side: Line Graph
                SizedBox(
                  width: 120,
                  height: 100,
                  child: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: false),
                      titlesData: const FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: _mockData['chartData'],
                          isCurved: true,
                          gradient: const LinearGradient(
                            colors: [Colors.tealAccent, Colors.blueAccent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          barWidth: 3,
                          isStrokeCapRound: true,
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: [
                                Colors.tealAccent.withOpacity(0.3),
                                Colors.blueAccent.withOpacity(0.1),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          dotData: const FlDotData(show: false),
                        ),
                      ],
                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                          tooltipPadding: const EdgeInsets.all(8),
                          tooltipMargin: 8,
                          getTooltipItems: (List<LineBarSpot> touchedSpots) {
                            return touchedSpots.map((spot) {
                              return LineTooltipItem(
                                '\$${spot.y.toStringAsFixed(2)}',
                                const TextStyle(color: Colors.white),
                              );
                            }).toList();
                          },
                        ),
                        handleBuiltInTouches: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
