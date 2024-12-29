import 'package:flutter/material.dart';
import 'package:movie_marks/config/theme/app_images.dart';

class CustomAvatar extends StatelessWidget {
  final String url;
  final bool isLive;
  final double width;
  final double height;
  final double radius;

  const CustomAvatar({
    super.key,
    required this.url,
    this.isLive = false,
    required this.width,
    required this.height,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isLive ? Colors.red : Colors.transparent,
          width: 3.0,
        ),
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundImage: url.isNotEmpty
            ? NetworkImage(url)
            : AssetImage(AppImages.defaultAvatar.webpAssetPath),
      ),
    );
  }
}
