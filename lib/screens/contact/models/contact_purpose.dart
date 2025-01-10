// lib/screens/contact/models/contact_purpose.dart
enum ContactPurpose {
  mobileApp('Mobile App Development'),
  website('Website Development'),
  consultation('Technical Consultation'),
  training('Flutter Training'),
  paperless('Paperless Solutions'),
  feedback('Feedback'),
  inquiry('General Inquiry');

  final String display;
  const ContactPurpose(this.display);
}

// lib/screens/contact/models/contact_form_data.dart
class ContactFormData {
  final String name;
  final String email;
  final String phone;
  final ContactPurpose purpose;
  final String message;

  ContactFormData({
    required this.name,
    required this.email,
    required this.phone,
    required this.purpose,
    required this.message,
  });
}