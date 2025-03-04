import 'package:flutter/material.dart';

import '../models/post.dart';

class IparkPostTile extends StatelessWidget {
  final Post post;

  const IparkPostTile({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // 2
        // CircleImage(
        //   imageProvider: AssetImage(post.profileImageUrl),
        //   imageRadius: 20,
        // ),
        // 3
        const SizedBox(width: 16),
        // 4
        Expanded(
          // 5
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 6
              Text(post.name),
              // 7
              Text(
                '${post.distance}',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
