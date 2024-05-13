part of 'video_cubit.dart';

@immutable
sealed class VideoState {}

final class VideoInitial extends VideoState {}

final class GetVideoSuccess extends VideoState {}

final class GetVideoFailed extends VideoState {}

final class GetVideoLoading extends VideoState {}
