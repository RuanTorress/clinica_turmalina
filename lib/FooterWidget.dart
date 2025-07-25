import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterWidget extends StatelessWidget {
  FooterWidget({super.key});

  final List<String> doctorImages = [
    'assets/images/20241203_165154822_iOS.jpg',
    'assets/images/20241203_165557641_iOS.jpg',
    'assets/images/20241203_165058768_iOS.jpg',
    // Adicione mais imagens conforme necessário
  ];

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 768;

    return Column(
      children: [
        // Seção da Dra. Thaynara
        _buildDoctorSection(isDesktop),
        // Footer principal
        Container(
          color: const Color(0xFF2C2C2C),
          padding: EdgeInsets.all(isDesktop ? 60 : 40),
          child: Column(
            children: [
              if (isDesktop) _buildDesktopFooter() else _buildMobileFooter(),
              const SizedBox(height: 40),
              Container(
                height: 1,
                color: Colors.grey[600],
              ),
              const SizedBox(height: 20),
              Text(
                '© 2025 Turmalina Estética. Todos os direitos reservados.',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: isDesktop ? 14 : 12,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _launchUrl(
                    'https://ruantorress.github.io/bio-Ruan/'), // coloque o link desejado aqui
                child: Text(
                  'Desenvolvido por Ruan Torres',
                  style: TextStyle(
                    color: Color(0xFF7C6A58),
                    fontSize: isDesktop ? 13 : 11,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorSection(bool isDesktop) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.grey[50]!,
          ],
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 20,
        vertical: isDesktop ? 80 : 60,
      ),
      child: isDesktop
          ? _buildDesktopDoctorSection()
          : _buildMobileDoctorSection(),
    );
  }

  Widget _buildDesktopDoctorSection() {
    return Row(
      children: [
        // Lado esquerdo - Texto
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(right: 60),
            child: _buildDoctorInfo(),
          ),
        ),
        // Lado direito - Imagem
        Expanded(
          flex: 2,
          child: _buildDoctorImage(),
        ),
      ],
    );
  }

  Widget _buildMobileDoctorSection() {
    return Column(
      children: [
        _buildDoctorInfo(),
        const SizedBox(height: 40),
        _buildDoctorImage(),
      ],
    );
  }

  Widget _buildDoctorInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Badge de qualificação
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF7C6A58).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF7C6A58).withOpacity(0.3),
            ),
          ),
          child: const Text(
            'PROFISSIONAL QUALIFICADA',
            style: TextStyle(
              color: Color(0xFF7C6A58),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Nome e título
        const Text(
          'Dra. Thaynara',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 8),

        // Qualificações
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 20,
                    decoration: BoxDecoration(
                      color: const Color(0xFF7C6A58),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Graduada em Biomédica',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 20,
                    decoration: BoxDecoration(
                      color: const Color(0xFF7C6A58),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Pós graduada em estetica avançada',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 20,
                    decoration: BoxDecoration(
                      color: const Color(0xFF7C6A58),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Graduada em Esteticista',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Descrição
        Text(
          'Profissional especializada em tratamentos estéticos avançados, '
          'combinando conhecimento científico da biomedicina com técnicas '
          'especializadas em estética. Comprometida em proporcionar '
          'resultados excepcionais e cuidados personalizados para cada paciente.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            height: 1.6,
          ),
        ),

        const SizedBox(height: 30),

        // Botão de contato
        Container(
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
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7C6A58).withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _launchUrl('https://wa.me/5511999999999'),
              borderRadius: BorderRadius.circular(30),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.chat,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Fale com a Dra. Thaynara',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorImage() {
    return Container(
      height: 500,
      child: Stack(
        children: [
          // Fundo decorativo
          Positioned(
            top: 30,
            right: 30,
            child: Container(
              width: 300,
              height: 400,
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
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),

          // Carrossel de imagens
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 300,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: doctorImages.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      doctorImages[index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 300,
                          height: 400,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFF6EFE7), // Bege claro
                                Color.fromARGB(
                                    255, 136, 127, 116), // Marrom claro
                                // Marrom médio
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.person,
                              size: 80,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),

          // Indicadores do carrossel
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: StatefulBuilder(
                builder: (context, setState) {
                  return FutureBuilder(
                    future: Future.value(_pageController.hasClients
                        ? _pageController.page?.round() ?? 0
                        : 0),
                    builder: (context, snapshot) {
                      int currentPage = snapshot.data ?? 0;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(doctorImages.length, (index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: currentPage == index ? 16 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: currentPage == index
                                  ? const Color(0xFF7C6A58)
                                  : Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          );
                        }),
                      );
                    },
                  );
                },
              ),
            ),
          ),

          // Elemento decorativo flutuante
          Positioned(
            bottom: 50,
            right: 0,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF7C6A58),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF7C6A58).withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(
                Icons.favorite,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopFooter() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildCompanyInfo()),
        const SizedBox(width: 30),
        Expanded(child: _buildSocialMedia()),
      ],
    );
  }

  Widget _buildMobileFooter() {
    return Column(
      children: [
        _buildCompanyInfo(),
        const SizedBox(height: 30),
        _buildSocialMedia(),
      ],
    );
  }

  Widget _buildCompanyInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Clinica Turmalina Estética',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Transformando beleza com cuidado e profissionalismo. '
          'Oferecemos tratamentos estéticos especializados para realçar '
          'sua beleza natural.',
          style: TextStyle(
            color: Colors.grey[300],
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialMedia() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Redes Sociais',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildSocialButton(
              FontAwesomeIcons.instagram,
              () => _launchUrl('https://instagram.com/turmalina.estetica23'),
            ),
            const SizedBox(width: 12),
            _buildSocialButton(
              FontAwesomeIcons.whatsapp,
              () => _launchUrl('https://wa.me/5511999999999'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Siga-nos para dicas de beleza e novidades!',
          style: TextStyle(
            color: Colors.grey[300],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Color(0xFF7C6A58),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
