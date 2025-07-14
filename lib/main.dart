import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'ReturnFeeSpeedometer.dart';

void main() {
  runApp(const FigmaToCodeApp());
}

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
      ),
      home: const Scaffold(
        body: EdhoCompanyDashboard(),
      ),
    );
  }
}

class TaskItem {
  final String name;
  final String amount;
  final int value;
  final IconData icon;
  final Color color;
  double targetProgress;

  TaskItem({
    required this.name,
    required this.amount,
    required this.value,
    required this.icon,
    required this.color,
    this.targetProgress = 0.0,
  });
}

class EdhoCompanyDashboard extends StatefulWidget {
  const EdhoCompanyDashboard({super.key});

  @override
  State<EdhoCompanyDashboard> createState() => _EdhoCompanyDashboardState();
}

class _EdhoCompanyDashboardState extends State<EdhoCompanyDashboard> {
  List<TaskItem> tasks = [
    TaskItem(
      name: 'Return Fee',
      amount: '10',
      value: 400,
      icon: Icons.movie,
      color: const Color(0xFF2EE6CA),
      targetProgress: 0.75,
    ),
    TaskItem(
      name: 'Unfair Rating',
      amount: '12',
      value: 340,
      icon: Icons.shopping_cart,
      color: const Color(0xFFFFCB33),
      targetProgress: 0.85,
    ),
    TaskItem(
      name: 'SLA Penalties',
      amount: '5',
      value: 240,
      icon: Icons.fastfood,
      color: const Color(0xFF28CC38),
      targetProgress: 0.60,
    ),
    TaskItem(
      name: 'Rate Card',
      amount: '2',
      value: 140,
      icon: Icons.local_pharmacy,
      color: const Color(0xFF8833FF),
      targetProgress: 0.40,
    ),
    TaskItem(
      name: 'Fee Breakdown',
      amount: '11',
      value: 30,
      icon: Icons.phone,
      color: const Color(0xFF3360FF),
      targetProgress: 0.30,
    ),
    TaskItem(
      name: 'Listing Rejection',
      amount: '4',
      value: 540,
      icon: Icons.local_gas_station,
      color: const Color(0xFFFF6633),
      targetProgress: 0.90,
    ),
  ];

  void toggleTask(int index) {
    setState(() {
      // Toggle between 0 and the original target progress
      if (tasks[index].targetProgress > 0) {
        tasks[index].targetProgress = 0.0;
      } else {
        // Reset to original values
        final originalProgress = [0.75, 0.85, 0.60, 0.40, 0.30, 0.90];
        tasks[index].targetProgress = originalProgress[index];
      }
    });
  }

