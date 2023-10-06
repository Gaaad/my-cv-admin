import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_spacer.dart';
import '../../business_logic/projects_controller.dart';

class ProjectItem extends StatelessWidget {
  ProjectItem({
    super.key,
    required this.image,
    required this.name,
    required this.description,
    required this.docId,
  });

  final String image, name, description, docId;

  final ProjectController projectController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        _deleteDialog(context);
      },
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          color: MyColors.myGrey.withOpacity(.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: MyColors.myYellow),
                    ),
                    vSpace(height: 5),
                    Flexible(
                      child: Text(
                        description,
                        maxLines: 6,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: FancyShimmerImage(
                    imageUrl: image,
                    boxFit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _deleteButton() async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('projects');

    await collection.doc(docId).delete().then((value) async {
      final Reference imageReference =
          FirebaseStorage.instance.ref().child('projects/$docId');

      await imageReference.delete();

      projectController.getProjects();

      Get.back();
      Get.rawSnackbar(
        backgroundColor: Colors.green,
        message: 'Project deleted successfully',
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
          'Are you sure to delete $name project?',
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
