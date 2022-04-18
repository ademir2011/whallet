import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:whallet/src/auth/bloc/auth_bloc.dart';
import 'package:whallet/src/auth/domain/usecases/check_auth.dart';
import 'package:whallet/src/auth/domain/usecases/remove_auth_info.dart';
import 'package:whallet/src/auth/domain/usecases/save_auth_info.dart';
import 'package:whallet/src/auth/domain/usecases/signin.dart';
import 'package:whallet/src/auth/domain/usecases/signout.dart';
import 'package:whallet/src/auth/domain/usecases/signup.dart';
import 'package:whallet/src/auth/external/datasources/check_auth_datasource.dart';
import 'package:whallet/src/auth/external/datasources/firebase_auth_signin_email_password_datasource.dart';
import 'package:whallet/src/auth/external/datasources/firebase_auth_signout_email_password_datasource.dart';
import 'package:whallet/src/auth/external/datasources/firebase_auth_signup_email_password_datasource.dart';
import 'package:whallet/src/auth/external/datasources/remove_auth_info_datasource.dart';
import 'package:whallet/src/auth/external/datasources/save_auth_info_datasource.dart';
import 'package:whallet/src/auth/infra/datasources/signup_datasource.dart';
import 'package:whallet/src/auth/infra/repositories/check_auth_repository.dart';
import 'package:whallet/src/auth/infra/repositories/remove_auth_info_repository.dart';
import 'package:whallet/src/auth/infra/repositories/save_auth_info_repository.dart';
import 'package:whallet/src/auth/infra/repositories/signin_repository.dart';
import 'package:whallet/src/auth/infra/repositories/signout_repository.dart';
import 'package:whallet/src/auth/infra/repositories/signup_repository.dart';
import 'package:whallet/src/auth/pages/auth_recovery_page.dart';
import 'package:whallet/src/auth/pages/auth_signin_page.dart';
import 'package:whallet/src/auth/pages/auth_signup_page.dart';
import 'package:whallet/src/init/pages/splashscreen_page.dart';
import 'package:whallet/src/portifolio/pages/portfolio_home_page.dart';
import 'package:whallet/src/portifolio/pages/token_detail_page.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton<FirebaseAuth>((i) => FirebaseAuth.instance),
        Bind.singleton((i) => FirebaseAuthSignInEmailPasswordDatasource(firebaseAuth: i())),
        Bind.singleton((i) => FirebaseAuthSignOutEmailPasswordDatasource(firebaseAuth: i())),
        Bind.singleton(
          (i) => FirebaseAuthSignUpEmailPasswordDatasource(
            firebaseAuth: i(),
            firebaseAuthSignOutEmailPasswordDatasource: i(),
          ),
        ),
        Bind.singleton((i) => SignUpRepository(iSignUpDatasource: i())),
        Bind.singleton((i) => SignInRepository(iSignInDatasource: i())),
        Bind.singleton((i) => SignOutRepository(iSignOutDatasource: i())),
        Bind.singleton((i) => SignUp(iSignUpRepository: i())),
        Bind.singleton((i) => SignIn(iSignInRepository: i())),
        Bind.singleton((i) => SignOut(iSignOutRepository: i())),
        Bind.singleton((i) => SaveAuthInfoDatasource()),
        Bind.singleton((i) => RemoveAuthInfoDatasource()),
        Bind.singleton((i) => CheckAuthDatasource()),
        Bind.singleton((i) => SaveAuthInfoRepository(iSaveAuthInfoDatasource: i())),
        Bind.singleton((i) => RemoveAuthInfoRepository(iRemoveAuthInfoDatasource: i())),
        Bind.singleton((i) => CheckAuthRepository(iCheckAuthDatasource: i())),
        Bind.singleton((i) => SaveAuthInfo(iSaveAuthInfoRepository: i())),
        Bind.singleton((i) => RemoveAuthInfo(iRemoveAuthInfoRepository: i())),
        Bind.singleton((i) => CheckAuth(iCheckAuthRepository: i())),
        Bind.singleton(
          (i) => AuthBloc(
            signUp: i(),
            signIn: i(),
            signOut: i(),
            saveAuthInfo: i(),
            removeAuthInfo: i(),
            checkAuth: i(),
          ),
        )
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const SplashscreenPage()),
        ChildRoute('/auth_signin', child: (context, args) => const AuthSigninPage()),
        ChildRoute('/auth_signup', child: (context, args) => const AuthSighUpPage()),
        ChildRoute('/auth_recobery', child: (context, args) => const AuthRecoveryPage()),
        ChildRoute('/portfolio', child: (context, args) => const PortfolioHomePage()),
        ChildRoute('/token_detail', child: (context, args) => const TokenDetailPage()),
      ];
}
