import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterWidget extends StatefulWidget {
  FooterWidget({super.key});

  @override
  State<FooterWidget> createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<FooterWidget> {
  final List<String> doctorImages = [
    'assets/images/20241203_165154822_iOS.jpg',
    'assets/images/20241203_165557641_iOS.jpg',
    'assets/images/20241203_165058768_iOS.jpg',
  ];

  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Auto-play timer para desktop
    Future.delayed(Duration.zero, () {
      if (mounted) {
        _startAutoPlay();
      }
    });
  }

  void _startAutoPlay() {
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted && _pageController.hasClients) {
        int nextPage = (_currentPage + 1) % doctorImages.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        _startAutoPlay();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
                onTap: () =>
                    _launchUrl('https://ruantorress.github.io/bio-Ruan/'),
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
          child: _buildDesktopDoctorImage(),
        ),
      ],
    );
  }

  Widget _buildMobileDoctorSection() {
    return Column(
      children: [
        _buildDoctorInfo(),
        const SizedBox(height: 40),
        _buildMobileDoctorImage(),
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
              _buildQualificationItem('Graduada em Biomédica'),
              const SizedBox(height: 8),
              _buildQualificationItem('Pós graduada em estetica avançada'),
              const SizedBox(height: 8),
              _buildQualificationItem('Graduada em Esteticista'),
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
        _buildContactButton(),
      ],
    );
  }

  Widget _buildQualificationItem(String text) {
    return Row(
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
        Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildContactButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFF6EFE7),
            Color.fromARGB(255, 136, 127, 116),
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
          onTap: () => _launchUrl('https://wa.me/5562984332822'),
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
    );
  }

  // Imagem para Desktop - POSICIONAMENTO DAS SETAS CORRIGIDO
  Widget _buildDesktopDoctorImage() {
    return Container(
      height: 500,
      width: 400, // Largura fixa para melhor controle
      child: Stack(
        children: [
          // Fundo decorativo
          Positioned(
            top: 30,
            right: 30,
            child: Container(
              width: 320,
              height: 400,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFF6EFE7),
                    Color.fromARGB(255, 136, 127, 116),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),

          // Container principal das imagens - CENTRALIZADO
          Positioned(
            top: 0,
            left: 40,
            child: Container(
              width: 320,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: doctorImages.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      doctorImages[index],
                      fit: BoxFit.cover,
                      width: 320,
                      height: 400,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 320,
                          height: 400,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFF6EFE7),
                                Color.fromARGB(255, 136, 127, 116),
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

          // Seta ESQUERDA - POSICIONADA FORA DA IMAGEM
          Positioned(
            left: 0, // Bem na borda esquerda
            top: 180,
            child: GestureDetector(
              onTap: () {
                int prevPage = _currentPage > 0
                    ? _currentPage - 1
                    : doctorImages.length - 1;
                _pageController.animateToPage(
                  prevPage,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFF7C6A58),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),

          // Seta DIREITA - POSICIONADA FORA DA IMAGEM
          Positioned(
            right: 0, // Bem na borda direita
            top: 180,
            child: GestureDetector(
              onTap: () {
                int nextPage = (_currentPage + 1) % doctorImages.length;
                _pageController.animateToPage(
                  nextPage,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFF7C6A58),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),

          // Indicadores - POSICIONADOS ABAIXO DA IMAGEM
          Positioned(
            bottom: 30,
            left: 40,
            right: 40,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(doctorImages.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      width: _currentPage == index ? 24 : 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? const Color(0xFF7C6A58)
                            : Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        border: Border.all(
                          color: const Color(0xFF7C6A58).withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          // Elemento decorativo flutuante - REPOSICIONADO
          Positioned(
            bottom: 60,
            right: 10,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: const Color(0xFF7C6A58),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF7C6A58).withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
                border: Border.all(
                  color: Colors.white,
                  width: 3,
                ),
              ),
              child: const Icon(
                Icons.favorite,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Imagem para Mobile - mantendo como estava
  Widget _buildMobileDoctorImage() {
    return Container(
      height: 400,
      child: Stack(
        children: [
          // Fundo decorativo
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              width: 280,
              height: 350,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFF6EFE7),
                    Color.fromARGB(255, 136, 127, 116),
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
              width: 280,
              height: 350,
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
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: doctorImages.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      doctorImages[index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFF6EFE7),
                                Color.fromARGB(255, 136, 127, 116),
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

          // Indicadores do carrossel para mobile
          Positioned(
            bottom: 20,
            left: 0,
            right: 20,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(doctorImages.length, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 16 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? const Color(0xFF7C6A58)
                          : Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ),
          ),

          // Elemento decorativo flutuante para mobile
          Positioned(
            bottom: 40,
            right: 0,
            child: Container(
              width: 60,
              height: 60,
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
                size: 30,
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
              () => _launchUrl('https://wa.me/5562984332822'),
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
        decoration: const BoxDecoration(
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
