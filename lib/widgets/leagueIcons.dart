import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LeagueItem extends StatelessWidget {
  final String label;
  final IconData iconData;
  final bool isSelected;
  VoidCallback onTap;

  LeagueItem({
    super.key,
    required this.label,
    required this.iconData,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(4, 2, 12, 2),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 60,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFB6FF40) : Colors.white24,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: isSelected
                  ? const Color.fromARGB(255, 3, 3, 2)
                  : (isSelected ? Colors.black : Colors.white),
              size: 45,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
