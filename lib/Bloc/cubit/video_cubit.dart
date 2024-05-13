import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit() : super(VideoInitial());
  final movieString = 'movie';
  final seiresString = 'tv';
  final dio = Dio();
  Future<String> GetVideoLink(
      {required int id, required String videoFor}) async {
    String? key;
    emit(GetVideoLoading());
    Response response = await dio.get(
        'https://api.themoviedb.org/3/${videoFor}/${id}/videos?api_key=df32c9d4e4029bbd0b739fe0fcc2a3e9');

    List<dynamic> responseBody = response.data['results'];
    // print(responseBody);
    List<VideoLink> linkList = [];
    for (int i = 0; i < responseBody.length; i++) {
      linkList.add(VideoLink.fromjson(responseBody[i]));
      if (linkList[i].type == 'Trailer') {
        key = linkList[i].key!;
        print(key);
        break;
      } else {
        key = linkList[0].key;
      }
    }
    print('response code=${response.statusCode}');
    if (response.statusCode == 200) {
      emit(GetVideoSuccess());
    } else {
      emit(GetVideoFailed());
    }
    print(key);
    return key!;
  }
}

class VideoLink {
  final String? key;
  final String? type;
  VideoLink({this.key, this.type});
  factory VideoLink.fromjson(jsonData) {
    return VideoLink(type: jsonData['type'], key: jsonData['key']);
  }
}
