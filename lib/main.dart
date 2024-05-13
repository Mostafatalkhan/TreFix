import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treflix/Bloc/cubit/auth_cubit.dart';
import 'package:treflix/Bloc/cubit/favorite_cubit.dart';
import 'package:treflix/Bloc/cubit/video_cubit.dart';
import 'package:treflix/screens/splash_screen.dart';

void main() {
  //mosedwedwp
  // final video = VideoCubit();
  // video.GetVideoLink(id: 278, videoFor: VideoCubit().movieString);
  // auth.Login(email: 'mosa232@gmail.com', password: '123789');
  // auth.Register(
  //     name: 'mos',
  //     phone: '011186048153',
  //     password: '123789',
  //     email: 'mosa232@gmail.com');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => FavoriteCubit(),
        ),
        BlocProvider(
          create: (context) => VideoCubit(),
        ),
      ],
      child: MaterialApp(
        darkTheme: ThemeData.dark(),
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
