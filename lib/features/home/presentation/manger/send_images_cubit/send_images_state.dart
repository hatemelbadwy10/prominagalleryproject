
part of 'send_images_cubit.dart';




abstract class SendImagesState {}

class SendImagesInitial extends SendImagesState {}

class SendImagesLoading extends SendImagesState {}
class SendImagesFailure extends SendImagesState {
  final String fail;

  SendImagesFailure(this.fail);

}
class SendImagesSuccess extends SendImagesState {}


