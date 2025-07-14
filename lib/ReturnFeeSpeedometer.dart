import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'models.dart';
import 'CompanyDetailsScreen.dart';

class ReturnFeeScreen extends StatefulWidget {
  @override
  _ReturnFeeScreenState createState() => _ReturnFeeScreenState();
}

class _ReturnFeeScreenState extends State<ReturnFeeScreen>
    with TickerProviderStateMixin {
  late AnimationController _speedometerController;
  late Animation<double> _speedometerAnimation;

  final List<ShopData> shops = [
    ShopData(
      name: "Suns Bath",
      daysAgo: "2 days before",
      returnFee: 2.5,
      companyInfo: CompanyInfo(
        name: "Suns Bath",
        location: "Hyderabad, Karnataka, India",
        branches: 3,
        industryType: "Bath & Body",
        ownerName: "Rajesh",
        trustRate: 4.2,
        establishedDate: "15/05/2018",
        seats: 25,
        registerId: "12345BATH",
        gstNumber: "27ABCDE1234F1Z5",
        description:
            "Suns Bath Pvt. Ltd. specializes in premium bath and body products.",
      ),
    ),
    ShopData(
      name: "Leo's Footwear",
      daysAgo: "2 days before",
      returnFee: 3.5,
      companyInfo: CompanyInfo(
        name: "Leo's Footwear",
        location: "Hyderabad, Karnataka, India",
        branches: 6,
        industryType: "Footwear",
        ownerName: "Leo Kumar",
        trustRate: 4.1,
        establishedDate: "22/08/2016",
        seats: 40,
        registerId: "12345FOOT",
        gstNumber: "27ABCDE1234F2Z5",
        description:
            "Leo's Footwear Pvt. Ltd. specializes in high-quality footwear.",
      ),
    ),
    ShopData(
      name: "Ginger Gadgets",
      daysAgo: "2 days before",
      returnFee: 2.3,
      companyInfo: CompanyInfo(
        name: "Ginger Gadgets",
        location: "Hyderabad, Karnataka, India",
        branches: 8,
        industryType: "Electronics",
        ownerName: "Priya",
        trustRate: 4.6,
        establishedDate: "10/12/2019",
        seats: 60,
        registerId: "12345GADG",
        gstNumber: "27ABCDE1234F3Z5",
        description:
            "Ginger Gadgets Pvt. Ltd. specializes in innovative electronic gadgets.",
      ),
    ),
    ShopData(
      name: "Kitchen of Kumar",
      daysAgo: "2 days before",
      returnFee: 7.0,
      companyInfo: CompanyInfo(
        name: "Kitchen of Kumar",
        location: "Hyderabad, Karnataka, India",
        branches: 5,
        industryType: "Kitchen Appliances",
        ownerName: "Kumar",
        trustRate: 4.3,
        establishedDate: "05/03/2017",
        seats: 35,
        registerId: "12345KITCH",
        gstNumber: "27ABCDE1234F4Z5",
        description:
            "Kitchen of Kumar Pvt. Ltd. specializes in kitchen appliances.",
      ),
    ),
    ShopData(
      name: "Goodiesss",
      daysAgo: "2 days before",
      returnFee: 4.1,
      companyInfo: CompanyInfo(
        name: "Goodiesss",
        location: "Hyderabad, Karnataka, India",
        branches: 4,
        industryType: "Fashion",
        ownerName: "Anitha",
        trustRate: 4.0,
        establishedDate: "18/09/2020",
        seats: 30,
        registerId: "12345GOOD",
        gstNumber: "27ABCDE1234F5Z5",
        description:
            "Goodiesss Pvt. Ltd. specializes in trendy fashion apparel.",
      ),
    ),
    ShopData(
      name: "FUNRALDO",
      daysAgo: "2 days before",
      returnFee: 3.2,
      companyInfo: CompanyInfo(
        name: "FUNRALDO",
        location: "Hyderabad, Karnataka, India",
        branches: 7,
        industryType: "Entertainment",
        ownerName: "Ravi",
        trustRate: 4.4,
        establishedDate: "12/07/2015",
        seats: 45,
        registerId: "12345FUNR",
        gstNumber: "27ABCDE1234F6Z5",
        description:
            "FUNRALDO Pvt. Ltd. specializes in entertainment products.",
      ),
    ),
  ];

  ShopData? selectedShop; // No default company - start with null

  @override
  void initState() {
    super.initState();
    _speedometerController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _speedometerAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _speedometerController,
      curve: Curves.easeInOut,
    ));

    // Start with no selected company - blank proposals
    selectedShop = null;

    _speedometerController.forward();
  }

  @override
  void dispose() {
    _speedometerController.dispose();
    super.dispose();
  }

  String _getShortProposalContent(String companyName) {
    return '''Subject: Advocacy Report: Seller Loss Alert – Policy Reform Recommendation

⸻

Dear [Recipient's Name],

I'm writing to formally escalate a seller advocacy issue based on a detailed operational loss analysis for $companyName. Please find below the report for your review and action:

This seller is experiencing significant financial losses due to:
• Selling price lower than cost
• High return handling fees
• Return fees charged regardless of seller fault
• Festival-based pricing pressure

The company requires immediate policy reform assistance to maintain sustainable operations while delivering quality service to customers.

⸻

End of Summary

For detailed analysis and recommendations, please click "More info" below.''';
  }

  Widget _buildMenuButton(String title, bool isActive) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: isActive ? Colors.blue[50] : Colors.transparent,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.blue[700] : Colors.grey[600],
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        title: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: math.max(constraints.maxWidth, 1200),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // TWEAKER Logo
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
                    SizedBox(width: 30),
                    // Navigation Menu
                    _buildMenuButton('Complaints viewed', false),
                    _buildMenuButton('Complaints Solved', false),
                    _buildMenuButton('Marked Complaints', false),
                    _buildMenuButton('About Us', false),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        '...',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    // Search Bar
                    Container(
                      width: 300,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.grey[300]!, width: 1),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search Transactions and Documents',
                          hintStyle:
                              TextStyle(color: Colors.grey[500], fontSize: 14),
                          prefixIcon: Icon(Icons.search,
                              color: Colors.grey[500], size: 20),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    // User Profile Section
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Clayton Santos',
                          style: TextStyle(
                            color: Color(0xFF6B7A99),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 15),
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Color(0xFFE8F0FE),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(Icons.person,
                              color: Color(0xFF2B55E5), size: 20),
                        ),
                        SizedBox(width: 15),
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
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(Icons.notifications_none,
                                  color: Color(0xFF6B7A99), size: 20),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE62E7B),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
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
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(Icons.settings,
                              color: Color(0xFF6B7A99), size: 20),
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumb
            Padding(
              padding: EdgeInsets.only(left: 10, bottom: 20),
              child: Text(
                'Dashboard > Return Fee',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                ),
              ),
            ),
            // Main Content
            Expanded(
              child: Row(
                children: [
                  // Left Side - Speedometer and Company List
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        // Speedometer Section
                        Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'RETURN FEE',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                height: 200,
                                width: 300,
                                child: AnimatedBuilder(
                                  animation: _speedometerAnimation,
                                  builder: (context, child) {
                                    return CustomPaint(
                                      painter: SemiCircleSpeedometerPainter(
                                          _speedometerAnimation.value),
                                      size: Size(300, 200),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        // Company List Section
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    padding: EdgeInsets.all(20),
                                    itemCount: shops.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.only(bottom: 15),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 12),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[50],
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: Colors.grey[200]!),
                                        ),
                                        child: Row(
                                          children: [
                                            // Green Truck Icon
                                            Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Icon(
                                                Icons.local_shipping,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                            SizedBox(width: 15),
                                            // Company Info
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    shops[index].name,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                  SizedBox(height: 2),
                                                  Text(
                                                    shops[index].daysAgo,
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Return Fee Percentage
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: Colors.red[50],
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.arrow_downward,
                                                    color: Colors.red,
                                                    size: 12,
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    '${shops[index].returnFee}%',
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            // Info Button
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedShop = shops[index];
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Icon(
                                                  Icons.info_outline,
                                                  color: Colors.grey[600],
                                                  size: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  // Right Side - Proposals
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Proposals Header
                          Container(
                            padding: EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey[200]!,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                // Proposal Icon
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.blue[800],
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Icon(
                                    Icons.description,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                                SizedBox(width: 20),
                                // Proposal Title
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Proposals',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        selectedShop?.companyInfo.name ??
                                            'Select a company',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Proposal Content
                          selectedShop != null
                              ? Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Advocacy Report Summary',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                          Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[50],
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: Colors.grey[200]!),
                                            ),
                                            child: Text(
                                              _getShortProposalContent(
                                                  selectedShop!
                                                      .companyInfo.name),
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[800],
                                                height: 1.5,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.description_outlined,
                                          size: 80,
                                          color: Colors.grey[300],
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          'Select a company to view proposals',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          // Action Buttons
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(color: Colors.grey[200]!)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: selectedShop != null
                                        ? () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      'Proposal Declined for ${selectedShop!.companyInfo.name}')),
                                            );
                                          }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 12),
                                    ),
                                    child: Text('Decline'),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: selectedShop != null
                                        ? () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      'Proposal Accepted for ${selectedShop!.companyInfo.name}')),
                                            );
                                          }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 12),
                                    ),
                                    child: Text('Accept'),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: selectedShop != null
                                        ? () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CompanyDetailsScreen(
                                                  companyInfo:
                                                      selectedShop!.companyInfo,
                                                ),
                                              ),
                                            );
                                          }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 12),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                          child: Text('More info',
                                              textAlign: TextAlign.center),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.info,
                                            color: Colors.blue,
                                            size: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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

class SemiCircleSpeedometerPainter extends CustomPainter {
  final double progress;

  SemiCircleSpeedometerPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height - 20);
    final radius = math.min(size.width, size.height * 2) / 2 - 20;

    // Draw background arc
    final backgroundPaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi,
      false,
      backgroundPaint,
    );

    // Draw gradient progress arc
    final colors = [
      Colors.lightBlue[300]!,
      Colors.blue[400]!,
      Colors.blue[600]!,
      Colors.blue[800]!,
    ];

    for (int i = 0; i < colors.length; i++) {
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = 20
        ..strokeCap = StrokeCap.round;

      final startAngle = math.pi + (i * math.pi / colors.length);
      final sweepAngle = (math.pi / colors.length) * progress;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }

    // Draw needle
    final needlePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 4;

    final needleAngle = math.pi + (math.pi * progress * 0.7);
    final needleLength = radius - 10;

    canvas.drawLine(
      center,
      Offset(
        center.dx + needleLength * math.cos(needleAngle),
        center.dy + needleLength * math.sin(needleAngle),
      ),
      needlePaint,
    );

    // Draw center circle
    canvas.drawCircle(center, 10, Paint()..color = Colors.black);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
