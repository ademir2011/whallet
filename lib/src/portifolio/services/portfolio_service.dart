import 'package:whallet/src/auth/models/user_model.dart';
import 'package:whallet/src/portifolio/models/token_model.dart';
import 'package:whallet/src/portifolio/repository/portfolio_repository.dart';

class PortfolioService {
  final PortfolioRepository portfolioRepository;

  PortfolioService(this.portfolioRepository);

  Future<List<TokenModel>> getTokensByUser({required UserModel userModel}) async {
    return await portfolioRepository.getTokensByUser(userModel: userModel);
  }
}
