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
      elevation: _isScrolled ? 6 : 0,
      flexibleSpace: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color:
              _isScrolled ? Colors.white.withOpacity(0.98) : Colors.transparent,
          boxShadow: _isScrolled
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Logo
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFE91E63),
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
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
                      const SizedBox(width: 14),
                      Text(
                        'Turmalina Estética',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: _isScrolled
                              ? const Color(0xFFE91E63)
                              : Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  if (isDesktop) _buildDesktopMenu(),
                  if (!isDesktop) _buildMobileMenu(),
                  // Botão de ação
                  if (isDesktop)
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE91E63),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        elevation: 0,
                      ),
                      icon: const Icon(Icons.message, size: 20),
                      label: const Text('Agendar'),
                      onPressed: () {
                        // Exemplo: abrir WhatsApp
                        // widget.onNavigate(widget.contatoKey);
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopMenu() {
    final menuItems = [
      {'title': 'Serviços', 'key': widget.servicosKey},
      {'title': 'Conteúdo', 'key': widget.conteudoKey},
      {'title': 'Resultados', 'key': widget.resultadosKey},
      {'title': 'Comentários', 'key': widget.comentariosKey},
      {'title': 'Contato', 'key': widget.contatoKey},
    ];

    return Row(
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
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.menu,
        color: _isScrolled ? const Color(0xFFE91E63) : Colors.white,
      ),
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
        const PopupMenuItem(value: 'servicos', child: Text('Serviços')),
        const PopupMenuItem(value: 'conteudo', child: Text('Conteúdo')),
        const PopupMenuItem(value: 'resultados', child: Text('Resultados')),
        const PopupMenuItem(value: 'comentarios', child: Text('Comentários')),
        const PopupMenuItem(value: 'contato', child: Text('Contato')),
      ],
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
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: _isHovering
                ? const Color(0xFFE91E63)
                : (widget.isScrolled ? Colors.black87 : Colors.white),
            letterSpacing: 1.1,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
            child: Text(widget.title),
          ),
        ),
      ),
    );
  }
}
