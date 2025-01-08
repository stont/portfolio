// lib/screens/services/widgets/service_card.dart
import 'package:flutter/material.dart';
import '../models/service.dart';

class ServiceCard extends StatefulWidget {
  final Service service;
  final VoidCallback onTap;

  const ServiceCard({
    Key? key,
    required this.service,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
          child: Card(
            elevation: _isHovered ? 8 : 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon and Title
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          _getIconData(widget.service.title),
                          size: 24,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          widget.service.title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Description
                  Expanded(
                    child: Text(
                      widget.service.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: isSmallScreen ? 13 : 14,
                      ),
                      maxLines: isSmallScreen ? 3 : 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Features Preview
                  Container(
                    height: isSmallScreen ? 40 : 48,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: widget.service.features.take(3).map((feature) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Chip(
                            label: Text(
                              feature,
                              style: TextStyle(
                                fontSize: isSmallScreen ? 11 : 12,
                              ),
                            ),
                            padding: const EdgeInsets.all(4),
                            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIconData(String title) {
    switch (title.toLowerCase()) {
      case 'mobile app development':
        return Icons.phone_android_outlined;
      case 'web development':
        return Icons.web_outlined;
      case 'ui/ux design with flutter':
        return Icons.design_services_outlined;
      case 'e-commerce solutions':
        return Icons.shopping_cart_outlined;
      case 'technical consultation':
        return Icons.engineering_outlined;
      case 'technology advocacy':
        return Icons.record_voice_over_outlined;
      default:
        return Icons.code_outlined;
    }
  }
}