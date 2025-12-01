enum SignInResultType {
  success,           // Login ok, tem banca
  successNoBanca,    // Login ok, sem banca (vai pra addStore)
  unauthorized,      // Não tem permissão (role)
  invalidCredentials, // Email/senha errados
  serverError,       // Erro 500, 502, 503
  networkError,      // Sem internet / timeout
}

class SignInResult {
  final SignInResultType type;
  final String? message;

  SignInResult(this.type, {this.message});
}