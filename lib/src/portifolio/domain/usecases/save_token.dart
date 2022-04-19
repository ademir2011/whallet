import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';
import 'package:whallet/src/portifolio/domain/repositories/save_token_repository_interface.dart';

abstract class ISaveToken {
  Future<void> saveToken({required TokenEntity tokenEntity});
}

class SaveToken implements ISaveToken {
  final ISaveTokenRepository iSaveTokenRepository;

  SaveToken({required this.iSaveTokenRepository});

  @override
  Future<void> saveToken({required TokenEntity tokenEntity}) async {
    await iSaveTokenRepository.saveToken(tokenEntity: tokenEntity);
  }
}
