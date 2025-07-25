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
        'im': 'assets/images/5a43a5cb-95a4-44e4-80f5-9a6474f8e5d3.jpg',
        'titulo': 'Limpeza de Pele',
        'descricao': 'Resultado após tratamento de limpeza profunda'
      },
      {
        'im': 'assets/images/melasma.jpeg',
        'titulo': 'Tratamento Melasma',
        'descricao':
            'Tratamento especializado para melasma, utilizando protocolos avançados que combinam laser, peelings e dermocosméticos para clarear as manchas, uniformizar o tom da pele e promover mais luminosidade'
      },
      {
        'im': 'assets/images/WhatsApp Image 2025-07-24 at 16.47.23.jpeg',
        'titulo': 'Tratamento de Minosedio',
        'descricao':
            'Tratamento especializado para minosedio, utilizando técnicas avançadas que promovem a renovação da pele, redução de inflamações e melhora da textura, proporcionando resultados visíveis e duradouros.'
      },
      {
        'im': 'assets/images/d437855b-4b0f-4e98-bdf0-5419e5083ae1.jpg',
        'titulo': 'Rejuvenescimento Facial',
        'descricao': 'Melhora na textura e luminosidade da pele'
      },
      {
        'im': 'assets/images/microvazos.jpg',
        'titulo': 'Tratamento de Microvasos',
        'descricao': 'Redução significativa de microvasos faciais'
      },
    ];

    return Container(
      padding: EdgeInsets.all(isDesktop ? 80 : 40),
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
          const SizedBox(height: 60),
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
              : SizedBox(
                  height: 400,
                  child: PageView.builder(
                    itemCount: resultados.length,
                    itemBuilder: (context, index) {
                      return _buildResultadoCard(
                          resultados[index], index, isDesktop);
                    },
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildResultadoCard(
      Map<String, dynamic> resultado, int index, bool isDesktop) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.asset(
                resultado['im'] as String,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(isDesktop ? 20 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  resultado['titulo'] as String,
                  style: TextStyle(
                    fontSize: isDesktop ? 20 : 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  resultado['descricao'] as String,
                  style: TextStyle(
                    fontSize: isDesktop ? 16 : 14,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
