import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/config/theme/app_icons.dart';
import 'package:movie_marks/config/theme/app_images.dart';

class AvatarPicker extends StatefulWidget {
  final File? imageLocal;
  final String url;
  final bool isLive;
  final double width;
  final double height;
  final double radius;
  final VoidCallback? onTap;

  const AvatarPicker({
    super.key,
    required this.url,
    this.isLive = false,
    required this.width,
    required this.height,
    required this.radius,
    this.onTap,
    this.imageLocal,
  });

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
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
              child: widget.imageLocal == null && widget.url.isEmpty
                  ? Image.asset(
                      AppImages.defaultAvatar.webpAssetPath,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                    )
                  : widget.imageLocal != null
                      ? Image.file(
                          widget.imageLocal!,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          widget.url,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              AppImages.defaultAvatar.webpAssetPath,
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 5,
            child: Container(
              width: 32,
              height: 32,
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: AppColors.brightGray,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                AppIcons.addCamera.svgAssetPath,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
