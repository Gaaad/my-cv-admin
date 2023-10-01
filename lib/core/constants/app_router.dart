import 'package:get/get.dart';

import '../../features/main/presentation/screens/main_screen.dart';
import 'strings.dart';

class AppRouter {
  static List<GetPage<dynamic>> get appRouter {
    return [
      GetPage(
        name: mainScreenId,
        page: () => MainScreen(),
      ),
    ];
  }
}
