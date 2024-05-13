import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treflix/Bloc/cubit/auth_cubit.dart';
import 'package:treflix/screens/bottom_home.dart';
import 'package:treflix/widgets/customTextForm.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final email = TextEditingController();
  final name = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0,
              title: const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SingleChildScrollView(
                child: Column(children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                    child: Divider(
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Full Name'),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomForm(
                          controller: name,
                          hint: 'UserName',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('Email Address'),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomForm(controller: email, hint: 'xxx@gmail.com'),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('Phone Number'),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomForm(
                            type: TextInputType.phone,
                            controller: phone,
                            hint: '+20',
                            fun: (value) {
                              if (phone.text.isEmpty) {
                                return 'Phone Mustn`t Be Empty';
                              } else if (phone.text.length != 11) {
                                return 'Phone Number Is Not Correct';
                              } else {
                                return null;
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('Password'),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomForm(
                            controller: password,
                            hint: '*******',
                            fun: (value) {
                              if (password.text.isEmpty) {
                                return 'Password Mustn`t Be Empty';
                              } else if (password.text.length < 6) {
                                return 'Password Must Be More Than 6 Digit ';
                              } else {
                                return null;
                              }
                            }),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: MaterialButton(
                      color: Colors.red,
                      minWidth: double.infinity,
                      height: 50,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context).Register(
                              name: name.text,
                              phone: phone.text,
                              password: password.text,
                              email: email.text);
                        }
                      },
                      child: Text(
                        state is RegisterLoading ? 'Loading....' : 'Register',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                ]),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is RegisterSuccess) {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return const NavigatorHome();
            },
          ));
        } else if (state is RegisterFailed) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  backgroundColor: Colors.redAccent,
                  content: Text(state.message));
            },
          );
        } else {
          return null;
        }
      },
    );
  }
}
