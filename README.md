# Turmalina Estética - Landing Page

Landing page responsiva desenvolvida em Flutter Web para a clínica Turmalina Estética.  
Apresenta serviços, resultados, depoimentos de clientes e informações de contato de forma moderna e intuitiva.

## Demonstração

Acesse: [https://ruantorress.github.io/clinica_turmalina/](https://ruantorress.github.io/clinica_turmalina/)

## Funcionalidades

- **Banner rotativo** com frases de impacto
- **Seção de Serviços** (faciais e corporais)
- **Vídeos informativos** com integração ao Instagram
- **Carrossel de Resultados** (antes/depois)
- **Depoimentos reais** de clientes
- **Formulário de contato** e informações da clínica
- **Mapa integrado** (Google Maps)
- **Footer** com redes sociais e créditos
- **Design responsivo** (desktop e mobile)

## Tecnologias

- [Flutter Web](https://flutter.dev/)
- [Dart](https://dart.dev/)
- [Google Fonts](https://pub.dev/packages/google_fonts)
- [Font Awesome](https://pub.dev/packages/font_awesome_flutter)
- [Flutter Staggered Animations](https://pub.dev/packages/flutter_staggered_animations)
- [Google Maps Flutter](https://pub.dev/packages/google_maps_flutter)
- [Carousel Slider](https://pub.dev/packages/carousel_slider)
- [url_launcher](https://pub.dev/packages/url_launcher)

## Como rodar localmente

1. **Clone o repositório:**
   ```
   git clone https://github.com/RuanTorress/clinica_turmalina.git
   cd clinica_turmalina
   ```

2. **Instale as dependências:**
   ```
   flutter pub get
   ```

3. **Rode localmente:**
   ```
   flutter run -d chrome
   ```

## Como publicar no GitHub Pages

1. Gere o build web:
   ```
   flutter build web --base-href /clinica_turmalina/
   ```
2. Copie o conteúdo de `build/web` para a pasta `docs`:
   ```
   xcopy /E /I /Y build\web\* docs\
   ```
3. Faça commit e push:
   ```
   git add docs
   git commit -m "Atualiza build web"
   git push
   ```
4. No GitHub, ative o GitHub Pages em `Settings > Pages`, branch `main`, pasta `/docs`.

## Estrutura do Projeto

- `lib/`
  - `main.dart` — Ponto de entrada do app
  - `home_screen.dart` — Tela principal com navegação por seções
  - `BannerWidget.dart` — Banner rotativo
  - `ServicosWidget.dart` — Seção de serviços
  - `ConteudoWidget.dart` — Seção de vídeos informativos
  - `ResultadosWidget.dart` — Carrossel de resultados
  - `ComentariosWidget.dart` — Depoimentos de clientes
  - `ContatoWidget.dart` — Formulário e informações de contato
  - `FooterWidget.dart` — Footer com informações e redes sociais
  - `appbar_widget.dart` — Menu de navegação

## Personalização

- Para alterar textos, imagens ou vídeos, edite os arquivos em `lib/` conforme a seção desejada.
- Para adicionar novos serviços, edite `ServicosWidget.dart`.
- Para adicionar novos depoimentos, edite `ComentariosWidget.dart`.

## Licença

Este projeto é open-source sob a licença MIT.

---

Desenvolvido por [Ruan Torres](https://ruantorress.github.io/bio-Ruan/)