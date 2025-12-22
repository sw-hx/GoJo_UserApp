import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RectangleImageTextField extends StatefulWidget {
  final File? image;
  final Function(File?) onChanged;

  const RectangleImageTextField({
    super.key,
    required this.image,
    required this.onChanged,
  });

  @override
  State<RectangleImageTextField> createState() =>
      _RectangleImageTextFieldState();
}

class _RectangleImageTextFieldState extends State<RectangleImageTextField> {
  bool isLoading = false;

  Future<void> pickImage() async {
    setState(() => isLoading = true);

    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      widget.onChanged(File(picked.path));
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final double width = 300.w;
    final double height = 180.h;

    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onTap: pickImage,
        child: Stack(
          children: [
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.black, width: 2.w),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: widget.image != null
                    ? Image.file(
                  widget.image!,
                  fit: BoxFit.cover,
                )
                    : Center(
                  child: Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 48.sp,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            if (widget.image != null)
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () => widget.onChanged(null),
                  child: Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.delete,
                      size: 22.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
