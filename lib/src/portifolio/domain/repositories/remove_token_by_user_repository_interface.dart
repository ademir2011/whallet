import 'package:whallet/src/portifolio/bloc_token/token_bloc.dart';
import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';

abstract class IRemoveTokenByUserRepository {
  Future<void> removeTokenByUser({required TokenEntity tokenEntity});
}
