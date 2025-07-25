import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ResultadosWidget extends StatefulWidget {
  const ResultadosWidget({super.key});

  @override
  State<ResultadosWidget> createState() => _ResultadosWidgetState();
}

class _ResultadosWidgetState extends State<ResultadosWidget> {
  late PageController _desktopPageController;
  int _currentDesktopPage = 0;

  @override
  void initState() {
    super.initState();
    _desktopPageController = PageController(viewportFraction: 0.5);
  }

  @override
  void dispose() {
    _desktopPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 768;

    final resultados = [
      {
        'imagens': [
          'assets/images/5a43a5cb-95a4-44e4-80f5-9a6474f8e5d3.jpg',
        ],
        'titulo': 'Limpeza de Pele',
      },
      {
        'imagens': [
          'assets/images/melasma.jpeg',
        ],
        'titulo': 'Tratamento Melasma',
      },
      {
        'imagens': [
          'assets/images/WhatsApp Image 2025-07-24 at 16.47.23.jpeg',
        ],
        'titulo': 'Tratamento de Minosedio',
      },
      {
        'imagens': [
          'assets/images/d437855b-4b0f-4e98-bdf0-5419e5083ae1.jpg',
        ],
        'titulo': 'Rejuvenescimento Facial',
      },
      {
        'imagens': [
          'assets/images/microvazos.jpg',
        ],
        'titulo': 'Tratamento de Microvasos',
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

          // Carrossel para Desktop
          if (isDesktop)
            _buildDesktopCarousel(resultados)
          else
            _buildMobileCarousel(resultados),

          // Controles para Desktop
          if (isDesktop) ...[
            const SizedBox(height: 30),
            _buildDesktopControls(resultados.length),
          ],
        ],
      ),
    );
  }

  Widget _buildDesktopCarousel(List<Map<String, dynamic>> resultados) {
    return Column(
      children: [
        Container(
          height: 450,
          child: PageView.builder(
            controller: _desktopPageController,
            onPageChanged: (index) {
              setState(() {
                _currentDesktopPage = index;
              });
            },
            itemCount: resultados.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 600),
                child: SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child:
                          _buildResultadoCard(resultados[index], index, true),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMobileCarousel(List<Map<String, dynamic>> resultados) {
    return Container(
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
                  child: _buildResultadoCard(resultados[index], index, false),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDesktopControls(int length) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          // Indicadores customizados
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              length,
              (index) => GestureDetector(
                onTap: () {
                  _desktopPageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                  setState(() {
                    _currentDesktopPage = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: _currentDesktopPage == index ? 32 : 12,
                  height: 12,
                  decoration: BoxDecoration(
                    gradient: _currentDesktopPage == index
                        ? const LinearGradient(
                            colors: [Color(0xFF7C6A58), Color(0xFF5D4037)],
                          )
                        : null,
                    color:
                        _currentDesktopPage != index ? Colors.grey[300] : null,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: _currentDesktopPage == index
                        ? [
                            BoxShadow(
                              color: const Color(0xFF7C6A58).withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 25),

          // Controles de navegação
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDesktopNavButton(
                icon: Icons.arrow_back_ios_rounded,
                onPressed: () {
                  if (_currentDesktopPage > 0) {
                    _desktopPageController.previousPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                isEnabled: _currentDesktopPage > 0,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF7C6A58), Color(0xFF5D4037)],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7C6A58).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  '${_currentDesktopPage + 1} de $length',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              _buildDesktopNavButton(
                icon: Icons.arrow_forward_ios_rounded,
                onPressed: () {
                  if (_currentDesktopPage < length - 1) {
                    _desktopPageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                isEnabled: _currentDesktopPage < length - 1,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopNavButton({
    required IconData icon,
    required VoidCallback onPressed,
    required bool isEnabled,
  }) {
    return AnimatedOpacity(
      opacity: isEnabled ? 1.0 : 0.5,
      duration: const Duration(milliseconds: 200),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isEnabled
                ? [const Color(0xFF7C6A58), const Color(0xFF5D4037)]
                : [Colors.grey[400]!, Colors.grey[500]!],
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: const Color(0xFF7C6A58).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: isEnabled ? onPressed : null,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultadoCard(
      Map<String, dynamic> resultado, int index, bool isDesktop) {
    final List<String> imagens = (resultado['imagens'] ?? []) as List<String>;

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
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(widget.isDesktop ? 0.12 : 0.08),
            blurRadius: widget.isDesktop ? 25 : 20,
            offset: Offset(0, widget.isDesktop ? 8 : 4),
          ),
        ],
        border: widget.isDesktop
            ? Border.all(
                color: const Color(0xFF7C6A58).withOpacity(0.1),
                width: 1,
              )
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
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
                // Setas de navegação quando há múltiplas imagens
                if (widget.imagens.length > 1) ...[
                  // Seta esquerda
                  Positioned(
                    left: widget.isDesktop ? 12 : 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF7C6A58), Color(0xFF5D4037)],
                          ),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: widget.isDesktop ? 22 : 18,
                          ),
                          onPressed: currentPage > 0 ? _previousPage : null,
                        ),
                      ),
                    ),
                  ),
                  // Seta direita
                  Positioned(
                    right: widget.isDesktop ? 12 : 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF7C6A58), Color(0xFF5D4037)],
                          ),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: widget.isDesktop ? 22 : 18,
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
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        widget.imagens.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: currentPage == index ? 16 : 10,
                          height: currentPage == index ? 16 : 10,
                          decoration: BoxDecoration(
                            gradient: currentPage == index
                                ? const LinearGradient(
                                    colors: [
                                      Color(0xFF7C6A58),
                                      Color(0xFF5D4037)
                                    ],
                                  )
                                : null,
                            color: currentPage != index
                                ? Colors.white.withOpacity(0.7)
                                : null,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFF7C6A58).withOpacity(0.5),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          // Título com gradiente
          Container(
            padding: EdgeInsets.symmetric(
              vertical: widget.isDesktop ? 16 : 12,
              horizontal: widget.isDesktop ? 20 : 16,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF7C6A58), Color(0xFF5D4037)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Text(
              widget.titulo,
              style: TextStyle(
                fontSize: widget.isDesktop ? 18 : 16,
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
