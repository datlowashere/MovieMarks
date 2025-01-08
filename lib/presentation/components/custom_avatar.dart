import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_marks/config/theme/app_images.dart';

class CustomAvatar extends StatefulWidget {
  final String url;
  final bool isLive;
  final double width;
  final double height;
  final double radius;
  final VoidCallback? onTap;

  const CustomAvatar({
    super.key,
    required this.url,
    this.isLive = false,
    required this.width,
    required this.height,
    required this.radius,
    this.onTap,
  });

  @override
  State<CustomAvatar> createState() => _CustomAvatarState();
}

class _CustomAvatarState extends State<CustomAvatar>
    with AutomaticKeepAliveClientMixin<CustomAvatar> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.isLive ? Colors.red : Colors.transparent,
            width: 3.0,
          ),
        ),
        child: ClipOval(
          child: widget.url.isNotEmpty
              ? Image.network(
                  widget.url,
                  width: widget.width,
                  height: widget.height,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    AppImages.defaultAvatar.webpAssetPath,
                    fit: BoxFit.cover,
                  ),
                )
              : SvgPicture.asset(
                  AppImages.defaultAvatar.pngAssetPath,
                  width: widget.width,
                  height: widget.height,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
