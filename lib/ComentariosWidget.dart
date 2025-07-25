import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ComentariosWidget extends StatefulWidget {
  const ComentariosWidget({super.key});

  @override
  State<ComentariosWidget> createState() => _ComentariosWidgetState();
}

class _ComentariosWidgetState extends State<ComentariosWidget> {
  int _currentIndex = 0;
  late CarouselSliderController _carouselController;

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselSliderController();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 768;

    final comentarios = [
      {
        'nome': 'Maria Silva',
        'avatar': 'M',
        'rating': 5,
        'comentario':
            'Excelente atendimento! O tratamento de microvasos foi perfeito. Recomendo muito!',
        'data': '2 semanas atrás',
        'tratamento': 'Microvasos',
        'cor': const Color(0xFF6A1B9A),
      },
      {
        'nome': 'Ana Costa',
        'avatar': 'A',
        'rating': 5,
        'comentario':
            'Profissionais muito qualificados. A limpeza de pele deixou minha pele renovada.',
        'data': '1 mês atrás',
        'tratamento': 'Limpeza de Pele',
        'cor': const Color(0xFF00695C),
      },
      {
        'nome': 'Carla Santos',
        'avatar': 'C',
        'rating': 5,
        'comentario':
            'Ambiente acolhedor e tratamentos de qualidade. Sempre saio satisfeita!',
        'data': '3 semanas atrás',
        'tratamento': 'Rejuvenescimento',
        'cor': const Color(0xFF5D4037),
      },
      {
        'nome': 'Juliana Oliveira',
        'avatar': 'J',
        'rating': 5,
        'comentario':
            'O tratamento capilar com minoxidil está dando ótimos resultados. Muito feliz!',
        'data': '2 meses atrás',
        'tratamento': 'Tratamento Capilar',
        'cor': const Color(0xFF1565C0),
      },
      {
        'nome': 'Paula Mendes',
        'avatar': 'P',
        'rating': 5,
        'comentario':
            'Fiz limpeza de pele e adorei o resultado! Atendimento excelente e ambiente muito agradável.',
        'data': '1 semana atrás',
        'tratamento': 'Limpeza de Pele',
        'cor': const Color(0xFFD81B60),
      },
      {
        'nome': 'Fernanda Rocha',
        'avatar': 'F',
        'rating': 4,
        'comentario':
            'Equipe muito atenciosa. O procedimento de rejuvenescimento facial superou minhas expectativas.',
        'data': '5 dias atrás',
        'tratamento': 'Rejuvenescimento',
        'cor': const Color(0xFF00897B),
      },
      {
        'nome': 'Bruna Lima',
        'avatar': 'B',
        'rating': 5,
        'comentario':
            'Amei o tratamento capilar! Já vejo diferença nos fios. Recomendo para todas.',
        'data': '3 semanas atrás',
        'tratamento': 'Tratamento Capilar',
        'cor': const Color(0xFF3949AB),
      },
      {
        'nome': 'Tatiane Souza',
        'avatar': 'T',
        'rating': 5,
        'comentario':
            'Ambiente limpo, profissionais qualificados e resultados visíveis. Voltarei mais vezes!',
        'data': '4 dias atrás',
        'tratamento': 'Microvasos',
        'cor': const Color(0xFF8E24AA),
      },
      {
        'nome': 'Camila Duarte',
        'avatar': 'C',
        'rating': 4,
        'comentario':
            'Gostei muito do atendimento e do carinho da equipe. O resultado ficou ótimo!',
        'data': '2 semanas atrás',
        'tratamento': 'Limpeza de Pele',
        'cor': const Color(0xFF43A047),
      },
    ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.grey[50]!,
            Colors.white,
          ],
        ),
      ),
      child: Column(
        children: [
          // Header Section
          Container(
            padding: EdgeInsets.all(isDesktop ? 80 : 30),
            child: Column(
              children: [
                // Badge de seção
                if (!isDesktop)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFF6EFE7), // Bege claro
                          Color.fromARGB(255, 136, 127, 116), // Marrom claro
                          // Marrom médio
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF7C6A58).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.star_rounded, color: Colors.white, size: 18),
                        SizedBox(width: 6),
                        Text(
                          'Depoimentos',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                Text(
                  'O que nossos clientes dizem',
                  style: TextStyle(
                    fontSize: isDesktop ? 42 : 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'Depoimentos reais de clientes satisfeitos com nossos tratamentos',
                  style: TextStyle(
                    fontSize: isDesktop ? 18 : 16,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Carousel Section
          SizedBox(
            height: isDesktop ? 360 : 420,
            child: CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                height: isDesktop ? 360 : 420,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 6),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: isDesktop ? 0.4 : 0.85,
                enlargeCenterPage: true,
                enlargeFactor: 0.15,
                enableInfiniteScroll: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items: comentarios.asMap().entries.map((entry) {
                final isActive = entry.key == _currentIndex;
                return AnimationConfiguration.staggeredList(
                  position: entry.key,
                  duration: const Duration(milliseconds: 600),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Transform.scale(
                        scale: isActive ? 1.0 : 0.95,
                        child: _buildComentarioCard(
                            entry.value, isDesktop, isActive),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Indicators e Navigation (Mobile)
          if (!isDesktop) ...[
            const SizedBox(height: 30),
            _buildMobileControls(comentarios.length),
          ],

          SizedBox(height: isDesktop ? 60 : 40),
        ],
      ),
    );
  }

  Widget _buildMobileControls(int length) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          // Indicadores customizados
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              length,
              (index) => GestureDetector(
                onTap: () {
                  _carouselController.animateToPage(index);
                  setState(() {
                    _currentIndex = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentIndex == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    gradient: _currentIndex == index
                        ? const LinearGradient(
                            colors: [Color(0xFF7C6A58), Color(0xFFF6EFE7)],
                          )
                        : null,
                    color: _currentIndex != index ? Colors.grey[300] : null,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: _currentIndex == index
                        ? [
                            BoxShadow(
                              color: const Color(0xFF7C6A58).withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
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
              _buildNavButton(
                icon: Icons.arrow_back_ios_rounded,
                onPressed: () => _carouselController.previousPage(),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF7C6A58).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: const Color(0xFF7C6A58).withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  '${_currentIndex + 1} de $length',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF7C6A58),
                  ),
                ),
              ),
              _buildNavButton(
                icon: Icons.arrow_forward_ios_rounded,
                onPressed: () => _carouselController.nextPage(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFF6EFE7), // Bege claro
            Color.fromARGB(255, 136, 127, 116), // Marrom claro
            // Marrom médio
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C6A58).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.all(14),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildComentarioCard(
      Map<String, dynamic> comentario, bool isDesktop, bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isActive ? 0.15 : 0.08),
            blurRadius: isActive ? 30 : 20,
            offset: const Offset(0, 8),
            spreadRadius: isActive ? 2 : 0,
          ),
        ],
        border: isActive
            ? Border.all(
                color: const Color(0xFF7C6A58).withOpacity(0.2),
                width: 2,
              )
            : null,
      ),
      child: Padding(
          padding: EdgeInsets.all(isDesktop ? 30 : 12),
          child: SingleChildScrollView(
            // ADICIONE ESTA LINHA

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Avatar com gradiente personalizado
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        comentario['cor'] as Color,
                        (comentario['cor'] as Color).withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: (comentario['cor'] as Color).withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: isDesktop ? 35 : 30,
                    backgroundColor: Colors.transparent,
                    child: Text(
                      comentario['avatar'] as String,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isDesktop ? 28 : 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Nome do cliente
                Text(
                  comentario['nome'] as String,
                  style: TextStyle(
                    fontSize: isDesktop ? 20 : 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 6),

                // Badge do tratamento
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: (comentario['cor'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: (comentario['cor'] as Color).withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    comentario['tratamento'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: comentario['cor'] as Color,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Estrelas com animação
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Icon(
                        index < (comentario['rating'] as int)
                            ? Icons.star_rounded
                            : Icons.star_outline_rounded,
                        size: isDesktop ? 24 : 20,
                        color: index < (comentario['rating'] as int)
                            ? const Color(0xFFFFB300)
                            : Colors.grey[300],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Comentário com aspas
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.grey[200]!,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.format_quote,
                        color: const Color(0xFF7C6A58).withOpacity(0.6),
                        size: 28,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        comentario['comentario'] as String,
                        style: TextStyle(
                          fontSize: isDesktop ? 16 : 15,
                          color: Colors.grey[700],
                          height: 1.6,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Data com ícone
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 14,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(width: 6),
                    Text(
                      comentario['data'] as String,
                      style: TextStyle(
                        fontSize: isDesktop ? 13 : 12,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
