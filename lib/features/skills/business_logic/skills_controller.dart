// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:my_cvv/features/skills/data/models/skill.dart';

import 'package:my_cvv/features/skills/data/repository/skill_repo.dart';

class SkillsController extends GetxController {
  SkillsController({required this.skillRepository});
  SkillRepository skillRepository;
  List<Skill>? skills;

  List<Skill> getSkills() {
    skillRepository.getSkills().then((skills) {
      this.skills = skills;
      update();
    });
    return skills ?? List.empty();
  }
}
