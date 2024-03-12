import 'package:flutter/material.dart';

class CardListStory extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String description;
  const CardListStory({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Center(
              child: Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
