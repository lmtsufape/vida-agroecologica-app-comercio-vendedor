# Vida Agroecológica - Aplicativo do Vendedor

<p align="center">
  <table>
    <tr>
      <td><img src="lib/assets/images/logo1.jpg" alt="Logo Vida Agroecológica" width="200"/></td>
      <td><img src="lib/assets/images/lmts.png" alt="Logo LMTS" width="200"/></td>
      <td><img src="lib/assets/images/ufape.png" alt="Logo UFAPE" width="200"/></td>
    </tr>
  </table>
</p>

[![Versão Flutter](https://img.shields.io/badge/Flutter-3.38.3-blue.svg)](https://flutter.dev)
[![Versão](https://img.shields.io/badge/versão-1.1.1-green.svg)](VERSION)
[![Estilo: Flutter](https://img.shields.io/badge/estilo-flutter_lints-blue)](https://pub.dev/packages/flutter_lints)

## Visão Geral

O **Vida Agroecológica Vendedor** é o aplicativo de gestão para agricultores e produtores rurais da região de Bonito-PE. Através dele, os vendedores podem gerenciar suas bancas, cadastrar produtos, acompanhar pedidos e conectar-se diretamente com consumidores urbanos.

Este projeto é uma colaboração entre a **Universidade Federal do Agreste de Pernambuco (UFAPE)** e comunidades agrícolas locais, desenvolvido pelo **LMTS (Laboratório Multidisciplinar de Tecnologias Sociais)**.

### Principais Funcionalidades

- 🏪 **Gestão de Bancas** - Criação e edição de bancas com horários de funcionamento por dia
- 📦 **Catálogo de Produtos** - Cadastro, edição e remoção de produtos com imagens
- 📋 **Gerenciamento de Pedidos** - Acompanhamento e atualização de status de pedidos
- 💰 **Formas de Pagamento** - Configuração de Dinheiro, PIX e outras formas
- 📊 **Relatórios** - Visualização de vendas e desempenho
- 🔔 **Notificações** - Alertas de novos pedidos
- 🔒 **Autenticação Segura** - Login com armazenamento seguro de credenciais
- 📱 **Design Responsivo** - Interface adaptada para diversos tamanhos de tela

## Stack Tecnológica

### Configuração do Ambiente

| Tecnologia | Versão |
|------------|--------|
| Flutter | 3.38.3 |
| Dart | 3.10.1 |
| Android SDK | 36 |
| Android NDK | 28.0.12433566 |
| Gradle | 8.12 |
| AGP | 8.9.1 |
| Kotlin | 2.1.0 |

### Dependências Principais

#### Gerenciamento de Estado
- `provider: ^6.0.3` - Gerenciamento de estado reativo
- `get: ^4.6.5` - Navegação e gerenciamento de estado

#### Rede e API
- `dio: ^5.0.0` - Cliente HTTP robusto
- `shared_preferences: ^2.1.0` - Persistência de dados simples
- `flutter_secure_storage: ^8.0.0` - Armazenamento seguro de credenciais

#### Interface do Usuário
- `google_fonts: ^4.0.4` - Fontes personalizadas
- `flutter_svg: ^1.1.5` - Renderização de SVGs
- `lottie: ^1.4.3` - Animações
- `font_awesome_flutter: ^10.2.1` - Ícones
- `responsive_framework: ^0.2.0` - Responsividade
- `device_preview: ^1.1.0` - Preview em múltiplos dispositivos
- `bot_toast: ^4.0.3` - Notificações toast

#### Utilitários
- `image_picker: ^0.8.5+3` - Seleção de imagens
- `file_picker: ^5.3.0` - Seleção de arquivos
- `flutter_image_compress: ^1.1.0` - Compressão de imagens
- `flutter_pdfview: ^1.3.2` - Visualização de PDFs
- `mask_text_input_formatter: ^2.5.0` - Máscaras de input
- `currency_text_input_formatter: ^2.2.3` - Formatação de moeda
- `url_launcher: ^6.1.2` - Abertura de links externos
- `permission_handler: ^10.0.0` - Gerenciamento de permissões
- `rate_my_app: ^1.1.3` - Solicitação de avaliação
- `logging: ^1.0.2` - Sistema de logs
- `cached_network_image: ^3.2.1` - Cache de imagens
- `intl: ^0.18.0` - Internacionalização
- `timezone: ^0.9.0` - Manipulação de fusos horários
- `path_provider: ^2.1.2` - Acesso ao sistema de arquivos

## Configuração do Ambiente de Desenvolvimento

### Pré-requisitos
```bash
# Verificar versão do Flutter
flutter --version  # Deve ser 3.38.3 ou superior

# Verificar configuração do ambiente
flutter doctor
```

### Instalação
```bash
# Clonar o repositório
git clone https://github.com/seu-usuario/vida-agroecologica-vendedor.git

# Entrar no diretório
cd vida-agroecologica-vendedor

# Instalar dependências
flutter pub get

# Executar em modo debug
flutter run

# Gerar build de produção
flutter build apk --release        # APK
flutter build appbundle --release  # AAB (Play Store)
```

### Configuração do Android Studio

1. Abra **Tools > SDK Manager**
2. Instale **Android SDK 36** e **Build-Tools 36.0.0**
3. Instale **NDK 28.0.12433566**
4. Aceite as licenças: `flutter doctor --android-licenses`

## Estrutura do Projeto
```
lib/
├── assets/
│   └── images/              # Imagens e ícones
├── components/
│   ├── buttons/             # Botões reutilizáveis
│   ├── forms/               # Campos de formulário
│   └── utils/               # Utilitários de UI
├── screens/
│   ├── home/                # Tela inicial
│   │   ├── home_screen.dart
│   │   ├── home_screen_controller.dart
│   │   └── home_screen_repository.dart
│   ├── my_store/            # Gestão da banca
│   │   ├── add_store_screen.dart
│   │   ├── edit_store_screen.dart
│   │   ├── my_store_controller.dart
│   │   └── my_store_repository.dart
│   ├── products/            # Gestão de produtos
│   ├── orders/              # Gestão de pedidos
│   ├── signin/              # Autenticação
│   │   ├── sign_in_screen.dart
│   │   ├── sign_in_controller.dart
│   │   ├── sign_in_repository.dart
│   │   └── components/
│   │       └── sign_in_result.dart
│   └── profile/             # Perfil do usuário
├── shared/
│   ├── components/          # Componentes compartilhados
│   ├── constants/           # Constantes do app
│   ├── core/
│   │   ├── models/          # Modelos de dados
│   │   │   └── banca_model.dart
│   │   ├── user_storage.dart
│   │   └── image_picker_controller.dart
│   └── utils/               # Funções utilitárias
└── main.dart                # Entrada do aplicativo
```

## Arquitetura

O projeto segue o padrão **MVC (Model-View-Controller)** com separação de responsabilidades:
```
Tela (Screen)
    │
    ├── Controller (Lógica de negócio e estado)
    │       │
    │       └── Repository (Comunicação com API)
    │               │
    │               └── Model (Estrutura de dados)
```

### Padrão de Nomenclatura

- **Telas**: `nome_screen.dart`
- **Controllers**: `nome_controller.dart`
- **Repositories**: `nome_repository.dart`
- **Models**: `nome_model.dart`
- **Componentes**: `nome_component.dart`

## Implantação

### Requisitos Android

| Requisito | Valor |
|-----------|-------|
| SDK Mínimo | Android 5.0 (API 21) |
| SDK Alvo | Android 15 (API 35) |
| Compile SDK | 36 |

#### Permissões Necessárias
- `INTERNET` - Acesso à rede
- `CAMERA` - Captura de fotos
- `READ_EXTERNAL_STORAGE` - Leitura de arquivos
- `WRITE_EXTERNAL_STORAGE` - Escrita de arquivos

### Gerando Build para Play Store
```bash
# Limpar builds anteriores
flutter clean

# Obter dependências
flutter pub get

# Gerar App Bundle
flutter build appbundle --release
```

O arquivo será gerado em: `build/app/outputs/bundle/release/app-release.aab`

### Requisitos Play Store (2025)

- ✅ Suporte a 16KB page size (Android 15+)
- ✅ Target SDK 35
- ✅ Compile SDK 36
- ✅ NDK r28+

## Tratamento de Erros

O aplicativo possui tratamento diferenciado de erros de rede:

| Tipo de Erro | Mensagem ao Usuário |
|--------------|---------------------|
| Timeout | "Conexão lenta. Verifique sua internet." |
| Sem conexão | "Sem conexão com a internet" |
| Erro 401/422 | "E-mail ou senha incorretos" |
| Erro 500/502/503 | "Servidor indisponível. Tente novamente mais tarde." |

## Como Contribuir

1. Faça um fork do repositório
2. Crie sua branch de feature (`git checkout -b feature/nova-funcionalidade`)
3. Commit suas mudanças (`git commit -m 'feat: adiciona nova funcionalidade'`)
4. Push para a branch (`git push origin feature/nova-funcionalidade`)
5. Abra um Pull Request

### Padrão de Commits

Utilizamos [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` - Nova funcionalidade
- `fix:` - Correção de bug
- `docs:` - Documentação
- `style:` - Formatação
- `refactor:` - Refatoração
- `test:` - Testes
- `chore:` - Manutenção

## Equipe

Desenvolvido pelo **LMTS - Laboratório Multidisciplinar de Tecnologias Sociais** da UFAPE.

## Suporte e Contato

- **Email**: lmts@ufape.edu.br
- **Site UFAPE**: [www.ufape.edu.br](https://ufape.edu.br/)
- **Localização**: Garanhuns - PE, Brasil

## Licença

Este projeto está em fase de registro de propriedade intelectual.

---

<p align="center">
  Desenvolvido com ❤️ pela equipe do <strong>LMTS</strong><br>
  <em>Laboratório Multidisciplinar de Tecnologias Sociais</em><br>
  <strong>UFAPE - Universidade Federal do Agreste de Pernambuco</strong>
</p>