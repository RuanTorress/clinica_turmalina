import 'package:clinica_estetica_landing/BannerWidget.dart';
import 'package:clinica_estetica_landing/ComentariosWidget.dart';
import 'package:clinica_estetica_landing/ContatoWidget.dart';
import 'package:clinica_estetica_landing/ConteudoWidget.dart';
import 'package:clinica_estetica_landing/FooterWidget.dart';
import 'package:clinica_estetica_landing/ResultadosWidget.dart';
import 'package:clinica_estetica_landing/ServicosWidget.dart';
import 'package:clinica_estetica_landing/appbar_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _servicosKey = GlobalKey();
  final GlobalKey _conteudoKey = GlobalKey();
  final GlobalKey _resultadosKey = GlobalKey();
  final GlobalKey _comentariosKey = GlobalKey();
  final GlobalKey _contatoKey = GlobalKey();

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          AppBarWidget(
            onNavigate: scrollToSection,
            servicosKey: _servicosKey,
            conteudoKey: _conteudoKey,
            resultadosKey: _resultadosKey,
            comentariosKey: _comentariosKey,
            contatoKey: _contatoKey,
          ),
          const SliverToBoxAdapter(child: BannerWidget()),
          SliverToBoxAdapter(
            child: ServicosWidget(key: _servicosKey),
          ),
          SliverToBoxAdapter(
            child: ConteudoWidget(key: _conteudoKey),
          ),
          SliverToBoxAdapter(
            child: ResultadosWidget(key: _resultadosKey),
          ),
          SliverToBoxAdapter(
            child: ComentariosWidget(key: _comentariosKey),
          ),
          SliverToBoxAdapter(
            child: ContatoWidget(key: _contatoKey),
          ),
          const SliverToBoxAdapter(child: FooterWidget()),
        ],
      ),
    );
  }
}
