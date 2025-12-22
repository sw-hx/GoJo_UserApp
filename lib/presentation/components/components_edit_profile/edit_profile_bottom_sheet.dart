import 'dart:io';

import 'package:flutter/material.dart';

import '../../../data/models/user_model.dart';
import 'image_text_field.dart';

class EditProfileBottomSheet extends StatefulWidget {
  final UserModel user;
  final Function(String name, File? image) onSave;

  const EditProfileBottomSheet({
    super.key,
    required this.user,
    required this.onSave,
  });

  @override
  State<EditProfileBottomSheet> createState() =>
      _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<EditProfileBottomSheet> {
  late TextEditingController nameController;
  File? selectedImage;

  @override
  void initState() {
    super.initState();
    nameController =
        TextEditingController(text: widget.user.personFullName);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Edit Profile",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(18, 54, 69, 1),
            ),
          ),

          const SizedBox(height: 25),

          ImageTextField(
            image: selectedImage,
            onChanged: (file) {
              setState(() => selectedImage = file);
            },
          ),

          const SizedBox(height: 25),

          Align(
            alignment: Alignment.centerLeft,
            child: const Text(
              "Full name",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ),

          const SizedBox(height: 6),

          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: "Enter your name",
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: () {
                if (nameController.text.trim().isEmpty) return;

                widget.onSave(
                  nameController.text.trim(),
                  selectedImage,
                );

                Navigator.pop(context);
              },
              child: const Text(
                "Save changes",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
