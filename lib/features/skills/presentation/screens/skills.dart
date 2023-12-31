import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cvv/features/skills/business_logic/skills_controller.dart';

import '../../../../core/widgets/custom_spacer.dart';
import '../../data/api/skill_services.dart';
import '../../data/repository/skill_repo.dart';
import '../widgets/skills_item.dart';

// ignore: must_be_immutable
class Skills extends StatelessWidget {
  Skills({super.key}) {
    controller = Get.put(SkillsController(skillRepository: skillRepository));
  }

  final SkillRepository skillRepository =
      SkillRepository(skillServices: SkillServices());

  late SkillsController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return ListView.separated(
          itemCount: controller.skills.length,
          separatorBuilder: (BuildContext context, int index) {
            return vSpace();
          },
          itemBuilder: (BuildContext context, int index) {
            return SkillsItem(
              title: controller.skills[index].name,
              image: controller.skills[index].imageUrl,
              index: index + 1,
              docId: controller.skills[index].id,
            );
          },
        );
      }
    });
  }
}
