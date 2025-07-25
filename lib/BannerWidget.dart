import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final List<String> _images = [
    'assets/images/20241203_165058768_iOS.jpg',
    'assets/images/20241203_165118090_iOS.jpg',
    'assets/images/20241203_165557641_iOS.jpg',
    // Adicione o caminho das suas imagens aqui
  ];

  final List<String> _phrases = [
    'Transforme sua beleza com nossos\ntratamentos especializados',
    'Cuidados profissionais para realçar sua beleza natural',
    'Agende sua consulta e descubra um novo você',
    // Adicione suas frases aqui
  ];

  int _currentIndex = 0;
  late final PageController _pageController;
  late final PageController _textController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _textController = PageController();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    Future.doWhile(() async {
      await Future.delayed(
          const Duration(seconds: 5)); // Mais lento (antes era 3)
      if (!mounted) return false;
      int next = (_currentIndex + 1) % _images.length;
      _pageController.animateToPage(
        next,
        duration:
            const Duration(milliseconds: 2000), // Mais lento (antes era 600)
        curve: Curves.ease,
      );
      _textController.animateToPage(
        next,
        duration: const Duration(milliseconds: 2000), // Mais lento
        curve: Curves.ease,
      );
      setState(() {
        _currentIndex = next;
      });
      return true;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE91E63),
            Color(0xFFAD1457),
            Color(0xFF880E4F),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Carrossel de imagens de fundo
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _images.length,
                itemBuilder: (context, index) => Image.asset(
                  _images[index],
                  fit: BoxFit.cover,
                  alignment: Alignment(0, -0.7), // Foca mais para cima (rosto)
                ),
              ),
            ),
          ),
          // Conteúdo
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: AnimationLimiter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 800),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(child: widget),
                    ),
                    children: [
                      Text(
                        'Turmalina Estética',
                        style: TextStyle(
                          fontSize: size.width > 768 ? 56 : 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: size.width > 768 ? 38 : 28,
                        child: PageView.builder(
                          controller: _textController,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _phrases.length,
                          itemBuilder: (context, index) => AnimatedSwitcher(
                            duration: const Duration(milliseconds: 600),
                            child: Text(
                              _phrases[index],
                              key: ValueKey(index),
                              style: TextStyle(
                                fontSize: size.width > 768 ? 24 : 18,
                                color: Colors.white.withOpacity(0.9),
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Cuidados profissionais para realçar sua beleza natural',
                        style: TextStyle(
                          fontSize: size.width > 768 ? 18 : 16,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          // Scroll to contact section
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFFE91E63),
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width > 768 ? 40 : 30,
                            vertical: size.width > 768 ? 20 : 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 8,
                        ),
                        child: Text(
                          'Agende sua Consulta',
                          style: TextStyle(
                            fontSize: size.width > 768 ? 18 : 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
