import 'package:ibm_flutter_final_project/core/helpers/cach_helper.dart';
import 'package:ibm_flutter_final_project/core/networks/api_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/core/networks/end_point.dart';
import 'package:ibm_flutter_final_project/features/authentication/data/models/user_auth_model.dart';
import 'package:ibm_flutter_final_project/features/authentication/logic/singupCubit/sign_up_state.dart';

class SignupRepo {
  final ApiConsumer api;
  const SignupRepo(this.api);
  Future<UserAuthModel> singUp(SignUpState register) async {
    /* Sign in function to register user into db

      ARGUMENTS:
        - SingUpState : email and password and fName , lName
      RETURN:
        - UserAuthModel if success
        - threw serverException error  if fial
    */
    try {
      // get user after create it in db
      final responce = await api.post(EndPoint.register, null,
          data: register.toMap(), isFormData: true);

      UserAuthModel user = UserAuthModel.fromMap(responce);
      // save user data in shared if delete the user must login  again
      CacheHelper.sharedPreferences
          .setString(cacheHelperString.role, user.role);
      CacheHelper.sharedPreferences
          .setString(cacheHelperString.image, user.image);
      CacheHelper.sharedPreferences
          .setString(cacheHelperString.fName, user.fName);
      CacheHelper.sharedPreferences
          .setString(cacheHelperString.lName, user.lName);
      CacheHelper.sharedPreferences
          .setString(cacheHelperString.email, user.email);
      CacheHelper.sharedPreferences
          .setString(cacheHelperString.accessToken, user.accessToken);
      CacheHelper.sharedPreferences
          .setString(cacheHelperString.refreshToken, user.refreshToken);
      //
      return user;
    } on ServerException catch (e) {
      rethrow;
    }
  }
}

class cacheHelperString {
  static const role = "role";
  static const image = "image";
  static const fName = "fName";
  static const lName = "lName";
  static const email = "email";

  static const accessToken = "accessToken";
  static const refreshToken = "refreshToken";
}
