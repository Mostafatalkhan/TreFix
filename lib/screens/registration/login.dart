import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treflix/Bloc/cubit/auth_cubit.dart';
import 'package:treflix/screens/bottom_home.dart';
import 'package:treflix/screens/registration/register.dart';
import 'package:treflix/widgets/customTextForm.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AuthCubit, AuthState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
              // appBar: AppBar(
              //   title: const Center(
              //     child: Text(
              //       'Treflix',
              //       style: TextStyle(
              //           color: Colors.red, fontFamily: 'Bebas', fontSize: 36),
              //     ),
              //   ),
              //   elevation: 0,
              //   backgroundColor: Colors.transparent,
              //   // actions: [DarkModeSwitch()],
              // ),
              body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/LOKI.jpg',
                    ),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 12.0,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        const Text(
                          'Welcome Back ! Glad ',
                          style: TextStyle(fontSize: 20),
                        ),
                        const Text(
                          'to see you, Again! ',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: size.height * 0.15,
                        ),
                        const Text('Email'),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: size.width * 0.82,
                          child: CustomForm(
                              hint: 'Enter Your Email',
                              controller: email,
                              icon: const Icon(Icons.email)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Password'),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: size.width * 0.82,
                          child: CustomForm(
                            fun: (value) {
                              if (password.text.isEmpty) {
                                return 'Password Mustn`t Be Empty';
                              } else if (password.text.length < 6) {
                                return 'Password Must Be More Than 6 Digit ';
                              } else {
                                return null;
                              }
                            },
                            secure: true,
                            hint: 'Enter Your Password',
                            controller: password,
                            icon: Icon(Icons.password),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 220),
                          child: MaterialButton(
                            color: Colors.red,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<AuthCubit>(context).Login(
                                    email: email.text, password: password.text);
                              }
                            },
                            child: Text(
                              state is LoginLoading ? 'Loading..' : 'Login',
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text('Don\'t have an account?'),
                            TextButton(
                              child: Text('Register Now'),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return RegisterScreen();
                                  },
                                ));
                              },
                            )
                          ],
                        )
                      ]),
                ),
              ),
            ),
          )),
        );
      },
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return NavigatorHome();
            },
          ));
        } else if (state is LoginFailed) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.red,
                content: Text(state.message),
              );
            },
          );
        }
      },
    );
  }
}
