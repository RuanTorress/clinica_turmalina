import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ConteudoWidget extends StatefulWidget {
  const ConteudoWidget({super.key});

  @override
  State<ConteudoWidget> createState() => _ConteudoWidgetState();
}

class _ConteudoWidgetState extends State<ConteudoWidget> {
  late PageController _pageController;
  int _currentPage = 0;

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

  List<Map<String, String>> _getVideos() {
    return [
      {
        'url':
            'https://www.instagram.com/reel/DI1TBWOO9mf/?igsh=MTRrZWZzNDI0b2kyNA==',
        'title': 'Vídeo de botox',
        'description':
            'ratamento especializado para cicatrizes de acne, utilizando técnicas avançadas como microagulhamento, peelings químicos e laser. Promove renovação celular, estimula o colágeno e melhora a textura da pele, reduzindo marcas e proporcionando uma aparência mais uniforme e saudável',
        'duration': '2:45',
        'views': '1.2K',
        'img': 'assets/images/botox.jpg' // imagem diferente
      },
      {
        'url':
            'https://www.instagram.com/turmalina.estetica23/reel/DLXutWtuV7k/',
        'title': 'Vídeo de Microvasos',
        'description':
            'Conheça nosso tratamento especializado para microvasos, que utiliza técnicas avançadas para eliminar pequenos vasos indesejados, promovendo uma pele mais uniforme, saudável e bonita.',
        'duration': '2:45',
        'views': '1.2K',
        'img': 'assets/images/microvazos.jpg' // imagem diferente
      },
      {
        'url':
            'https://www.instagram.com/reel/DKPlBwfuCd2/?igsh=OW51dDZ3aHdsY2dr',
        'title': 'Vídeo de cicatrizes de acne',
        'description':
            'ratamento especializado para cicatrizes de acne, utilizando técnicas avançadas como microagulhamento, peelings químicos e laser. Promove renovação celular, estimula o colágeno e melhora a textura da pele, reduzindo marcas e proporcionando uma aparência mais uniforme e saudável',
        'duration': '2:45',
        'views': '1.2K',
        'img': 'assets/images/Acn.png' // imagem diferente
      },

      // Adicione outros vídeos com imagens diferentes
    ];
  }

  void _goToPage(int page) {
    setState(() {
      _currentPage = page;
    });
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    int prevPage =
        _currentPage > 0 ? _currentPage - 1 : _getVideos().length - 1;
    _goToPage(prevPage);
  }

  void _nextPage() {
    int nextPage =
        _currentPage < _getVideos().length - 1 ? _currentPage + 1 : 0;
    _goToPage(nextPage);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 768;
    final videos = _getVideos();

    return Container(
      padding: EdgeInsets.all(isDesktop ? 80 : 20),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'Conteúdo Educativo',
            style: TextStyle(
              fontSize: isDesktop ? 42 : 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Acompanhe nossos vídeos informativos sobre procedimentos e cuidados',
            style: TextStyle(
              fontSize: isDesktop ? 18 : 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          if (isDesktop)
            _buildDesktopGrid(videos)
          else
            _buildMobileCarousel(videos),
        ],
      ),
    );
  }

  Widget _buildDesktopGrid(List<Map<String, String>> videos) {
    return AnimationLimiter(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
          childAspectRatio: 0.8,
        ),
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 600),
            columnCount: 3,
            child: ScaleAnimation(
              child: FadeInAnimation(
                child: _buildVideoCard(videos[index], index, true),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMobileCarousel(List<Map<String, String>> videos) {
    return Column(
      children: [
        SizedBox(
          height: 420,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: videos.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 400),
                child: SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: _buildVideoCard(videos[index], index, false),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        // Indicadores de página
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            videos.length,
            (index) => GestureDetector(
              onTap: () => _goToPage(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == index ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? const Color(0xFFE91E63)
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Controles de navegação
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: _previousPage,
              icon: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE91E63),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFE91E63).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(width: 40),
            Text(
              '${_currentPage + 1} de ${videos.length}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 40),
            IconButton(
              onPressed: _nextPage,
              icon: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE91E63),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFE91E63).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVideoCard(Map<String, String> video, int index, bool isDesktop) {
    return GestureDetector(
      onTap: () => _launchUrl(video['url']!),
      child: Container(
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
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Stack(
                    children: [
                      // Thumbnail/Preview
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                video['img']!), // usa a imagem do vídeo
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // Duration badge
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            video['duration']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      // Views badge
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE91E63).withOpacity(0.9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.visibility,
                                color: Colors.white,
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                video['views']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Hover overlay
                      Positioned.fill(
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(isDesktop ? 20 : 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video['title']!,
                      style: TextStyle(
                        fontSize: isDesktop ? 18 : 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      video['description']!,
                      style: TextStyle(
                        fontSize: isDesktop ? 14 : 12,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ver no Instagram',
                          style: TextStyle(
                            fontSize: isDesktop ? 14 : 12,
                            color: const Color(0xFFE91E63),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE91E63).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.open_in_new,
                            size: 16,
                            color: Color(0xFFE91E63),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
