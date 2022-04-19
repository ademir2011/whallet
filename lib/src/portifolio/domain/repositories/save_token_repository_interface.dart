import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';

abstract class ISaveTokenRepository {
  Future<void> saveToken({required TokenEntity tokenEntity});
}
