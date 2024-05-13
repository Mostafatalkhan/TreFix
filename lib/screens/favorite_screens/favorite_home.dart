import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treflix/Bloc/cubit/favorite_cubit.dart';
import 'package:treflix/constants.dart';
import 'package:treflix/models/move.dart';

// ignore: must_be_immutable
class FavoriteHome extends StatelessWidget {
  FavoriteHome({
    super.key,
    required this.data,
    required this.type,
  });
  List<Movie>? data;
  final String type;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Treflix',
              style: TextStyle(
                  color: Colors.red, fontFamily: 'Bebas', fontSize: 36),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: state is AddFavoriteLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: data!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      return Column(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(children: [
                            Card(
                              elevation: 5,
                              shadowColor: Colors.white,
                              margin: const EdgeInsets.all(1),
                              child: Container(
                                width: size.width * 0.35,
                                height: size.height * 0.26,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12)),
                                child: Image.network(
                                  '$kImagePath${data![index].posterPath}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                                left: size.width * 0.25,
                                top: size.height * 0.2,
                                child: IconButton(
                                    onPressed: () {
                                      BlocProvider.of<FavoriteCubit>(context)
                                          .AddandDeleteFavorite(
                                              type: type,
                                              id: data![index].id,
                                              state: false);
                                      data!.removeAt(index);
                                    },
                                    icon: const Icon(Icons.minimize_outlined))),
                          ]),
                        )
                      ]);
                    },
                  )),
        );
      },
      listener: (context, state) {},
    );
  }
}
