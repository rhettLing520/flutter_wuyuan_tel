import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constants/common_export.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    super.key,
    this.title,
    this.titleText,
    this.actions,
    this.backgroundColor,
    this.centerTitle = true,
    this.leading,
    this.automaticallyImplyLeading = true,
  });

  final Widget? title;
  final String? titleText;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final bool centerTitle;
  final Widget? leading;
  final bool automaticallyImplyLeading;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();

    return AppBar(
      title: title ??
          (titleText != null
              ? AppText(
                  titleText!,
                  fontSize: 18.sp,
                  fontWeight: AppFontWeights.medium,
                  color: AppColors.textPrimary,
                )
              : null),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? AppColors.background,
      elevation: 0,
      leading: leading ??
          (automaticallyImplyLeading && canPop
              ? GestureDetector(
                  onTap: () => Get.back(),
                  behavior: HitTestBehavior.opaque,
                  child: SizedBox(
                    width: 80.w,
                    height: 44.h,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.w),
                        child: AppImage(
                          imagePath: AppImages.getAssetsPath('back'),
                          width: 24.w,
                          height: 24.w,
                        ),
                      ),
                    ),
                  ),
                )
              : null),
      actions: actions,
    );
  }
}
