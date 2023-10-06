// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:my_cvv/features/projects/data/models/project.dart';
import 'package:my_cvv/features/projects/data/repository/project_repo.dart';

class ProjectController extends GetxController {
  ProjectController({required this.projectRepository}) {
    getProjects();
  }
  ProjectRepository projectRepository;
  RxList<Project> projects = List<Project>.empty().obs;
  RxBool isLoading = true.obs;

  void getProjects() {
    projectRepository.getProjects().then((data) {
      isLoading.value = false;
      projects.value = data;
    });
  }
}
