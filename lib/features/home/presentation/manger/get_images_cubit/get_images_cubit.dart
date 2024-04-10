import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:prominaagencygalleryproject/features/home/data/models/images_model.dart';

import '../../../../../core/utils/api_services.dart';

part 'get_images_state.dart';

class GetImagesCubit extends Cubit<GetImagesState> {
  final ApiServices apiServices;
  GetImagesCubit(this.apiServices) : super(GetImagesInitial());
  Future<void> fetchImages() async {
    emit(GetImagesLoading());
    try {
      final images = await apiServices.getImages();
      final imagesModel = ImagesModel.fromJson(images);
      emit(GetImagesSuccess(imagesModel));
    } catch (_) {
      emit(GetImagesFailure());
    }
  }
}


