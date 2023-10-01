import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_image_picker.dart';
import '../../../../core/widgets/custom_spacer.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/expandable_fab.dart';
import '../../../projects/presentation/screens/projects.dart';
import '../../../skills/presentation/screens/skills.dart';
import '../../business_logic/image_controller.dart';
import '../../business_logic/nav_bar_controller.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final List<Widget> pages = [
    Skills(),
    Projects(),
  ];

  final navBarController = Get.put(NavbarController());

  final imageController = Get.put(ImageController());

  final _skillFormKey = GlobalKey<FormState>();
  final _projectFormKey = GlobalKey<FormState>();

  final _skillNameController = TextEditingController();
  final _projectNameController = TextEditingController();
  final _projectDescriptionController = TextEditingController();
  final _projectUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
      bottomNavigationBar: buildNavBar(),
      floatingActionButton: buildFloatButton(),
    );
  }

  ExpandableFab buildFloatButton() {
    return ExpandableFab(
      distance: 70,
      initialOpen: false,
      children: [
        CircleAvatar(
          backgroundColor: MyColors.myWhite,
          child: IconButton(
            onPressed: _addSkill,
            icon: const Icon(Icons.lightbulb_outline),
          ),
        ),
        CircleAvatar(
          backgroundColor: MyColors.myWhite,
          child: IconButton(
            onPressed: _addProject,
            icon: const Icon(Icons.assignment_outlined),
          ),
        ),
      ],
    );
  }

  Padding buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GetX<NavbarController>(
        builder: (controller) {
          return pages.elementAt(controller.index.value);
        },
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text('Home'),
      leading: const Icon(Icons.home),
    );
  }

  GNav buildNavBar() {
    return GNav(
      rippleColor: Colors.grey[300]!,
      hoverColor: Colors.grey[100]!,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      gap: 8,
      activeColor: MyColors.myYellow,
      backgroundColor: MyColors.myGrey.withOpacity(.1),
      color: Colors.white,
      iconSize: 24,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      duration: const Duration(milliseconds: 400),
      tabs: const [
        GButton(
          icon: Icons.lightbulb_outline,
          text: "Skills",
        ),
        GButton(
          icon: Icons.assignment_outlined,
          text: 'Projects',
        ),
      ],
      selectedIndex: navBarController.index.value,
      onTabChange: (index) {
        navBarController.index.value = index;
      },
    );
  }

  _addSkill() {
    imageController.skillImage.value = null;
    _skillNameController.clear();
    return Get.bottomSheet(
      shape: Border.all(),
      backgroundColor: MyColors.myDark,
      SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Form(
              key: _skillFormKey,
              child: CustomTextFormField(
                controller: _skillNameController,
                label: 'Skill name',
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Add skill name';
                  }
                  return null;
                },
              ),
            ),
            vSpace(),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: MyColors.myGrey),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GetX<ImageController>(
                        builder: (controller) {
                          if (imageController.getskillImage == null) {
                            return const Icon(
                              Icons.image_outlined,
                              color: MyColors.myGrey,
                              size: 50,
                            );
                          } else {
                            return Image.file(
                              imageController.getskillImage!,
                              fit: BoxFit.cover,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
                hSpace(),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Card(
                        color: Colors.grey[200],
                        child: IconButton(
                          onPressed: () async {
                            imageController.skillImage.value =
                                await uploadFromCamera();
                          },
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            color: MyColors.myDark,
                          ),
                        ),
                      ),
                      vSpace(),
                      Card(
                        color: Colors.grey[200],
                        child: IconButton(
                          onPressed: () async {
                            imageController.skillImage.value =
                                await uploadFromGallery();
                          },
                          icon: const Icon(
                            Icons.photo_camera_back,
                            color: MyColors.myDark,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            vSpace(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _addSkillButton,
                child: GetX<ImageController>(
                  builder: (context) {
                    if (imageController.skillIsLoading.value) {
                      return Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.white,
                          size: 30,
                        ),
                      );
                    } else {
                      return const Text('Add Skill');
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _addProject() {
    imageController.projectImage.value = null;
    _projectNameController.clear();
    _projectDescriptionController.clear();

    return Get.bottomSheet(
      backgroundColor: MyColors.myDark,
      shape: Border.all(),
      enterBottomSheetDuration: const Duration(milliseconds: 400),
      SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Form(
              key: _projectFormKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: _projectNameController,
                    label: 'Project name',
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Add project name';
                      }
                      return null;
                    },
                  ),
                  vSpace(),
                  CustomTextFormField(
                    controller: _projectDescriptionController,
                    label: 'Project description',
                    maxLine: 1,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Add project description';
                      }
                      return null;
                    },
                  ),
                  vSpace(),
                  CustomTextFormField(
                    controller: _projectUrlController,
                    label: 'Project url',
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Add project url';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            vSpace(),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: MyColors.myGrey),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GetX<ImageController>(
                        builder: (controller) {
                          if (imageController.getProjectImage == null) {
                            return const Icon(
                              Icons.image_outlined,
                              color: MyColors.myGrey,
                              size: 50,
                            );
                          } else {
                            return Image.file(
                              imageController.getProjectImage!,
                              fit: BoxFit.cover,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
                hSpace(),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Card(
                        color: Colors.grey[200],
                        child: IconButton(
                          onPressed: () async {
                            imageController.projectImage.value =
                                await uploadFromCamera();
                          },
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            color: MyColors.myDark,
                          ),
                        ),
                      ),
                      vSpace(),
                      Card(
                        color: Colors.grey[200],
                        child: IconButton(
                          onPressed: () async {
                            imageController.projectImage.value =
                                await uploadFromGallery();
                          },
                          icon: const Icon(
                            Icons.photo_camera_back,
                            color: MyColors.myDark,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            vSpace(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _addProjectButton,
                child: GetX<ImageController>(builder: (context) {
                  if (imageController.projectsIsLoading.value) {
                    return Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.white,
                        size: 30,
                      ),
                    );
                  } else {
                    return const Text('Add Project');
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future uploadImageToFirebase(
      File imageFile, bool isSkill, String docId) async {
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child(isSkill ? "skills/$docId" : "projects/$docId");

      UploadTask uploadTask = storageReference.putFile(imageFile);

      TaskSnapshot storageTaskSnapshot = await uploadTask;
      String downloadURL = await storageTaskSnapshot.ref.getDownloadURL();

      return downloadURL;
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }

  void _addSkillButton() async {
    if (_skillFormKey.currentState!.validate() &&
        imageController.skillImage.value != null) {
      imageController.skillIsLoading.value = true;

      CollectionReference collection =
          FirebaseFirestore.instance.collection('skills');

      DocumentReference documentRef = collection.doc();

      String imageUrl = await uploadImageToFirebase(
          imageController.skillImage.value!, true, documentRef.id);

      await documentRef.set({
        'id': documentRef.id,
        'name': _skillNameController.text,
        'image_url': imageUrl,
        'time': Timestamp.now(),
      }).then((value) {
        imageController.skillIsLoading.value = false;
        Get.back();
        Get.rawSnackbar(
          message: 'Skill added successfully',
          backgroundColor: Colors.green,
        );
      });
    } else {
      Get.rawSnackbar(
        message: 'Fill all the fields',
        backgroundColor: Colors.red,
      );
    }
  }

  void _addProjectButton() async {
    if (_projectFormKey.currentState!.validate() &&
        imageController.projectImage.value != null) {
      imageController.projectsIsLoading.value = true;

      CollectionReference collection =
          FirebaseFirestore.instance.collection('projects');

      DocumentReference documentRef = collection.doc();

      String imageUrl = await uploadImageToFirebase(
          imageController.projectImage.value!, false, documentRef.id);

      await documentRef.set({
        'id': documentRef.id,
        'name': _projectNameController.text,
        'description': _projectDescriptionController.text,
        'image_url': imageUrl,
        'time': Timestamp.now(),
      }).then((value) {
        imageController.projectsIsLoading.value = false;
        Get.back();
        Get.rawSnackbar(
          message: 'Project added successfully',
          backgroundColor: Colors.green,
        );
      });
    } else {
      Get.rawSnackbar(
        message: 'Fill all the fields',
        backgroundColor: Colors.red,
      );
    }
  }
}
