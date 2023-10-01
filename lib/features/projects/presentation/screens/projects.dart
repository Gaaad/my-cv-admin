import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cvv/features/projects/business_logic/projects_controller.dart';
import 'package:my_cvv/features/projects/data/api/project_services.dart';
import 'package:my_cvv/features/projects/data/repository/project_repo.dart';

import '../../../../core/widgets/custom_spacer.dart';
import '../../data/models/project.dart';
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
    return GetBuilder<ProjectController>(
      builder: (context) {
        List<Project> projects = controller.getProjects();

        return ListView.separated(
          itemCount: projects.length,
          separatorBuilder: (BuildContext context, int index) {
            return vSpace();
          },
          itemBuilder: (BuildContext context, int index) {
            return ProjectItem(
              name: projects[index].name,
              description: projects[index].description,
              image: projects[index].imageUrl,
              docId: projects[index].id,
            );
          },
        );
      },
    );
  }
}
