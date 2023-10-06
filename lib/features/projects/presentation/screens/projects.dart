import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cvv/features/projects/business_logic/projects_controller.dart';
import 'package:my_cvv/features/projects/data/api/project_services.dart';
import 'package:my_cvv/features/projects/data/repository/project_repo.dart';

import '../../../../core/widgets/custom_spacer.dart';
import '../widgets/project_item.dart';

// ignore: must_be_immutable
class Projects extends StatelessWidget {
  Projects({super.key}) {
    controller =
        Get.put(ProjectController(projectRepository: projectRepository));
  }

  final ProjectRepository projectRepository =
      ProjectRepository(projectServices: ProjectsServices());

  late ProjectController controller;

  @override
  Widget build(BuildContext context) {
    return GetX<ProjectController>(
      builder: (_) {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.separated(
            itemCount: controller.projects.length,
            separatorBuilder: (BuildContext context, int index) {
              return vSpace();
            },
            itemBuilder: (BuildContext context, int index) {
              return ProjectItem(
                name: controller.projects[index].name,
                description: controller.projects[index].description,
                image: controller.projects[index].imageUrl,
                docId: controller.projects[index].id,
              );
            },
          );
        }
      },
    );
  }
}
