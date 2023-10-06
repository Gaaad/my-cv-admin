import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/colors.dart';
import '../../business_logic/skills_controller.dart';

class SkillsItem extends StatelessWidget {
  SkillsItem({
    super.key,
    required this.title,
    required this.index,
    required this.image,
    required this.docId,
  });
  final String title;
  final int index;
  final String image;
  final String docId;

  final SkillsController skillsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        _deleteDialog(context);
      },
      child: ListTile(
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: MyColors.myYellow),
        ),
        leading: Text('$index'),
        trailing: FancyShimmerImage(
          imageUrl: image,
          boxFit: BoxFit.cover,
          width: 60,
        ),
      ),
    );
  }

  _deleteButton() async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('skills');

    await collection.doc(docId).delete().then((value) async {
      final Reference imageReference =
          FirebaseStorage.instance.ref().child('skills/$docId');

      await imageReference.delete();

      skillsController.getSkills();

      Get.back();
      Get.rawSnackbar(
        backgroundColor: Colors.green,
        message: 'Skill deleted successfully',
      );
    });
  }

  _deleteDialog(BuildContext context) {
    Get.defaultDialog(
      backgroundColor: MyColors.myDark.withOpacity(.8),
      radius: 10,
      title: 'Are you sure to delete?',
      titleStyle: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: MyColors.myYellow),
      content: Flexible(
        child: Text(
          'Are you sure to delete $title skill?',
          maxLines: 2,
          textAlign: TextAlign.justify,
        ),
      ),
      textConfirm: 'Delete',
      textCancel: 'Cancel',
      confirm: ElevatedButton(
        onPressed: _deleteButton,
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.red),
          foregroundColor: MaterialStatePropertyAll(MyColors.myWhite),
        ),
        child: const Text('Delete'),
      ),
      cancel: ElevatedButton(
        onPressed: () {
          Get.back();
        },
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.green),
          foregroundColor: MaterialStatePropertyAll(MyColors.myWhite),
        ),
        child: const Text('Cancel'),
      ),
    );
  }
}
