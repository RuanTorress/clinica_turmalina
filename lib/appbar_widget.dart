import 'package:flutter/material.dart';

class AppBarWidget extends StatefulWidget {
  final Function(GlobalKey) onNavigate;
  final GlobalKey servicosKey;
  final GlobalKey conteudoKey;
  final GlobalKey resultadosKey;
  final GlobalKey comentariosKey;
  final GlobalKey contatoKey;

  const AppBarWidget({
    super.key,
    required this.onNavigate,
    required this.servicosKey,
    required this.conteudoKey,
    required this.resultadosKey,
    required this.comentariosKey,
    required this.contatoKey,
  });

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  bool _isScrolled = false;

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return SliverAppBar(
      expandedHeight: 0,
      floating: true,
      pinned: true,
      backgroundColor:
          _isScrolled ? Colors.white.withOpacity(0.98) : Colors.transparent,
      elevation: _isScrolled ? 8 : 0,
      flexibleSpace: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color:
              _isScrolled ? Colors.white.withOpacity(0.98) : Colors.transparent,
          boxShadow: _isScrolled
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                    spreadRadius: 0,
                  )
                ]
              : null,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 32.0 : 20.0,
              vertical: isDesktop ? 8 : 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo e Título - Responsivo
                Flexible(
                  flex: isDesktop ? 1 : 2,
                  child: _buildLogo(isDesktop),
                ),

                // Menu Desktop ou Mobile
                if (isDesktop)
                  Expanded(
                    flex: 2,
                    child: Center(child: _buildDesktopMenu()),
                  ),

                // Botões de ação
                _buildActionButtons(isDesktop),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(bool isDesktop) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo com animação
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: isDesktop ? 44 : 38,
          height: isDesktop ? 44 : 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color(0xFFF6EFE7), // Bege claro
                Color(0xFFB8A48B), // Marrom claro
                Color(0xFF7C6A58), // Marrom médio
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7C6A58).withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover,
            ),
          ),
        ),

        SizedBox(width: isDesktop ? 14 : 10),

        // Título responsivo
        if (isDesktop || MediaQuery.of(context).size.width > 400)
          Flexible(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontSize: isDesktop ? 26 : 20,
                fontWeight: FontWeight.bold,
                color: _isScrolled ? const Color(0xFF7C6A58) : Colors.white,
                letterSpacing: isDesktop ? 1.2 : 0.8,
                shadows: !_isScrolled
                    ? [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: const Text('Turmalina Estética'),
            ),
          ),
      ],
    );
  }

  Widget _buildActionButtons(bool isDesktop) {
    if (isDesktop) {
      // Adicione aqui o(s) botão(ões) de ação para desktop, se necessário.
      return const SizedBox.shrink();
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            CrossAxisAlignment.center, // Centraliza verticalmente
        children: [
          const SizedBox(width: 8),
          _buildMobileMenu(),
        ],
      );
    }
  }

  Widget _buildDesktopMenu() {
    final menuItems = [
      {'title': 'Serviços', 'key': widget.servicosKey, 'icon': Icons.spa},
      {
        'title': 'Conteúdo',
        'key': widget.conteudoKey,
        'icon': Icons.video_library
      },
      {
        'title': 'Resultados',
        'key': widget.resultadosKey,
        'icon': Icons.photo_library
      },
      {
        'title': 'Comentários',
        'key': widget.comentariosKey,
        'icon': Icons.rate_review
      },
      {
        'title': 'Contato',
        'key': widget.contatoKey,
        'icon': Icons.contact_mail
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: menuItems.map((item) {
        return _HoverNavItem(
          title: item['title'] as String,
          keySection: item['key'] as GlobalKey,
          onNavigate: widget.onNavigate,
          isScrolled: _isScrolled,
        );
      }).toList(),
    );
  }

  Widget _buildMobileMenu() {
    return Container(
      height: 44, // Altura igual ao botão Agendar
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFF6EFE7), // Bege claro
            Color(0xFFB8A48B), // Marrom claro
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C6A58).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: PopupMenuButton<String>(
        icon: Icon(
          Icons.menu_rounded,
          color: Colors.white,
          size: 22,
        ),
        color: Colors.white,
        elevation: 20,
        shadowColor: Colors.black.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        offset: const Offset(0, 60),
        onSelected: (value) {
          switch (value) {
            case 'servicos':
              widget.onNavigate(widget.servicosKey);
              break;
            case 'conteudo':
              widget.onNavigate(widget.conteudoKey);
              break;
            case 'resultados':
              widget.onNavigate(widget.resultadosKey);
              break;
            case 'comentarios':
              widget.onNavigate(widget.comentariosKey);
              break;
            case 'contato':
              widget.onNavigate(widget.contatoKey);
              break;
          }
        },
        itemBuilder: (context) => [
          _buildPopupMenuItem('servicos', 'Serviços', Icons.spa),
          _buildPopupMenuItem('conteudo', 'Conteúdo', Icons.video_library),
          _buildPopupMenuItem('resultados', 'Resultados', Icons.photo_library),
          _buildPopupMenuItem('comentarios', 'Comentários', Icons.rate_review),
          _buildPopupMenuItem('contato', 'Contato', Icons.contact_mail),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(
      String value, String title, IconData icon) {
    return PopupMenuItem(
      value: value,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF7C6A58).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF7C6A58),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget com efeito hover para desktop
class _HoverNavItem extends StatefulWidget {
  final String title;
  final GlobalKey keySection;
  final Function(GlobalKey) onNavigate;
  final bool isScrolled;

  const _HoverNavItem({
    required this.title,
    required this.keySection,
    required this.onNavigate,
    required this.isScrolled,
  });

  @override
  State<_HoverNavItem> createState() => _HoverNavItemState();
}

class _HoverNavItemState extends State<_HoverNavItem> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: () => widget.onNavigate(widget.keySection),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: _isHovering
                ? const Color(0xFF7C6A58).withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
            border: _isHovering
                ? Border.all(
                    color: const Color(0xFF7C6A58).withOpacity(0.3),
                    width: 1,
                  )
                : null,
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: _isHovering
                  ? const Color(0xFF7C6A58)
                  : (widget.isScrolled ? Colors.black87 : Colors.white),
              letterSpacing: 0.8,
              shadows: !widget.isScrolled && !_isHovering
                  ? [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ]
                  : null,
            ),
            child: Text(widget.title),
          ),
        ),
      ),
    );
  }
}
