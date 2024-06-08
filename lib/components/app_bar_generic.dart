import 'package:flutter/material.dart';

class AppBarGeneric extends StatelessWidget {
  const AppBarGeneric({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // height: preferredSize.height + 100,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const ShapeDecoration(
              color: Color(0xFFD9D9D9),
              shape: OvalBorder(),
            ),
          ),
          const SizedBox(
            width: 11,
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bom dia 👋',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF74778B),
                  fontSize: 14,
                  fontFamily: 'Avenir',
                  fontWeight: FontWeight.w400,
                  height: 0.10,
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Fábio Baziota',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Avenir',
                  fontWeight: FontWeight.w500,
                  height: 0.08,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
