import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Imports condicionais para web
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

class ContatoWidget extends StatefulWidget {
  const ContatoWidget({super.key});

  @override
  State<ContatoWidget> createState() => _ContatoWidgetState();
}

class _ContatoWidgetState extends State<ContatoWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _mensagemController = TextEditingController();
  bool _isLoading = false;
  final List<bool> _expandedStates = List.generate(7, (index) => false);

  // ViewType único para o mapa
  static const String _mapViewType = 'turmalina-google-maps-iframe';
  static bool _isViewRegistered = false;

  @override
  void initState() {
    super.initState();
    _registerMapView();
  }

  void _registerMapView() {
    if (kIsWeb && !_isViewRegistered) {
      ui_web.platformViewRegistry.registerViewFactory(
        _mapViewType,
        (int viewId) {
          final iframe = html.IFrameElement()
            ..width = '100%'
            ..height = '100%'
            ..src =
                'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3675.066343351242!2d-49.2639537!3d-16.7353645!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x935ef9f167ef7b19%3A0xb933b1f7e3b338ab!2sTurmalina%20Est%C3%A9tica!5e0!3m2!1spt-BR!2sbr!4v1710000000000!5m2!1spt-BR!2sbr'
            ..style.border = 'none'
            ..style.width = '100%'
            ..style.height = '100%'
            ..allowFullscreen = true;

          return iframe;
        },
      );
      _isViewRegistered = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 768;

    return Container(
      color: Colors.grey[50],
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(isDesktop ? 80 : 20),
            child: Column(
              children: [
                _buildHeader(isDesktop),
                const SizedBox(height: 10),
                if (isDesktop) _buildDesktopLayout() else _buildMobileLayout(),
              ],
            ),
          ),
          _buildFAQSection(isDesktop),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isDesktop) {
    return AnimationConfiguration.staggeredList(
      position: 0,
      duration: const Duration(milliseconds: 600),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: Column(
            children: [
              Text(
                'Entre em Contato Conosco',
                style: TextStyle(
                  fontSize: isDesktop ? 42 : 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Estamos prontos para atendê-la e esclarecer suas dúvidas',
                style: TextStyle(
                  fontSize: isDesktop ? 18 : 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 1, child: _buildContactInfo(true)),
        const SizedBox(width: 10),
        Expanded(flex: 1, child: _buildMapSection(true)),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        const SizedBox(height: 10),
        _buildContactInfo(false),
        const SizedBox(height: 10),
        _buildMapSection(false),
      ],
    );
  }

  Widget _buildContactInfo(bool isDesktop) {
    return AnimationConfiguration.staggeredList(
      position: 1,
      duration: const Duration(milliseconds: 600),
      child: SlideAnimation(
        horizontalOffset: isDesktop ? -50.0 : 0,
        child: FadeInAnimation(
          child: Container(
            padding: EdgeInsets.all(isDesktop ? 30 : 25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 25,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Informações de Contato',
                  style: TextStyle(
                    fontSize: isDesktop ? 24 : 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 30),
                _buildContactItem(
                  Icons.business,
                  'Localização',
                  'B&B Business',
                  isDesktop: isDesktop,
                ),
                const SizedBox(height: 20),
                _buildContactItem(
                  Icons.location_on,
                  'Endereço',
                  'Edifício B&B Business\nRua Tapajós com R. Itu, Lotes 01-07\nVila Brasília, Aparecida de Goiânia - GO\nCEP: 74911-820',
                  isDesktop: isDesktop,
                  onTap: () => _openGoogleMaps(),
                ),
                const SizedBox(height: 20),
                _buildContactItem(
                  Icons.phone,
                  'Telefone',
                  '(62) 98433-2822',
                  isDesktop: isDesktop,
                  onTap: () => _launchUrl('tel:+5562984332822'),
                ),
                const SizedBox(height: 20),
                _buildContactItem(
                  Icons.access_time,
                  'Horário de Funcionamento',
                  'Segunda a Sexta: 8h às 19h\nSábado: 8h às 14h\n🟢 Aberto agora',
                  isDesktop: isDesktop,
                ),
                const SizedBox(height: 30),
                _buildSocialButtons(isDesktop),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem(
    IconData icon,
    String title,
    String content, {
    required bool isDesktop,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: isDesktop ? 50 : 45,
              height: isDesktop ? 50 : 45,
              decoration: BoxDecoration(
                color: const Color(0xFF7C6A58).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF7C6A58),
                size: isDesktop ? 24 : 22,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: isDesktop ? 16 : 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    content,
                    style: TextStyle(
                      fontSize: isDesktop ? 14 : 13,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[400],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButtons(bool isDesktop) {
    return Row(
      children: [
        Expanded(
          child: _buildSocialButton(
            Icons.camera_alt,
            'Instagram',
            () => _launchUrl('https://www.instagram.com/turmalina.estetica23/'),
            isDesktop,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildSocialButton(
            Icons.chat,
            'WhatsApp',
            () => _launchUrl('https://wa.me/5562984332822'),
            isDesktop,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton(
    IconData icon,
    String label,
    VoidCallback onTap,
    bool isDesktop,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: isDesktop ? 12 : 10,
          horizontal: isDesktop ? 16 : 12,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF7C6A58),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7C6A58).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: isDesktop ? 20 : 18,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: isDesktop ? 14 : 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapSection(bool isDesktop) {
    return AnimationConfiguration.staggeredList(
      position: 2,
      duration: const Duration(milliseconds: 600),
      child: SlideAnimation(
        horizontalOffset: isDesktop ? 50.0 : 0,
        child: FadeInAnimation(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 25,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: _buildMap(isDesktop),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMap(bool isDesktop) {
    if (kIsWeb) {
      // Para web, usar HtmlElementView com iframe
      return SizedBox(
        height: isDesktop ? 400 : 300,
        child: const HtmlElementView(
          viewType: _mapViewType,
        ),
      );
    } else {
      // Para mobile, usar GoogleMap nativo
      return SizedBox(
        height: isDesktop ? 400 : 300,
        child: GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(-16.7353645, -49.2639537),
            zoom: 17,
          ),
          markers: {
            const Marker(
              markerId: MarkerId('turmalina'),
              position: LatLng(-16.7353645, -49.2639537),
              infoWindow: InfoWindow(title: 'Turmalina Estética'),
            ),
          },
          myLocationButtonEnabled: false,
          zoomControlsEnabled: true,
          mapToolbarEnabled: false,
        ),
      );
    }
  }

  Widget _buildFAQSection(bool isDesktop) {
    final faqs = [
      {
        'question': 'Os procedimentos são seguros?',
        'answer':
            'Sim, todos os nossos procedimentos são realizados pela nossa profissional qualificada com formação adequada. Com a **Dra. Thaynara Torres**, seguimos rigorosamente as normas de segurança e utilizamos produtos de alta qualidade aprovados pela ANVISA. Sua segurança e bem-estar são nossa prioridade.',
      },
      {
        'question':
            'Qual é a melhor maneira de encontrar o tratamento ideal para minhas necessidades?',
        'answer':
            'Recomendamos que você agende uma avaliação conosco. Nossa equipe realizará uma análise personalizada, discutindo suas preocupações, necessidades e expectativas. Assim, poderemos sugerir o tratamento ideal para você, de forma simples e sem complicações.',
      },
      {
        'question': 'Os procedimentos são dolorosos?',
        'answer':
            'A maioria dos nossos procedimentos é minimamente invasiva, e muitos clientes relatam apenas um leve desconforto.',
      },
      {
        'question': 'Vocês oferecem pacotes ou promoções?',
        'answer':
            'Sim, frequentemente disponibilizamos planos promocionais que combinam diferentes tratamentos a preços especiais. **Fique atento** às nossas redes sociais para ofertas e promoções exclusivas!',
      },
      {
        'question': 'É necessário agendar horário?',
        'answer':
            'Sim, recomendamos que agende seu horário para que possamos atendê-lo da melhor forma possível. Atendemos apenas com agendamento.',
      },
      {
        'question':
            'Onde posso ver alguns dos procedimentos que vocês realizam?',
        'answer':
            'Confira nossos Reels e Stories no Instagram, onde compartilhamos diversos processos e resultados dos procedimentos!',
      },
      {
        'question': 'Quero agendar o meu horário.',
        'answer':
            'Para avaliação personalizada, entre em contato pelo WhatsApp.',
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isDesktop ? 80 : 20),
      color: Colors.white,
      child: Column(
        children: [
          AnimationConfiguration.staggeredList(
            position: 4,
            duration: const Duration(milliseconds: 600),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Column(
                  children: [
                    Text(
                      'Perguntas Frequentes',
                      style: TextStyle(
                        fontSize: isDesktop ? 36 : 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Tire suas principais dúvidas sobre nossos procedimentos',
                      style: TextStyle(
                        fontSize: isDesktop ? 16 : 14,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
          Container(
            constraints: BoxConstraints(
              maxWidth: isDesktop ? 800 : double.infinity,
            ),
            child: AnimationLimiter(
              child: Column(
                children: List.generate(
                  faqs.length,
                  (index) => AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 300),
                    child: SlideAnimation(
                      verticalOffset: 30.0,
                      child: FadeInAnimation(
                        child: _buildFAQItem(
                          faqs[index]['question']!,
                          faqs[index]['answer']!,
                          index,
                          isDesktop,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(
    String question,
    String answer,
    int index,
    bool isDesktop,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: ExpansionTile(
          title: Text(
            question,
            style: TextStyle(
              fontSize: isDesktop ? 16 : 15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          trailing: Icon(
            _expandedStates[index]
                ? Icons.keyboard_arrow_up
                : Icons.keyboard_arrow_down,
            color: const Color(0xFF7C6A58),
          ),
          onExpansionChanged: (expanded) {
            setState(() {
              _expandedStates[index] = expanded;
            });
          },
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(isDesktop ? 20 : 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Color(0xFF7C6A58), width: 2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAnswerText(answer, isDesktop),
                  if (index == 5) // Instagram link
                    const SizedBox(height: 12),
                  if (index == 5)
                    GestureDetector(
                      onTap: () => _launchUrl(
                          'https://www.instagram.com/turmalina.estetica23/'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF7C6A58),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Ver no Instagram',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isDesktop ? 14 : 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (index == 6) // WhatsApp link
                    const SizedBox(height: 12),
                  if (index == 6)
                    GestureDetector(
                      onTap: () => _launchUrl('https://wa.me/5562984332822'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF25D366),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.chat,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Entrar em contato',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isDesktop ? 14 : 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerText(String text, bool isDesktop) {
    final parts = text.split('**');
    List<TextSpan> spans = [];

    for (int i = 0; i < parts.length; i++) {
      if (i % 2 == 0) {
        spans.add(TextSpan(
          text: parts[i],
          style: TextStyle(
            fontSize: isDesktop ? 14 : 13,
            color: Colors.grey[700],
            height: 1.5,
          ),
        ));
      } else {
        spans.add(TextSpan(
          text: parts[i],
          style: TextStyle(
            fontSize: isDesktop ? 14 : 13,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            height: 1.5,
          ),
        ));
      }
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }

  void _openGoogleMaps() {
    const url =
        'https://www.google.com/maps/place/Turmalina+Est%C3%A9tica+%7C+Botox,+Microvasos,+Cicatriz+de+acne,+Limpeza+de+Pele+-+Clinica+de+Est%C3%A9tica+Vila+Bras%C3%ADlia,+Ap+de+Goi%C3%A2nia/@-16.7353645,-49.2639537,17z/data=!4m14!1m7!3m6!1s0x935ef9f167ef7b19:0xb933b1f7e3b338ab!2sTurmalina+Est%C3%A9tica+%7C+Botox,+Microvasos,+Cicatriz+de+acne,+Limpeza+de+Pele+-+Clinica+de+Est%C3%A9tica+Vila+Bras%C3%ADlia,+Ap+de+Goi%C3%A2nia!8m2!3d-16.7353645!4d-49.2639537!16s%2Fg%2F11l22cs525!3m5!1s0x935ef9f167ef7b19:0xb933b1f7e3b338ab!8m2!3d-16.7353645!4d-49.2639537!16s%2Fg%2F11l22cs525?entry=ttu&g_ep=EgoyMDI1MDcyMS4wIKXMDSoASAFQAw%3D%3D';

    if (kIsWeb) {
      html.window.open(url, '_blank');
    } else {
      _launchUrl(url);
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simular envio
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Mensagem enviada com sucesso!'),
            backgroundColor: const Color(0xFF7C6A58),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );

        // Limpar formulário
        _nomeController.clear();
        _emailController.clear();
        _telefoneController.clear();
        _mensagemController.clear();
      }
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _mensagemController.dispose();
    super.dispose();
  }
}
