import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CircularImageTextField extends StatefulWidget {
  final File? image;
  final Function(File?) onChanged;

  const CircularImageTextField({
    super.key,
    required this.image,
    required this.onChanged,
  });

  @override
  State<CircularImageTextField> createState() => _CircularImageTextFieldState();
}

class _CircularImageTextFieldState extends State<CircularImageTextField> {
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
    final double size = 160.w;

    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onTap: pickImage,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2.w),
              ),
              child: ClipOval(
                child: widget.image != null
                    ? Image.file(
                  widget.image!,
                  fit: BoxFit.cover,
                )
                    : Center(
                  child: Icon(
                    Icons.add_a_photo_outlined,
                    size: 40.sp,
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
                      size: 23.sp,
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
