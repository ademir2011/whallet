import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';
import 'package:whallet/src/portifolio/domain/repositories/save_token_repository_interface.dart';
import 'package:whallet/src/portifolio/infra/datasources/create_token_datasource_interface.dart';

class CreateTokenRepository implements ICreateTokenRepository {
  final ICreateTokenDatasource iCreateTokenDatasource;

  CreateTokenRepository({required this.iCreateTokenDatasource});

  @override
  Future<void> createToken({required TokenEntity tokenEntity}) async {
    return await iCreateTokenDatasource.createToken(tokenEntity: tokenEntity);
  }
}
