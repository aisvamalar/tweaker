import 'package:flutter/material.dart';
import 'models.dart';
import 'online_screen.dart';
import 'offlinescreen.dart';

class CompanyDetailsScreen extends StatefulWidget {
  final CompanyInfo companyInfo;

  const CompanyDetailsScreen({Key? key, required this.companyInfo})
      : super(key: key);

  @override
  _CompanyDetailsScreenState createState() => _CompanyDetailsScreenState();
}

class _CompanyDetailsScreenState extends State<CompanyDetailsScreen> {
  String selectedTab = 'Summary';

  String _getFullProposalContent() {
    return '''Subject: Advocacy Report: Seller Loss Alert – Policy Reform Recommendation

⸻

Dear [Recipient's Name],

I'm writing to formally escalate a seller advocacy issue based on a detailed operational loss analysis for ${widget.companyInfo.name}. Please find below the report for your review and action:

⸻

📝 Advocacy Report – Seller Loss Alert

⸻

1. ⚠️ Root Cause Summary
	•	✅ Selling price lower than cost
	•	✅ High return handling fee
	•	✅ Return fee charged regardless of seller fault
	•	✅ Festival-based pricing pressure
	•	⬜ No visibility on return reasons

These systemic issues have caused financial loss despite the seller maintaining quality and order fulfillment standards.

⸻

2. 📉 Loss Score Analysis
	•	Loss Score (0–10): 🔴 8.6 / 10
	•	Return Rate: 9.84%
	•	Price vs Cost Gap: -₹51.27
	•	Return Fee Impact (per unit): High
	•	Festival Risk Factor: Present

Interpretation:
A high-risk operational loss is detected, driven by platform pricing pressures, unfavorable return fee structures, and peak-season vulnerabilities.

⸻

3. 🛠️ Recommended Policy Reforms
	•	Return Fee Reform
→ Introduce reason-based return fee logic
→ Exempt sellers when returns are due to buyer-driven reasons (e.g. remorse)
	•	Trusted Seller Protection
→ Reward low-return sellers with reduced penalties
→ Flag consistent sellers for benefit tiers
	•	Minimum Margin Lock
→ Allow sellers to set a minimum margin floor to avoid underpricing
	•	Return Analytics Dashboard
→ Provide sellers visibility into reason-wise return breakdowns
→ Enable sellers to adjust listings, packaging, and inventory
	•	Smart Seller Badging System
→ Recognize top sellers with badges like "Zero Loss Champion" or "Low Return Seller"
→ Offer perks such as increased visibility, reduced fees, or advertising credits

⸻

4. 📦 Seller Quality & Strategic Value
	•	✅ High Product Ratings: Avg. 4.5+ stars across catalog
	•	✅ Low Return Incidence: Annual return rate consistently <6%, better than platform average
	•	✅ Seasonal Sales Powerhouse: Strong performance during New Year, Big Billion Days, and Diwali events
	•	✅ Reliable Logistics & Fulfillment: >97% on-time dispatch rate, negligible late delivery complaints
	•	✅ Veteran Seller: >2 years on Flipkart, compliant with listing and dispute resolution standards

🔐 Strategic Impact to Flipkart:
Supporting this seller ensures catalog diversity, fast-moving inventory, customer trust, and operational stability during key sales events.

⸻

5. 🤝 Trust-Based Partnership Statement

"Sellers are not just vendors – they're Flipkart's delivery arm and customer experience ambassadors."

This seller has demonstrated reliability, quality, and proactive compliance. With platform support, they can further reduce returns, sustain profitability, and enhance customer satisfaction.

Flipkart should evolve toward a mutually profitable ecosystem, ensuring responsible sellers are protected from structural policy constraints.

⸻

6. 📊 Seller Performance Summary
	•	Cost Price / Unit: ₹972.74
	•	Selling Price / Unit: ₹921.47
	•	Total Orders: 61
	•	Returns: 6
	•	Return Fee: ₹162.53
	•	Revenue Generated: ₹56,209.70
	•	Total Cost Incurred: ₹59,337.25
	•	Net Profit: ₹-3,290.08
	•	Profit Margin: -5.85%
	•	Festival Tag: 🎉 New Year

⸻

7. ✅ Final Recommendation (Summary)

Summary:
The seller is incurring a loss due to high return fees and forced underpricing, despite maintaining high-quality standards and reliable operations.

Action Requested:
Flipkart is urged to revise its return policies and introduce protective measures, allowing sellers to maintain sustainable margins while continuing to deliver exceptional service to customers.

⸻

End of Detailed Report''';
  }

  @override
  Widget build(BuildContext context) {
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
                          _buildCompanyHeader(),

                          SizedBox(height: 50),

                          // Detailed Advocacy Report Section
                          _buildDetailedProposalSection(),
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
          'Detailed Proposal',
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

  Widget _buildCompanyHeader() {
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
              'COMPANY',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
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
              widget.companyInfo.name,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 8),
            Text(
              widget.companyInfo.location,
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

  Widget _buildDetailedProposalSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detailed Advocacy Report',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        SizedBox(height: 32),

        // Proposal Content Container
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with document icon
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue[800],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Icon(
                      Icons.description,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Advocacy Report: Seller Loss Alert',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Policy Reform Recommendation for ${widget.companyInfo.name}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30),

              // Proposal Content
              SelectableText(
                _getFullProposalContent(),
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[800],
                  height: 1.6,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 40),

        // Action Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Proposal declined for ${widget.companyInfo.name}'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text('Decline Proposal'),
            ),
            SizedBox(width: 15),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Proposal accepted for ${widget.companyInfo.name}'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text('Accept Proposal'),
            ),
          ],
        ),
      ],
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OnlineScreen(),
            ),
          );
        } else if (text == 'Offline reach') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  OfflineScreen(companyInfo: widget.companyInfo),
            ),
          );
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
