import 'dart:developer';

import 'package:ibm_flutter_final_project/core/networks/api_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/core/networks/end_point.dart';
import 'package:ibm_flutter_final_project/features/authentication/data/models/register_model.dart';
import 'package:ibm_flutter_final_project/features/authentication/logic/cubit/sign_up_state.dart';

class SignupRepo {
  final ApiConsumer api;
  const SignupRepo(this.api);
  Future<UserModel> singUp(SignUpState register) async {
    try {
      final responce = await api.post(EndPoint.register, null,
          data: register.toMap(), isFormData: true);

      UserModel user = UserModel.fromMap(responce);
      // user = UserModel(f_name: responce["f_name"], l_name: l_name, phone: phone, email: email, role: role)
      return user;
    } on ServerException catch (e) {
      rethrow;
    }
  }
}
