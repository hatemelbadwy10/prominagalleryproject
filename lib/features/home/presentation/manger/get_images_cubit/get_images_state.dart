part of 'get_images_cubit.dart';

@immutable
sealed class GetImagesState {}

final class GetImagesInitial extends GetImagesState {}
final class GetImagesLoading extends GetImagesState {}
final class GetImagesSuccess extends GetImagesState {
  final ImagesModel imagesModel;


  GetImagesSuccess(this.imagesModel);

}
final class GetImagesFailure extends GetImagesState {}