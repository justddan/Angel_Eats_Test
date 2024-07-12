import 'package:angel_eats_test/constants/gaps.dart';
import 'package:flutter/material.dart';

class EditListItem extends StatelessWidget {
  const EditListItem({
    super.key,
    required this.title,
    this.subtitleWidget,
    this.contentWidget,
  });

  final String title;
  final Widget? subtitleWidget;
  final Widget? contentWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitleWidget ?? Container(),
            ],
          ),
          Row(
            children: [
              // Text("닉네임"),
              contentWidget ?? Container(),
              Gaps.h5,
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
              ),
            ],
          )
        ],
      ),
    );
  }
}
