import 'package:cupizz_app/src/screens/answer_question/answer_question_screen.dart';
import 'package:cupizz_app/src/screens/answer_question/edit_answer_screen.dart';
import 'package:cupizz_app/src/screens/main/pages/profile/profile_page.dart';
import 'package:cupizz_app/src/screens/select_question/select_question_screen.dart';

import 'base/base.dart';

class Routes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const messages = '/messages';
  static const user = '/user';
  static const setting = '/setting';
  static const profile = '/profile';
  static const editProfile = '/profile/edit';
  static const answer = '/answer';
  static const editAnswer = '/answer/edit';
  static const selectQuestion = '/question/select';
  static const createPost = '/post/create';

  static const editAge = '/profile/edit/age';
  static const editDrink = '/profile/edit/drink';
  static const editGender = '/profile/edit/gender';
  static const editHeight = '/profile/edit/height';
  static const editHobbies = '/profile/edit/hobbies';
  static const editLocation = '/profile/edit/location';
  static const editLookup = '/profile/edit/lookup';
  static const editMarriage = '/profile/edit/marriage';
  static const editImages = '/profile/edit/images';
  static const editReligion = '/profile/edit/religion';
  static const editSmoke = '/profile/edit/smoke';
  static const editText = '/profile/edit/text';
  static const editEduLevel = '/profile/edit/education-level';
}

final List<GetPage> getPages = [
  GetPage(name: Routes.splash, page: () => SplashScreen()),
  GetPage(name: Routes.login, page: () => LoginScreen()),
  GetPage(name: Routes.register, page: () => RegisterScreen()),
  GetPage(name: Routes.home, page: () => MainScreen()),
  GetPage(name: Routes.messages, page: () => MessagesScreen()),
  GetPage(name: Routes.user, page: () => UserScreen()),
  GetPage(name: Routes.setting, page: () => UserSettingScreen()),
  GetPage(name: Routes.profile, page: () => ProfilePage()),
  GetPage(name: Routes.editProfile, page: () => EditProfileScreen()),
  GetPage(name: Routes.answer, page: () => AnswerQuestionScreen()),
  GetPage(name: Routes.editAnswer, page: () => EditAnswerScreen()),
  GetPage(name: Routes.selectQuestion, page: () => SelectQuestionScreen()),
  GetPage(name: Routes.createPost, page: () => CreatePostScreen()),
  // Edit-screens
  GetPage(name: Routes.editAge, page: () => EditAgeScreen()),
  GetPage(name: Routes.editDrink, page: () => EditDrinkScreen()),
  GetPage(name: Routes.editGender, page: () => EditGenderScreen()),
  GetPage(name: Routes.editHeight, page: () => EditHeightScreen()),
  GetPage(name: Routes.editHobbies, page: () => EditHobbiesScreen()),
  GetPage(name: Routes.editLocation, page: () => EditLocationScreen()),
  GetPage(name: Routes.editLookup, page: () => EditLookupScreen()),
  GetPage(name: Routes.editMarriage, page: () => EditMarriageScreen()),
  GetPage(name: Routes.editImages, page: () => EditUserImagesScreen()),
  GetPage(name: Routes.editReligion, page: () => EditReligionScreen()),
  GetPage(name: Routes.editSmoke, page: () => EditSmokeScreen()),
  GetPage(name: Routes.editText, page: () => EditTextScreen()),
  GetPage(name: Routes.editEduLevel, page: () => EditEducationLevelScreen()),
]
    .map((e) => e.copyWith(
          transition: Transition.rightToLeft,
          popGesture: true,
        ))
    .toList();
