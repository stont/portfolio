// lib/screens/contact/widgets/contact_form.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/services/email_service.dart';
import '../models/contact_purpose.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _messageController;
  ContactPurpose? _selectedPurpose;
  bool _isLoading = false;
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _messageController = TextEditingController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (value.replaceAll(RegExp(r'[^0-9]'), '').length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
  final EmailService _emailService = EmailService();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && _selectedPurpose != null) {
      setState(() => _isLoading = true);

      try {
        await _emailService.sendEmail(
          name: _nameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          message: _messageController.text,
          purpose: _selectedPurpose!.display,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Message sent successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          _formKey.currentState!.reset();
          _nameController.clear();
          _emailController.clear();
          _phoneController.clear();
          _messageController.clear();
          setState(() => _selectedPurpose = null);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Card(
        elevation: 8,
        shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.surface,
                Theme.of(context).colorScheme.surface.withOpacity(0.8),
              ],
            ),
          ),
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Send Message',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                _buildFormField(
                  controller: _nameController,
                  label: 'Name',
                  icon: Icons.person_outline,
                  keyboardType: TextInputType.name,
                  autocompleteHint: AutofillHints.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildFormField(
                  controller: _emailController,
                  label: 'Email',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  autocompleteHint: AutofillHints.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildFormField(
                  controller: _phoneController,
                  label: 'Phone',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  autocompleteHint: AutofillHints.telephoneNumber,
                  validator: _validatePhone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    _PhoneNumberFormatter(),
                  ],
                ),

                const SizedBox(height: 16),
                _buildPurposeDropdown(),
                const SizedBox(height: 16),
                _buildFormField(
                  controller: _messageController,
                  label: 'Message',
                  icon: Icons.message_outlined,
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your message';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                      : const Text('Send Message'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    int maxLines = 1,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
    String? autocompleteHint,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
      ),
      maxLines: maxLines,
      validator: validator,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      autocorrect: false,
      enableSuggestions: true,
      autofillHints: autocompleteHint != null ? [autocompleteHint] : null,
    );
  }

  Widget _buildPurposeDropdown() {
    return DropdownButtonFormField<ContactPurpose>(
      value: _selectedPurpose,
      decoration: InputDecoration(
        labelText: 'Purpose',
        prefixIcon: const Icon(Icons.category_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
      ),
      items: ContactPurpose.values.map((purpose) {
        return DropdownMenuItem(
          value: purpose,
          child: Text(purpose.display),
        );
      }).toList(),
      onChanged: (value) {
        setState(() => _selectedPurpose = value);
      },
      validator: (value) {
        if (value == null) {
          return 'Please select a purpose';
        }
        return null;
      },
    );
  }
}

class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Only allow digits
    var numericValue = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // Limit to 10 digits
    if (numericValue.length > 11) {
      numericValue = numericValue.substring(0, 11);
    }

    var newText = '';
    var selectionIndex = numericValue.length;

    // Format: XXX-XXX-XXXX
    for (var i = 0; i < numericValue.length; i++) {
      if (i == 3 || i == 6) {
        newText += '-';
        if (newValue.selection.baseOffset > i) {
          selectionIndex++;
        }
      }
      newText += numericValue[i];
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}