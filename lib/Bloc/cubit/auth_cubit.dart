import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(RegisterInitial());

  final dio = Dio();

  void Register({
    required String name,
    required String phone,
    required String password,
    required String email,
  }) async {
    emit(RegisterLoading());
    Response response =
        await dio.post('https://student.valuxapps.com/api/register',
            data: {
              "name": name,
              "phone": phone,
              "email": email,
              "password": password,
            },
            options: Options(headers: {"lang": "en"}));

    var responseBody = response.data;
    print(responseBody['message']);

    if (responseBody['status'] == true) {
      emit(RegisterSuccess());
    } else if (responseBody['status'] == false) {
      emit(RegisterFailed(message: responseBody['message']));
    }
    ;
  }

  void Login({required String email, required String password}) async {
    emit(LoginLoading());
    Response response = await dio.post(
      'https://student.valuxapps.com/api/login',
      data: {
        "email": email,
        "password": password,
      },
      options: Options(headers: {"lang": "en"}),
    );

    var responseBody = response.data;
    print(responseBody['message']);
    if (responseBody['status'] == true) {
      emit(LoginSuccess());
    } else if (responseBody['status'] == false) {
      emit(LoginFailed(message: responseBody['message']));
    }
  }
}
