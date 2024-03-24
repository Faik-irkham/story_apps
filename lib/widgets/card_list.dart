import 'package:flutter/material.dart';
import 'package:story_apps/data/model/list_story_model.dart';

class CardListStory extends StatelessWidget {
  final ListStoryModel stories;
  const CardListStory({
    super.key,
    required this.stories,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          Container(
            height: 280,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              image: DecorationImage(
                image: NetworkImage(stories.photoUrl!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 5,
            ),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stories.name!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${stories.description!.split(' ').take(10).join(' ')}...',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