  double get completionPercentage {
    int completedTasks = tasks.where((task) => task.targetProgress > 0).length;
    return completedTasks / tasks.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: Column(
        children: [
          // Fixed Header
          const DashboardHeader(),

          // Scrollable Main Content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Section - Chart and Privacy Policy (Fixed Width: 464px)
                        SizedBox(
                          width: 464,
                          child: Column(
                            children: [
                              // Interactive Pie Chart Section
                              InteractivePieChartWidget(
                                tasks: tasks,
                                onTaskToggle: toggleTask,
                                completionPercentage: completionPercentage,
                              ),
                              const SizedBox(height: 20),
                              // Privacy Policy Section
                              const PrivacyPolicySection(),
                            ],
                          ),
                        ),

                        const SizedBox(width: 20),

                        // Middle Section - Recent Operations and Additional Info (Flexible)
                        Expanded(
                          child: Column(
                            children: [
                              const RecentOperationsList(),
                              const SizedBox(height: 20),
                              // Additional Info Section
                              const AdditionalInfoSection(),
                            ],
                          ),
                        ),

                        const SizedBox(width: 20),

                        // Right Sidebar - Menu Only (Fixed Width: 300px)
                        const RightSidebar(),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InteractivePieChartWidget extends StatefulWidget {
  final List<TaskItem> tasks;
  final Function(int) onTaskToggle;
  final double completionPercentage;

  const InteractivePieChartWidget({
    super.key,
    required this.tasks,
    required this.onTaskToggle,
    required this.completionPercentage,
  });

  @override
  State<InteractivePieChartWidget> createState() =>
      _InteractivePieChartWidgetState();
}

class _InteractivePieChartWidgetState extends State<InteractivePieChartWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Start animation after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 464,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Chart Section
          SizedBox(
            height: 400,
            child: Column(
              children: [
                // Chart Header
                Container(
                  height: 65,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: Color(0xFFF5F6F7),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, size: 18),
                        onPressed: () {},
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'To do Chart',
                            style: TextStyle(
                              color: Color(0xFF2B55E5),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${(widget.completionPercentage * 100).toInt()}% Complete',
                            style: const TextStyle(
                              color: Color(0xFF7D8FB3),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh, size: 18),
                        onPressed: () {
                          _animationController.reset();
                          _animationController.forward();
                        },
                      ),
                    ],
                  ),
                ),

                // Interactive Spiral Chart
                Expanded(
                  child: Container(
                    width: 280,
                    height: 280,
                    margin: const EdgeInsets.all(25),
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return CustomPaint(
                          size: const Size(280, 280),
                          painter: SpiralChartPainter(
                            tasks: widget.tasks,
                            animationValue: _animation.value,
                            completionPercentage: widget.completionPercentage,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Interactive Legend Items in same container
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: Color(0xFFF5F6F7),
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: _buildInteractiveLegendItem(0)),
                    const SizedBox(width: 10),
                    Expanded(child: _buildInteractiveLegendItem(1)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: _buildInteractiveLegendItem(2)),
                    const SizedBox(width: 10),
                    Expanded(child: _buildInteractiveLegendItem(3)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: _buildInteractiveLegendItem(4)),
                    const SizedBox(width: 10),
                    Expanded(child: _buildInteractiveLegendItem(5)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractiveLegendItem(int index) {
    if (index >= widget.tasks.length) return const SizedBox();

    final task = widget.tasks[index];
    final isCompleted = task.targetProgress > 0;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {
          widget.onTaskToggle(index);
          _animationController.reset();
          _animationController.forward();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isCompleted ? task.color.withOpacity(0.1) : Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              width: 2,
              color: isCompleted ? task.color : const Color(0xFFF5F6F7),
            ),
            boxShadow: isCompleted
                ? [
                    BoxShadow(
                      color: task.color.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isCompleted ? Icons.check_circle : task.icon,
                color: isCompleted ? task.color : const Color(0xFF7D8FB3),
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${task.name} ${task.amount}',
                  style: TextStyle(
                    color: isCompleted ? task.color : const Color(0xFF7D8FB3),
                    fontSize: 12,
                    fontWeight: isCompleted ? FontWeight.w600 : FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PrivacyPolicySection extends StatelessWidget {
  const PrivacyPolicySection({super.key});

  void _showFlipkartPolicy(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: const Color(0xFF2874F0),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Center(
                  child: Text(
                    'f',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text('Flipkart Policy Details'),
            ],
          ),
          content: SizedBox(
            width: 400,
            height: 300,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Flipkart Seller Policy & Guidelines',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2874F0),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    '• Return & Refund Policy',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '• Seller Protection Guidelines',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '• Fee Structure & Commission',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '• Quality Standards',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '• Dispute Resolution Process',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Official Website:',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'https://seller.flipkart.com/seller-blog/terms-of-use',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF2874F0),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'For detailed seller policies and guidelines, please visit the official Flipkart seller portal or contact seller support.',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showFlipkartPolicy(context),
      child: Container(
        width: 464,
        height: 200,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6B9CFF),
              Color(0xFF4A7CF7),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background Pattern
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: RadialGradient(
                    center: const Alignment(0.3, -0.3),
                    radius: 1.5,
                    colors: [
                      Colors.white.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Content Container - Centered
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Flipkart Shopping Bag Logo
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD700),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Shopping bag handle (smile)
                        Positioned(
                          top: 25,
                          left: 30,
                          right: 30,
                          child: Container(
                            height: 3,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        // Left handle
                        Positioned(
                          top: 15,
                          left: 35,
                          child: Container(
                            width: 3,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        // Right handle
                        Positioned(
                          top: 15,
                          right: 35,
                          child: Container(
                            width: 3,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        // Main 'f' letter
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: const Text(
                              'f',
                              style: TextStyle(
                                color: Color(0xFF2874F0),
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                        // Speed lines
                        Positioned(
                          right: 25,
                          top: 50,
                          child: Column(
                            children: [
                              Container(
                                width: 15,
                                height: 2,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2874F0),
                                  borderRadius: BorderRadius.circular(1),
                                ),
                              ),
                              const SizedBox(height: 3),
                              Container(
                                width: 12,
                                height: 2,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2874F0),
                                  borderRadius: BorderRadius.circular(1),
                                ),
                              ),
                              const SizedBox(height: 3),
                              Container(
                                width: 10,
                                height: 2,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2874F0),
                                  borderRadius: BorderRadius.circular(1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Policy Details Title
                  const Text(
                    'Policy Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
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

  Widget _buildPolicyItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class SpiralChartPainter extends CustomPainter {
  final List<TaskItem> tasks;
  final double animationValue;
  final double completionPercentage;

  SpiralChartPainter({
    required this.tasks,
    required this.animationValue,
    required this.completionPercentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2 - 20;

    // Draw background spiral circles
    for (int i = 0; i < tasks.length; i++) {
      final radius = maxRadius - (i * 20);
      final paint = Paint()
        ..color = tasks[i].color.withOpacity(0.15)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;

      canvas.drawCircle(center, radius, paint);
    }

    // Draw animated completion spiral based on targetProgress
    for (int i = 0; i < tasks.length; i++) {
      final radius = (maxRadius - (i * 20)).toDouble();
      final paint = Paint()
        ..color = tasks[i].color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..strokeCap = StrokeCap.round;

      // Calculate sweep angle based on targetProgress and animation
      final currentProgress = tasks[i].targetProgress * animationValue;
      final sweepAngle = 2 * math.pi * currentProgress;

      if (sweepAngle > 0) {
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          -math.pi / 2, // Start from top
          sweepAngle,
          false,
          paint,
        );
      }
    }

    // Draw center completion indicator
    final centerRadius = 30.0;
    final centerPaint = Paint()
      ..color = completionPercentage > 0.5
          ? const Color(0xFF28CC38)
          : completionPercentage > 0
              ? const Color(0xFFFFCB33)
              : const Color(0xFF7D8FB3)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, centerRadius, centerPaint);

    // Draw completion percentage text
    final textPainter = TextPainter(
      text: TextSpan(
        text: '${(completionPercentage * 100).toInt()}%',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        center.dx - textPainter.width / 2,
        center.dy - textPainter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
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

          // Navigation Links
          Row(
            children: [
              _buildHeaderLink('Proposal viewed'),
              _buildHeaderLink('Proposal approved'),
              _buildHeaderLink('Marked Proposal'),
              _buildHeaderLink('About Us'),
            ],
          ),

          // Search Bar
          Container(
            width: 300,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F6F7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search, color: Color(0xFFADB8CC), size: 20),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Search Transactions and Documents',
                    style: TextStyle(
                      color: Color(0xFFADB8CC),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // User Profile and Icons
          Row(
            children: [
              const Text(
                'Clayton Santos',
                style: TextStyle(
                  color: Color(0xFF6B7A99),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 15),
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F0FE),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.person,
                  color: Color(0xFF2B55E5),
                  size: 20,
                ),
              ),
              const SizedBox(width: 15),
              Stack(
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.notifications_none,
                      color: Color(0xFF6B7A99),
                      size: 20,
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE62E7B),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.settings,
                  color: Color(0xFF6B7A99),
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderLink(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF7D8FB3),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class RecentOperationsList extends StatelessWidget {
  const RecentOperationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            height: 65,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Color(0xFFF5F6F7),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 18),
                  onPressed: () {},
                ),
                const Text(
                  'Complaints',
                  style: TextStyle(
                    color: Color(0xFF2B55E5),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),

          // Operations List with Scrolling
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: 8,
              itemBuilder: (context, index) {
                final operations = [
                  {
                    'title': 'Return Fee ',
                    'color': const Color(0xFF106E33),
                    'status': const Color(0xFFFA0000)
                  },
                  {
                    'title': 'Rate Card',
                    'color': const Color(0xFF3360FF),
                    'status': const Color(0xFFFEC53D)
                  },
                  {
                    'title': 'Unfair Rating',
                    'color': const Color(0xFFC5C7CC),
                    'status': const Color(0xFFFA0000)
                  },
                  {
                    'title': 'Fee Breakdown',
                    'color': const Color(0xFFFFCB33),
                    'status': const Color(0xFF00B69B)
                  },
                  {
                    'title': 'SLA Penalities',
                    'color': const Color(0xFF8833FF),
                    'status': const Color(0xFF00B69B)
                  },
                  {
                    'title': 'Listing Rejection',
                    'color': const Color(0xFF3360FF),
                    'status': const Color(0xFFFEC53D)
                  },
                ];

                final operation = operations[index % operations.length];
                return _buildOperationItem(
                  context: context,
                  color: operation['color'] as Color,
                  title: operation['title'] as String,
                  statusColor: operation['status'] as Color,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOperationItem({
    required BuildContext context,
    required Color color,
    required String title,
    required Color statusColor,
  }) {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFF5F6F7),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Icon/Color Circle
          Container(
            width: 35,
            height: 35,
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
          ),

          // Title
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF2B55E5),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Status Indicator
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
          ),

          // Action Icons
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.grey),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ReturnFeeScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class AdditionalInfoSection extends StatelessWidget {
  const AdditionalInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Progress Section
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Progress',
                  style: TextStyle(
                    color: Color(0xFF2B55E5),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                _buildProgressItem(
                  name: 'Keran Dairy',
                  percentage: '1.3%',
                  isDecrease: true,
                  refreshCount: 2,
                  trendingCount: 2,
                  hasProfileImage: true,
                ),
                const SizedBox(height: 15),
                _buildProgressItem(
                  name: 'Caly Clothes',
                  percentage: '1.8',
                  isDecrease: true,
                  refreshCount: 3,
                  trendingCount: 3,
                  hasProfileImage: true,
                  avatarColor: const Color(0xFF6366F1),
                ),
                const SizedBox(height: 15),
                _buildProgressItem(
                  name: 'JAMBO Books',
                  percentage: '2.7',
                  isDecrease: true,
                  refreshCount: 3,
                  trendingCount: 31,
                  hasProfileImage: true,
                  avatarColor: const Color(0xFF6366F1),
                ),
              ],
            ),
          ),

          // Divider
          Container(
            height: 1,
            color: const Color(0xFFF5F6F7),
          ),

          // Statistics Section
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Statistics',
                  style: TextStyle(
                    color: Color(0xFF2B55E5),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatisticItem(
                        'Total Proposals', '156', const Color(0xFF28CC38)),
                    _buildStatisticItem(
                        'Approved', '98', const Color(0xFF3360FF)),
                    _buildStatisticItem(
                        'Pending', '42', const Color(0xFFFFCB33)),
                    _buildStatisticItem(
                        'Rejected', '16', const Color(0xFFFA0000)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressItem({
    required String name,
    required String percentage,
    required bool isDecrease,
    required int refreshCount,
    required int trendingCount,
    required bool hasProfileImage,
    Color? avatarColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          // Profile Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: avatarColor ?? Colors.grey[300],
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: hasProfileImage
                ? ClipOval(
                    child: Container(
                      color: Colors.brown[200],
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  )
                : const Icon(
                    Icons.business,
                    color: Colors.white,
                    size: 20,
                  ),
          ),

          const SizedBox(width: 12),

          // Company Name
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF374151),
              ),
            ),
          ),

          // Percentage with trend
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isDecrease ? Colors.red[50] : Colors.green[50],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  percentage,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDecrease ? Colors.red[600] : Colors.green[600],
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  isDecrease ? Icons.trending_down : Icons.trending_up,
                  size: 12,
                  color: isDecrease ? Colors.red[600] : Colors.green[600],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Refresh Icon with count
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.refresh,
                  size: 14,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  '$refreshCount',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 6),

          // Trending Icon with count
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.trending_up,
                  size: 14,
                  color: Colors.green[600],
                ),
                const SizedBox(width: 4),
                Text(
                  '$trendingCount',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.green[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF7D8FB3),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class RightSidebar extends StatelessWidget {
  const RightSidebar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
      ),
      child: Column(
        children: [
          // Profile Section
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Profile Picture with Online Status
                Stack(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF6C5CE7),
                          width: 3,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/profile.jpg', // Replace with your image path
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[200],
                              child: const Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6B6B),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.circle,
                            color: Colors.white,
                            size: 8,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Name
                const Text(
                  'Clayton Santos',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3748),
                  ),
                ),
                const SizedBox(height: 4),
                // Role or Email (optional)
                Text(
                  'Product Designer',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Settings Section
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 16, bottom: 8),
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                _buildSettingsItem(
                  icon: Icons.person_outline,
                  title: 'Personal Information',
                  isFirst: true,
                ),
                _buildSettingsItem(
                  icon: Icons.description_outlined,
                  title: 'Documents and References',
                ),
                _buildSettingsItem(
                  icon: Icons.security_outlined,
                  title: 'Security & Data',
                ),
                _buildSettingsItem(
                  icon: Icons.settings_outlined,
                  title: 'Account settings',
                  isLast: true,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Logout Button
          Container(
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFFF6B6B),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  // Handle logout
                },
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout,
                        color: Color(0xFFFF6B6B),
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Logout',
                        style: TextStyle(
                          color: Color(0xFFFF6B6B),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Container(
      margin: EdgeInsets.only(
        left: 8,
        right: 8,
        bottom: isLast ? 12 : 0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // Handle settings item tap
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    size: 18,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
