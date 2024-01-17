import 'package:flutter/material.dart';

// This is for each item in the Drawer
class DrawerItem extends StatelessWidget {
  final bool selected;
  final int? number;
  final IconData icon;
  final String title;
  final VoidCallback onPressed;
  const DrawerItem(
      {super.key,
      this.selected = false,
      this.number,
      required this.icon,
      required this.title,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: (selected)
                ? Theme.of(context).primaryColor.withOpacity(0.9)
                : Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: InkWell(
              onTap: onPressed,
              child: Row(
                children: [
                  SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 15, right: 5),
                      child: Row(
                        children: [
                          Icon(
                            icon,
                            color: (selected)
                                ? Colors.white
                                : Theme.of(context).iconTheme.color,
                          ),
                          SizedBox(width: 10),
                          Text(
                            title,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: (selected)
                                          ? Colors.white
                                          : Colors.black.withOpacity(0.5),
                                    ),
                          ),
                          Spacer(),
                          if (number != null)
                            Badge(label: Text(number.toString()))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider()
      ],
    );
  }
}
