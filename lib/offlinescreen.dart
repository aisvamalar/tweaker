import 'package:flutter/material.dart';
import 'models.dart';
import 'ReturnFeeSpeedometer.dart';

class OfflineScreen extends StatefulWidget {
  final CompanyInfo? companyInfo;

  const OfflineScreen({Key? key, this.companyInfo}) : super(key: key);

  @override
  _OfflineScreenState createState() => _OfflineScreenState();
}

class _OfflineScreenState extends State<OfflineScreen> {
  String selectedTab = 'Offline reach';

  // Sample shop data - this could be passed from the return fee dashboard
  final List<ShopData> shops = [
    ShopData(
      name: "Hyms Deal",
      daysAgo: "2 days before",
      returnFee: 8.6,
      companyInfo: CompanyInfo(
        name: "Hyms Deal",
        location: "Hyderabad, Karnataka, India",
        branches: 4,
        industryType: "Accessories",
        ownerName: "John",
        trustRate: 4.5,
        establishedDate: "01/03/2015",
        seats: 50,
        registerId: "12345ABCDEF",
        gstNumber: "27ABCDE1234F1Z5",
        description:
            "Hyms Deal Pvt. Ltd. specializes in designing and selling high-quality men's pants and belts, offering stylish and durable products for customers across various markets.",
      ),
    ),
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
  ];

  @override
  Widget build(BuildContext context) {
    // Use the provided companyInfo or default to the first shop
    CompanyInfo currentCompany = widget.companyInfo ?? shops.first.companyInfo;

    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      body: Column(
        children: [
          // Enhanced Header
          _buildHeader(),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumb Navigation
                  _buildBreadcrumb(),

                  SizedBox(height: 40),

                  // Tab Navigation
                  _buildTabNavigation(),

                  SizedBox(height: 40),

                  // Main Content Container
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 20,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Company Header Section
                          _buildCompanyHeader(currentCompany),

                          SizedBox(height: 50),

                          // Company Information Section
                          _buildCompanyInformation(currentCompany),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo Section
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

          // Navigation Links
          Row(
            children: [
              _buildNavButton('Complaints viewed'),
              _buildNavButton('Complaints Solved'),
              _buildNavButton('Marked Complaints'),
              _buildNavButton('About Us'),
              SizedBox(width: 16),
              Text('...',
                  style: TextStyle(color: Colors.grey[400], fontSize: 18)),
            ],
          ),

          SizedBox(width: 32),

          // Search Bar
          Container(
            width: 320,
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              children: [
                SizedBox(width: 16),
                Icon(Icons.search, color: Colors.grey[500], size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Transactions and Documents',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 24),

          // User Section
          Row(
            children: [
              Text(
                'Clayton Santos',
                style: TextStyle(
                  color: Color(0xFF6B7A99),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 16),
              CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xFFE8F0FE),
                child: Icon(
                  Icons.person,
                  color: Color(0xFF6C7CE7),
                  size: 18,
                ),
              ),
              SizedBox(width: 16),
              Stack(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.notifications_none,
                      color: Color(0xFF6B7A99),
                      size: 18,
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
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
              SizedBox(width: 12),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.more_vert,
                  color: Color(0xFF6B7A99),
                  size: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBreadcrumb() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Text(
            'Dashboard',
            style: TextStyle(
              color: Color(0xFF6C7CE7),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          ' > ',
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Text(
            'Return Fee',
            style: TextStyle(
              color: Color(0xFF6C7CE7),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          ' > ',
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
        ),
        Text(
          'Company details',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildTabNavigation() {
    return Row(
      children: [
        _buildTab('Online reach'),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          height: 20,
          width: 1,
          color: Colors.grey[300],
        ),
        _buildTab('Offline reach'),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          height: 20,
          width: 1,
          color: Colors.grey[300],
        ),
        _buildTab('Summary'),
      ],
    );
  }

  Widget _buildCompanyHeader(CompanyInfo company) {
    return Row(
      children: [
        // Company Logo
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4A4A4A), Color(0xFF2D2D2D)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Center(
            child: Text(
              company.name.substring(0, 2).toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),

        SizedBox(width: 24),

        // Company Info
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              company.name,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 8),
            Text(
              company.location,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCompanyInformation(CompanyInfo company) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Company Information',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        SizedBox(height: 32),

        // Information Grid
        Wrap(
          spacing: 60,
          runSpacing: 32,
          children: [
            _buildInfoField('Number of Branches', '${company.branches}'),
            _buildInfoField('Industry type', company.industryType),
            _buildInfoField('Owner name', company.ownerName),
            _buildInfoField('Trust Rate', '${company.trustRate}'),
            _buildInfoField('Established Date', company.establishedDate),
            _buildInfoField('No.of seats', '${company.seats}'),
            _buildInfoField('Register Id/License No', company.registerId),
            _buildInfoField('Gst Number', company.gstNumber),
          ],
        ),

        SizedBox(height: 40),

        // Company Description
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Company Description',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12),
            Text(
              company.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Container(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(String text) {
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

  Widget _buildTab(String text) {
    bool isSelected = selectedTab == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = text;
        });

        if (text == 'Online reach') {
          Navigator.pop(
              context); // Go back to previous screen or handle online navigation
        } else if (text == 'Summary') {
          Navigator.pop(context); // Go back to summary/company details
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.grey[500],
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}
