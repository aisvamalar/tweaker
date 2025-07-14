
// models.dart
class ShopData {
  final String name;
  final String daysAgo;
  final double returnFee;
  final CompanyInfo companyInfo;

  ShopData({
    required this.name,
    required this.daysAgo,
    required this.returnFee,
    required this.companyInfo,
  });
}

class CompanyInfo {
  final String name;
  final String location;
  final int branches;
  final String industryType;
  final String ownerName;
  final double trustRate;
  final String establishedDate;
  final int seats;
  final String registerId;
  final String gstNumber;
  final String description;

  CompanyInfo({
    required this.name,
    required this.location,
    required this.branches,
    required this.industryType,
    required this.ownerName,
    required this.trustRate,
    required this.establishedDate,
    required this.seats,
    required this.registerId,
    required this.gstNumber,
    required this.description,
  });
}