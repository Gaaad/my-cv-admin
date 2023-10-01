import 'package:my_cvv/features/skills/data/api/skill_services.dart';
import 'package:my_cvv/features/skills/data/models/skill.dart';

class SkillRepository {
  SkillServices skillServices;
  SkillRepository({
    required this.skillServices,
  });

  Future<List<Skill>> getSkills() async {
    final skill = await skillServices.getSkills();
    return skill.map((skill) => Skill.fromJson(skill.data())).toList();
  }
}
