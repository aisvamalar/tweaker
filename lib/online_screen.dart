import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async';
import 'dart:math' as math;

class OnlineScreen extends StatefulWidget {
  @override
  State<OnlineScreen> createState() => _OnlineScreenState();
}

class _OnlineScreenState extends State<OnlineScreen>
    with TickerProviderStateMixin {
  int _selectedTab = 0; // 0: Last Year, 1: Month, 2: Days
  int _currentReview = 0;
  late AnimationController _graphAnimationController;
  late AnimationController _statsAnimationController;
  late Animation<double> _graphAnimation;
  late Animation<double> _statsAnimation;
  Timer? _autoSlideTimer;
  late ScrollController _reviewScrollController;
  int _currentStatTab = 0; // 0: This Year, 1: Month, 2: Week

  // Sample data for different time periods
  final Map<int, List<FlSpot>> _graphData = {
    0: [
      // Last Year (more organic data)
      FlSpot(0, 420), FlSpot(1, 380), FlSpot(2, 450), FlSpot(3, 520),
      FlSpot(4, 490), FlSpot(5, 580), FlSpot(6, 650), FlSpot(7, 720),
      FlSpot(8, 680), FlSpot(9, 750), FlSpot(10, 820), FlSpot(11, 890),
    ],
    1: [
      // Month (enhanced with more realistic patterns)
      FlSpot(0, 150), FlSpot(1, 180), FlSpot(2, 220), FlSpot(3, 200),
      FlSpot(4, 280), FlSpot(5, 350), FlSpot(6, 320), FlSpot(7, 400),
      FlSpot(8, 480), FlSpot(9, 450), FlSpot(10, 520), FlSpot(11, 580),
      FlSpot(12, 550), FlSpot(13, 480), FlSpot(14, 420), FlSpot(15, 380),
      FlSpot(16, 350), FlSpot(17, 420), FlSpot(18, 480), FlSpot(19, 520),
      FlSpot(20, 580), FlSpot(21, 620), FlSpot(22, 680), FlSpot(23, 720),
      FlSpot(24, 650), FlSpot(25, 580), FlSpot(26, 520), FlSpot(27, 480),
      FlSpot(28, 420), FlSpot(29, 380),
    ],
    2: [
      // Days (hourly data)
      FlSpot(0, 45), FlSpot(1, 50), FlSpot(2, 70), FlSpot(3, 85),
      FlSpot(4, 95), FlSpot(5, 120), FlSpot(6, 140), FlSpot(7, 165),
      FlSpot(8, 190), FlSpot(9, 220), FlSpot(10, 250), FlSpot(11, 280),
      FlSpot(12, 320), FlSpot(13, 350), FlSpot(14, 380), FlSpot(15, 420),
      FlSpot(16, 400), FlSpot(17, 360), FlSpot(18, 320), FlSpot(19, 280),
      FlSpot(20, 240), FlSpot(21, 200), FlSpot(22, 160), FlSpot(23, 120),
    ],
  };

  final Map<int, List<Map<String, dynamic>>> _statData = {
    0: [
      // This Year
      {
        'icon': Icons.facebook,
        'color': Color(0xFF1877F2),
        'label': 'Facebook',
        'likes': 1250000,
        'change': '+12.5%',
        'isPositive': true,
      },
      {
        'icon': Icons.camera_alt,
        'color': Color(0xFFE4405F),
        'label': 'Instagram',
        'likes': 980000,
        'change': '+18.3%',
        'isPositive': true,
      },
      {
        'icon': Icons.alternate_email,
        'color': Color(0xFF1DA1F2),
        'label': 'Twitter',
        'likes': 567000,
        'change': '-2.1%',
        'isPositive': false,
      },
      {
        'icon': Icons.play_circle_fill,
        'color': Color(0xFFFF0000),
        'label': 'YouTube',
        'likes': 1850000,
        'change': '+25.8%',
        'isPositive': true,
      },
      {
        'icon': Icons.reddit,
        'color': Color(0xFFFF4500),
        'label': 'Reddit',
        'likes': 342000,
        'change': '+8.9%',
        'isPositive': true,
      },
      {
        'icon': Icons.ads_click,
        'color': Color(0xFF4285F4),
        'label': 'Meta Ads',
        'likes': 450000,
        'change': '+15.2%',
        'isPositive': true,
      },
      {
        'icon': Icons.search,
        'color': Color(0xFF34A853),
        'label': 'Google Ads',
        'likes': 680000,
        'change': '+22.1%',
        'isPositive': true,
      },
      {
        'icon': Icons.verified,
        'color': Color(0xFF00B67A),
        'label': 'Trustpilot',
        'likes': 128000,
        'change': '+7.3%',
        'isPositive': true,
      },
    ],
    1: [
      // Month
      {
        'icon': Icons.facebook,
        'color': Color(0xFF1877F2),
        'label': 'Facebook',
        'likes': 89935,
        'change': '+1.01%',
        'isPositive': true,
      },
      {
        'icon': Icons.camera_alt,
        'color': Color(0xFFE4405F),
        'label': 'Instagram',
        'likes': 76420,
        'change': '+2.5%',
        'isPositive': true,
      },
      {
        'icon': Icons.alternate_email,
        'color': Color(0xFF1DA1F2),
        'label': 'Twitter',
        'likes': 41250,
        'change': '-0.3%',
        'isPositive': false,
      },
      {
        'icon': Icons.play_circle_fill,
        'color': Color(0xFFFF0000),
        'label': 'YouTube',
        'likes': 125600,
        'change': '+3.2%',
        'isPositive': true,
      },
      {
        'icon': Icons.reddit,
        'color': Color(0xFFFF4500),
        'label': 'Reddit',
        'likes': 28900,
        'change': '+1.7%',
        'isPositive': true,
      },
      {
        'icon': Icons.ads_click,
        'color': Color(0xFF4285F4),
        'label': 'Meta Ads',
        'likes': 34580,
        'change': '+0.9%',
        'isPositive': true,
      },
      {
        'icon': Icons.search,
        'color': Color(0xFF34A853),
        'label': 'Google Ads',
        'likes': 52340,
        'change': '+1.8%',
        'isPositive': true,
      },
      {
        'icon': Icons.verified,
        'color': Color(0xFF00B67A),
        'label': 'Trustpilot',
        'likes': 15670,
        'change': '+2.8%',
        'isPositive': true,
      },
    ],
    2: [
      // Week
      {
        'icon': Icons.facebook,
        'color': Color(0xFF1877F2),
        'label': 'Facebook',
        'likes': 18500,
        'change': '+3.2%',
        'isPositive': true,
      },
      {
        'icon': Icons.camera_alt,
        'color': Color(0xFFE4405F),
        'label': 'Instagram',
        'likes': 22800,
        'change': '+5.8%',
        'isPositive': true,
      },
      {
        'icon': Icons.alternate_email,
        'color': Color(0xFF1DA1F2),
        'label': 'Twitter',
        'likes': 8900,
        'change': '-1.2%',
        'isPositive': false,
      },
      {
        'icon': Icons.play_circle_fill,
        'color': Color(0xFFFF0000),
        'label': 'YouTube',
        'likes': 35600,
        'change': '+8.5%',
        'isPositive': true,
      },
      {
        'icon': Icons.reddit,
        'color': Color(0xFFFF4500),
        'label': 'Reddit',
        'likes': 6700,
        'change': '+2.1%',
        'isPositive': true,
      },
      {
        'icon': Icons.ads_click,
        'color': Color(0xFF4285F4),
        'label': 'Meta Ads',
        'likes': 12400,
        'change': '+4.3%',
        'isPositive': true,
      },
      {
        'icon': Icons.search,
        'color': Color(0xFF34A853),
        'label': 'Google Ads',
        'likes': 16800,
        'change': '+6.7%',
        'isPositive': true,
      },
      {
        'icon': Icons.verified,
        'color': Color(0xFF00B67A),
        'label': 'Trustpilot',
        'likes': 4200,
        'change': '+1.9%',
        'isPositive': true,
      },
    ],
  };

  final List<Map<String, dynamic>> _reviews = [
    {
      'icon': Icons.facebook,
      'color': Color(0xFF1877F2),
      'name': 'Monica Chen',
      'business': 'Business Owner',
      'location': 'San Francisco, CA',
      'stars': 5,
      'desc':
          'Absolutely fantastic service! The team exceeded all expectations and delivered results that transformed our business. Their attention to detail and customer service is unmatched.',
      'date': '2 days ago',
    },
    {
      'icon': Icons.camera_alt,
      'color': Color(0xFFE4405F),
      'name': 'Aarthi Kumar',
      'business': 'Digital Marketer',
      'location': 'Mumbai, India',
      'stars': 4,
      'desc':
          'Great experience overall. The platform is user-friendly and has helped us reach our target audience effectively. Some minor improvements could be made but generally satisfied.',
      'date': '1 week ago',
    },
    {
      'icon': Icons.play_circle_fill,
      'color': Color(0xFFFF0000),
      'name': 'David Wilson',
      'business': 'Content Creator',
      'location': 'London, UK',
      'stars': 5,
      'desc':
          'This platform has revolutionized how we manage our online presence. The analytics are comprehensive and the insights have helped us grow significantly.',
      'date': '3 days ago',
    },
    {
      'icon': Icons.language,
      'color': Color(0xFF0A66C2),
      'name': 'Sarah Johnson',
      'business': 'Marketing Director',
      'location': 'New York, NY',
      'stars': 4,
      'desc':
          'Impressive tools and great customer support. The dashboard is intuitive and provides all the metrics we need to track our performance effectively.',
      'date': '5 days ago',
    },
    {
      'icon': Icons.music_note,
      'color': Color(0xFF1DB954),
      'name': 'Carlos Rodriguez',
      'business': 'E-commerce Owner',
      'location': 'Barcelona, Spain',
      'stars': 5,
      'desc':
          'Outstanding results! Our online sales have increased by 40% since using this platform. The ROI tracking features are particularly valuable.',
      'date': '1 day ago',
    },
    {
      'icon': Icons.reddit,
      'color': Color(0xFFFF4500),
      'name': 'Emma Thompson',
      'business': 'Startup Founder',
      'location': 'Toronto, Canada',
      'stars': 4,
      'desc':
          'Very comprehensive platform with great analytics. The team is responsive and helpful. Looking forward to seeing more features in future updates.',
      'date': '4 days ago',
    },
  ];

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _graphAnimationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    _statsAnimationController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );

    _graphAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _graphAnimationController, curve: Curves.easeInOut),
    );

    _statsAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _statsAnimationController, curve: Curves.easeInOut),
    );

    // Initialize scroll controller for reviews
    _reviewScrollController = ScrollController();

    // Start animations
    _graphAnimationController.forward();
    _statsAnimationController.forward();

    // Start auto-slide for reviews
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (mounted && _reviewScrollController.hasClients) {
        setState(() {
          _currentReview = (_currentReview + 1) % _reviews.length;
        });

        // Auto-scroll to the next review
        double itemHeight = 180.0; // Approximate height of each review item
        double targetOffset = _currentReview * itemHeight;

        _reviewScrollController.animateTo(
          targetOffset,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _graphAnimationController.dispose();
    _statsAnimationController.dispose();
    _reviewScrollController.dispose();
    _autoSlideTimer?.cancel();
    super.dispose();
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              // Logo
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF6B9CFF), Color(0xFF4A7CF7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: const Text(
                  'TWEAKER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              Spacer(),
              // Navigation items
              _buildNavItem('Complaints viewed'),
              _buildNavItem('Complaints Solved'),
              _buildNavItem('Marked Complaints'),
              _buildNavItem('About Us'),
              SizedBox(width: 24),
              // Search bar
              Container(
                width: 300,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xFFF5F7FA),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 16),
                    Icon(Icons.search, color: Colors.grey[600], size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search Transactions and Documents',
                          border: InputBorder.none,
                          hintStyle:
                              TextStyle(color: Colors.grey[600], fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              // User profile
              CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xFFF5F7FA),
                child: Icon(Icons.person, color: Colors.grey[600], size: 20),
              ),
              SizedBox(width: 8),
              Text(
                'Clayton Santos',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(width: 16),
              Icon(Icons.notifications_none, color: Colors.grey[600]),
              SizedBox(width: 16),
              Icon(Icons.more_vert, color: Colors.grey[600]),
            ],
          ),
          SizedBox(height: 16),
          // Breadcrumb
          Row(
            children: [
              Text(
                'Dashboard > Return Fee > Company details > Online reach',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildWebsiteTrafficCard() {
    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6C7CE7), Color(0xFF4A5FC7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Website traffic',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Text(
                '/2024',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Spacer(),
          Center(
            child: AnimatedBuilder(
              animation: _statsAnimation,
              builder: (context, child) {
                return Text(
                  '${(12000 * _statsAnimation.value).toInt()}k',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          Spacer(),
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Social Media',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              Spacer(),
              Text(
                '78%',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.white60,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Organic Search',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              Spacer(),
              Text(
                '22%',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVisitorInsights() {
    return Expanded(
      child: Container(
        height: 280,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFF8F9FF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF6C7CE7).withOpacity(0.1),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
          border: Border.all(
            color: Color(0xFF6C7CE7).withOpacity(0.1),
            width: 1,
          ),
        ),
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFF6C7CE7).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.insights,
                    color: Color(0xFF6C7CE7),
                    size: 20,
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Visitor Insights',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6C7CE7),
                      ),
                    ),
                    Text(
                      'Real-time analytics',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Spacer(),
                _buildTabButton('Last Year', 0),
                _buildTabButton('Month', 1),
                _buildTabButton('Days', 2),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: AnimatedBuilder(
                animation: _graphAnimation,
                builder: (context, child) {
                  return LineChart(
                    LineChartData(
                      minY: 0,
                      maxY: _getMaxY(),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 50,
                            interval: _getMaxY() / 4,
                            getTitlesWidget: (value, meta) {
                              return Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Text(
                                  _formatYAxisValue(value),
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (value, meta) {
                              return _getBottomTitles(value.toInt());
                            },
                          ),
                        ),
                        rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: true,
                        horizontalInterval: _getMaxY() / 4,
                        verticalInterval: _getVerticalInterval(),
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Colors.grey[200],
                            strokeWidth: 1,
                            dashArray: [5, 5],
                          );
                        },
                        getDrawingVerticalLine: (value) {
                          return FlLine(
                            color: Colors.grey[200],
                            strokeWidth: 1,
                            dashArray: [5, 5],
                          );
                        },
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: _graphData[_selectedTab]!.map((spot) {
                            return FlSpot(
                              spot.x,
                              spot.y * _graphAnimation.value,
                            );
                          }).toList(),
                          isCurved: true,
                          curveSmoothness: 0.4,
                          color: Color(0xFF6C7CE7),
                          barWidth: 4,
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF6C7CE7).withOpacity(0.4),
                                Color(0xFF6C7CE7).withOpacity(0.1),
                                Color(0xFF6C7CE7).withOpacity(0.05),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
                              return FlDotCirclePainter(
                                radius: 4,
                                color: Color(0xFF6C7CE7),
                                strokeWidth: 2,
                                strokeColor: Colors.white,
                              );
                            },
                          ),
                        ),
                        // Add a secondary line for comparison
                        LineChartBarData(
                          spots: _graphData[_selectedTab]!.map((spot) {
                            return FlSpot(
                              spot.x,
                              (spot.y * 0.7) * _graphAnimation.value,
                            );
                          }).toList(),
                          isCurved: true,
                          curveSmoothness: 0.4,
                          color: Color(0xFF2EE6CA),
                          barWidth: 3,
                          belowBarData: BarAreaData(show: false),
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
                              return FlDotCirclePainter(
                                radius: 3,
                                color: Color(0xFF2EE6CA),
                                strokeWidth: 2,
                                strokeColor: Colors.white,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 12),
            // Legend
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem('Current Period', Color(0xFF6C7CE7)),
                SizedBox(width: 20),
                _buildLegendItem('Previous Period', Color(0xFF2EE6CA)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  double _getMaxY() {
    if (_selectedTab == 0) return 1000;
    if (_selectedTab == 1) return 800;
    return 500;
  }

  double _getVerticalInterval() {
    if (_selectedTab == 0) return 2;
    if (_selectedTab == 1) return 5;
    return 4;
  }

  String _formatYAxisValue(double value) {
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}k';
    }
    return value.toInt().toString();
  }

  Widget _buildTabButton(String text, int index) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
        _graphAnimationController.reset();
        _graphAnimationController.forward();
      },
      child: Container(
        margin: EdgeInsets.only(left: 8),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF6C7CE7) : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _getBottomTitles(int value) {
    if (_selectedTab == 0) {
      // Last Year
      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      if (value < months.length) {
        return Text(
          months[value],
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        );
      }
    } else if (_selectedTab == 1) {
      // Month
      if (value % 5 == 0) {
        return Text(
          '${value + 1}',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        );
      }
    } else {
      // Days
      if (value % 4 == 0) {
        return Text(
          '${value}h',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        );
      }
    }
    return SizedBox.shrink();
  }

  Widget _buildStatisticalAnalysis() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFF8F9FF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF6C7CE7).withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: Color(0xFF6C7CE7).withOpacity(0.1),
          width: 1,
        ),
      ),
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF6C7CE7).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.analytics,
                  color: Color(0xFF6C7CE7),
                  size: 20,
                ),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Statistical Analysis',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6C7CE7),
                    ),
                  ),
                  Text(
                    'Platform engagement',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              Spacer(),
              _buildStatTabButton('This Year', 0),
              _buildStatTabButton('Month', 1),
              _buildStatTabButton('Week', 2),
            ],
          ),
          SizedBox(height: 20),
          Container(
            height: 280,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1.4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: _statData[_currentStatTab]?.length ?? 0,
                    itemBuilder: (context, index) {
                      final item = _statData[_currentStatTab]![index];
                      return AnimatedBuilder(
                        animation: _statsAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _statsAnimation.value,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey[200]!),
                                boxShadow: [
                                  BoxShadow(
                                    color: item['color'].withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () {
                                    // Add tap animation or action here
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            '${item['label']}: ${_formatNumber((item['likes'] * _statsAnimation.value).toInt())} engagements'),
                                        duration: Duration(seconds: 2),
                                        backgroundColor: item['color'],
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color:
                                                item['color'].withOpacity(0.1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            item['icon'],
                                            color: item['color'],
                                            size: 16,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            _formatNumber((item['likes'] *
                                                    _statsAnimation.value)
                                                .toInt()),
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            item['label'],
                                            style: TextStyle(
                                              fontSize: 9,
                                              color: Colors.grey[600],
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: item['isPositive']
                                                ? Colors.green.withOpacity(0.1)
                                                : Colors.red.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                item['isPositive']
                                                    ? Icons.trending_up
                                                    : Icons.trending_down,
                                                color: item['isPositive']
                                                    ? Colors.green
                                                    : Colors.red,
                                                size: 10,
                                              ),
                                              SizedBox(width: 2),
                                              Flexible(
                                                child: Text(
                                                  item['change'],
                                                  style: TextStyle(
                                                    fontSize: 8,
                                                    color: item['isPositive']
                                                        ? Colors.green
                                                        : Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatTabButton(String text, int index) {
    final isSelected = _currentStatTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentStatTab = index;
        });
        _statsAnimationController.reset();
        _statsAnimationController.forward();
      },
      child: Container(
        margin: EdgeInsets.only(left: 8),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF6C7CE7) : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  Widget _buildTopCriticsReview() {
    return Container(
      width: 350,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFF8F9FF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF6C7CE7).withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: Color(0xFF6C7CE7).withOpacity(0.1),
          width: 1,
        ),
      ),
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF6C7CE7).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.reviews,
                  color: Color(0xFF6C7CE7),
                  size: 20,
                ),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Top Critics Review',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6C7CE7),
                    ),
                  ),
                  Text(
                    '${_reviews.length} reviews',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Color(0xFF28CC38).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Color(0xFF28CC38),
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '4.5',
                      style: TextStyle(
                        color: Color(0xFF28CC38),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            height: 400,
            child: ListView.builder(
              controller: _reviewScrollController,
              physics: BouncingScrollPhysics(),
              itemCount: _reviews.length,
              itemBuilder: (context, index) {
                final review = _reviews[index];
                return AnimatedBuilder(
                  animation: _statsAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, (1 - _statsAnimation.value) * 20),
                      child: Opacity(
                        opacity: _statsAnimation.value,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 16),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.grey[200]!,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.05),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: review['color'],
                                    radius: 20,
                                    child: Icon(
                                      review['icon'],
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          review['name'],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        Text(
                                          review['business'],
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        if (review['location'] != null)
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                size: 12,
                                                color: Colors.grey[500],
                                              ),
                                              SizedBox(width: 2),
                                              Text(
                                                review['location'],
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey[500],
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: List.generate(5, (starIndex) {
                                          return Icon(
                                            Icons.star,
                                            size: 14,
                                            color: starIndex < review['stars']
                                                ? Colors.amber
                                                : Colors.grey[300],
                                          );
                                        }),
                                      ),
                                      if (review['date'] != null)
                                        Text(
                                          review['date'],
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Text(
                                review['desc'],
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[700],
                                  height: 1.4,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.thumb_up,
                                    size: 14,
                                    color: Colors.grey[500],
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Helpful',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.more_horiz,
                                    size: 16,
                                    color: Colors.grey[400],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 16),
          // Progress indicator for auto-scroll
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(3),
            ),
            child: AnimatedBuilder(
              animation: _statsAnimation,
              builder: (context, child) {
                return FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: (_currentReview + 1) / _reviews.length,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF6C7CE7),
                          Color(0xFF4A5FC7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 8),
          // Review indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_reviews.length, (index) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: index == _currentReview ? 12 : 8,
                height: 8,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: index == _currentReview
                      ? Color(0xFF6C7CE7)
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF6C7CE7),
                              Color(0xFF4A5FC7),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.trending_up,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DIGITAL ANALYTICS',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6C7CE7),
                              letterSpacing: 1.5,
                            ),
                          ),
                          Text(
                            'Real-time performance insights',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Color(0xFF28CC38).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color(0xFF28CC38),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.offline_bolt,
                              color: Color(0xFF28CC38),
                              size: 16,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Live Dashboard',
                              style: TextStyle(
                                color: Color(0xFF28CC38),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  // Top row: Website Traffic + Visitor Insights
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildWebsiteTrafficCard(),
                      SizedBox(width: 32),
                      _buildVisitorInsights(),
                    ],
                  ),
                  SizedBox(height: 32),
                  // Bottom row: Statistical Analysis + Top Critics Review
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildStatisticalAnalysis(),
                      ),
                      SizedBox(width: 32),
                      _buildTopCriticsReview(),
                    ],
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
