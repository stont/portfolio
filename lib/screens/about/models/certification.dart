// lib/screens/about/models/certification.dart
class Certification {
  final String name;
  final String issuedBy;
  final String issuedDate;
  final String credentialUrl;
  final String? imageUrl; // Make optional
  final String description;

  const Certification({
    required this.name,
    required this.issuedBy,
    required this.issuedDate,
    required this.credentialUrl,
    this.imageUrl, // Optional field
    required this.description,
  });
}