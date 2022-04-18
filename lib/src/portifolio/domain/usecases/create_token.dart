import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';
import 'package:whallet/src/portifolio/domain/repositories/create_token_repository_interface.dart';

abstract class ICreateToken {
  Future<void> createToken({required TokenEntity tokenEntity});
}

class CreateToken implements ICreateToken {
  final ICreateTokenRepository iCreateTokenRepository;

  CreateToken({required this.iCreateTokenRepository});

  @override
  Future<void> createToken({required TokenEntity tokenEntity}) async {
    await iCreateTokenRepository.createToken(tokenEntity: tokenEntity);
  }
}
