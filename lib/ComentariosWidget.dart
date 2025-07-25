import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ComentariosWidget extends StatelessWidget {
  const ComentariosWidget({super.key});

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
        'data': '2 semanas atrás'
      },
      {
        'nome': 'Ana Costa',
        'avatar': 'A',
        'rating': 5,
        'comentario':
            'Profissionais muito qualificados. A limpeza de pele deixou minha pele renovada.',
        'data': '1 mês atrás'
      },
      {
        'nome': 'Carla Santos',
        'avatar': 'C',
        'rating': 5,
        'comentario':
            'Ambiente acolhedor e tratamentos de qualidade. Sempre saio satisfeita!',
        'data': '3 semanas atrás'
      },
      {
        'nome': 'Juliana Oliveira',
        'avatar': 'J',
        'rating': 5,
        'comentario':
            'O tratamento capilar com minoxidil está dando ótimos resultados. Muito feliz!',
        'data': '2 meses atrás'
      },
    ];

    return Container(
      padding: EdgeInsets.all(isDesktop ? 80 : 40),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'O que nossos clientes dizem',
            style: TextStyle(
              fontSize: isDesktop ? 42 : 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Depoimentos reais de clientes satisfeitos',
            style: TextStyle(
              fontSize: isDesktop ? 18 : 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          CarouselSlider(
            options: CarouselOptions(
              height: isDesktop ? 300 : 250,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              viewportFraction: isDesktop ? 0.4 : 0.9,
              enlargeCenterPage: true,
            ),
            items: comentarios.asMap().entries.map((entry) {
              return AnimationConfiguration.staggeredList(
                position: entry.key,
                duration: const Duration(milliseconds: 600),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: _buildComentarioCard(entry.value, isDesktop),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildComentarioCard(Map<String, dynamic> comentario, bool isDesktop) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.all(isDesktop ? 30 : 24),
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
        children: [
          CircleAvatar(
            radius: isDesktop ? 30 : 25,
            backgroundColor: const Color(0xFFE91E63),
            child: Text(
              comentario['avatar'] as String,
              style: TextStyle(
                color: Colors.white,
                fontSize: isDesktop ? 24 : 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            comentario['nome'] as String,
            style: TextStyle(
              fontSize: isDesktop ? 18 : 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                5,
                (index) => Icon(
                      Icons.star,
                      size: isDesktop ? 20 : 16,
                      color: index < (comentario['rating'] as int)
                          ? Colors.amber
                          : Colors.grey[300],
                    )),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Text(
              comentario['comentario'] as String,
              style: TextStyle(
                fontSize: isDesktop ? 16 : 14,
                color: Colors.grey[600],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            comentario['data'] as String,
            style: TextStyle(
              fontSize: isDesktop ? 12 : 11,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}
