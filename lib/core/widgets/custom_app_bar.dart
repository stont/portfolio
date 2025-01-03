// lib/core/widgets/custom_app_bar.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showBackButton = true,
    this.actions,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.background,
      leading: showBackButton
          ? IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: Theme.of(context).colorScheme.primary,
        ),
        onPressed: () => Navigator.pop(context),
      )
          : null,
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        if (actions != null) ...actions!,
        IconButton(
          icon: Icon(
            Provider.of<ThemeProvider>(context).isDarkMode
                ? Icons.light_mode
                : Icons.dark_mode,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
