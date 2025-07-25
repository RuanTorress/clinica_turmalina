import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ResultadosWidget extends StatefulWidget {
  const ResultadosWidget({super.key});

  @override
  State<ResultadosWidget> createState() => _ResultadosWidgetState();
}

class _ResultadosWidgetState extends State<ResultadosWidget> {
  int? selectedImage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 768;

    // Placeholder para as imagens - substitua pelas imagens reais
    final resultados = [
      {
        'imagens': [
          'assets/images/5a43a5cb-95a4-44e4-80f5-9a6474f8e5d3.jpg',
          // Adicione mais imagens para este resultado se desejar
        ],
        'titulo': 'Limpeza de Pele',
        'descricao': 'Resultado após tratamento de limpeza profunda'
      },
      {
        'imagens': [
          'assets/images/melasma.jpeg',
          // Adicione mais imagens para este resultado se desejar
        ],
        'titulo': 'Tratamento Melasma',
        'descricao':
            'Tratamento especializado para melasma, utilizando protocolos avançados que combinam laser, peelings e dermocosméticos para clarear as manchas, uniformizar o tom da pele e promover mais luminosidade'
      },
      {
        'imagens': [
          'assets/images/WhatsApp Image 2025-07-24 at 16.47.23.jpeg',
          // Adicione mais imagens para este resultado se desejar
        ],
        'titulo': 'Tratamento de Minosedio',
        'descricao':
            'Tratamento especializado para minosedio, utilizando técnicas avançadas que promovem a renovação da pele, redução de inflamações e melhora da textura, proporcionando resultados visíveis e duradouros.'
      },
      {
        'imagens': [
          'assets/images/d437855b-4b0f-4e98-bdf0-5419e5083ae1.jpg',
          // Adicione mais imagens para este resultado se desejar
        ],
        'titulo': 'Rejuvenescimento Facial',
        'descricao': 'Melhora na textura e luminosidade da pele'
      },
      {
        'imagens': [
          'assets/images/microvazos.jpg',
          // Adicione mais imagens para este resultado se desejar
        ],
        'titulo': 'Tratamento de Microvasos',
        'descricao': 'Redução significativa de microvasos faciais'
      },
    ];

    return Container(
      padding: EdgeInsets.all(isDesktop ? 80 : 20),
      color: Colors.grey[50],
      child: Column(
        children: [
          Text(
            'Resultados',
            style: TextStyle(
              fontSize: isDesktop ? 42 : 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Veja as transformações incríveis de nossos clientes',
            style: TextStyle(
              fontSize: isDesktop ? 18 : 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          isDesktop
              ? AnimationLimiter(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 30,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: resultados.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 600),
                        columnCount: 2,
                        child: ScaleAnimation(
                          child: FadeInAnimation(
                            child: _buildResultadoCard(
                                resultados[index], index, isDesktop),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Container(
                  height: 500,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: PageView.builder(
                    itemCount: resultados.length,
                    padEnds: false,
                    pageSnapping: true,
                    controller: PageController(
                      viewportFraction: 0.85,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 600),
                          child: SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                              child: _buildResultadoCard(
                                  resultados[index], index, isDesktop),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildResultadoCard(
      Map<String, dynamic> resultado, int index, bool isDesktop) {
    final List<String> imagens =
        (resultado['imagens'] ?? [resultado['im']]) as List<String>;

    return _CardCarousel(
        imagens: imagens,
        titulo: resultado['titulo'] as String,
        isDesktop: isDesktop);
  }
}

class _CardCarousel extends StatefulWidget {
  final List<String> imagens;
  final String titulo;
  final bool isDesktop;

  const _CardCarousel({
    required this.imagens,
    required this.titulo,
    required this.isDesktop,
  });

  @override
  State<_CardCarousel> createState() => _CardCarouselState();
}

class _CardCarouselState extends State<_CardCarousel> {
  late final PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (currentPage < widget.imagens.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.imagens.length,
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemBuilder: (context, imgIndex) {
                      return Image.asset(
                        widget.imagens[imgIndex],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      );
                    },
                  ),
                ),
                // Setas de navegação sempre visíveis em mobile quando há múltiplas imagens
                if (widget.imagens.length > 1) ...[
                  // Seta esquerda
                  Positioned(
                    left: widget.isDesktop ? 8 : 4,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: widget.isDesktop ? 20 : 18,
                          ),
                          onPressed: currentPage > 0 ? _previousPage : null,
                        ),
                      ),
                    ),
                  ),
                  // Seta direita
                  Positioned(
                    right: widget.isDesktop ? 8 : 4,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: widget.isDesktop ? 20 : 18,
                          ),
                          onPressed: currentPage < widget.imagens.length - 1
                              ? _nextPage
                              : null,
                        ),
                      ),
                    ),
                  ),
                  // Indicadores de página
                  Positioned(
                    bottom: 12,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        widget.imagens.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: currentPage == index ? 12 : 8,
                          height: currentPage == index ? 12 : 8,
                          decoration: BoxDecoration(
                            color: currentPage == index
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: Colors.black.withOpacity(0.3),
                              width: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          // Apenas o título
          Container(
            padding: EdgeInsets.symmetric(
              vertical: widget.isDesktop ? 12 : 10,
              horizontal: widget.isDesktop ? 16 : 12,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF7C6A58),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Text(
              widget.titulo,
              style: TextStyle(
                fontSize: widget.isDesktop ? 16 : 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
