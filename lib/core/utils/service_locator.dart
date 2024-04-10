
import 'package:get_it/get_it.dart';
import 'package:prominaagencygalleryproject/core/utils/permission_handler.dart';

import 'media_handler.dart';

final getIt = GetIt.instance;

setupServiceLocator() {
  // Permission service is used in FileUploaderService
  // so it must be located first
  getIt.registerSingleton<PermissionService>(PermissionHandlerPermissionService());

  getIt.registerSingleton<MediaServiceInterface>(MediaService());
}