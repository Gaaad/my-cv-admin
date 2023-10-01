import 'dart:io';

import 'package:get/get.dart';

class ImageController extends GetxController {
  Rx<File?> skillImage = Rx<File?>(null);

  File? get getskillImage => skillImage.value;

  Rx<File?> projectImage = Rx<File?>(null);

  File? get getProjectImage => projectImage.value;

  RxBool skillIsLoading = false.obs;
  RxBool projectsIsLoading = false.obs;
}
