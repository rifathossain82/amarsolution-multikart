import 'package:envied/envied.dart';

part 'env.g.dart';

/// Here the env data comes from the root project's .env file
/// So, I need to declare the path as '.env'
/// Don't forget to generate 'env.g.dart' file

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'BASE_URL', obfuscate: true)
  static final String baseURL = _Env.baseURL;

  @EnviedField(varName: 'SITE_URL', obfuscate: true)
  static final String siteURL = _Env.siteURL;

  @EnviedField(varName: 'PUBLIC_KEY', obfuscate: true)
  static final String publicKey = _Env.publicKey;

  @EnviedField(varName: 'PRIVATE_KEY', obfuscate: true)
  static final String privateKey = _Env.privateKey;
}