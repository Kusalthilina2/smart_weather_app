import 'package:flutter/material.dart';
import '../constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(gradient: AppColors.gradient),
      ),
      elevation: 2,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
