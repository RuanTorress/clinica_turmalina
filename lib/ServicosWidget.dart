import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ServicosWidget extends StatefulWidget {
  const ServicosWidget({super.key});

  @override
  State<ServicosWidget> createState() => _ServicosWidgetState();
}

class _ServicosWidgetState extends State<ServicosWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 768;

    final servicosData = {
      'facial': {
        'title': 'Estética Facial',
        'icon': Icons.face_outlined,
        'services': [
          {
            'name': 'Limpeza de Pele Premium',
            'description': 'Tratamento profundo de limpeza e renovação',
          },
          {
            'name': 'Rejuvenescimento',
            'description': 'Procedimentos anti-idade avançados',
          },
          {
            'name': 'Peeling Químico',
            'description': 'Renovação celular controlada',
          },
          {
            'name': 'Peeling de Diamante',
            'description': 'Microdermoabrasão com cristais',
          },
          {
            'name': 'Aplicação de Botox',
            'description': 'Redução de rugas e linhas de expressão',
          },
          {
            'name': 'Melasma',
            'description': 'Tratamento para manchas e hiperpigmentação',
          },
          {
            'name': 'Microagulhamento',
            'description': 'Estimulação do colágeno natural',
          },
          {
            'name': 'Cicatriz de acne e acne ativa',
            'description': 'Tratamento completo para acne',
          },
          {
            'name': 'Tratamento para olheiras',
            'description': 'Redução de olheiras e inchaço',
          },
          {
            'name': 'Skinbooster',
            'description': 'Hidratação profunda da pele',
          },
          {
            'name': 'Lipo de papada enzimática',
            'description': 'Redução não invasiva de gordura',
          },
        ],
      },
      'corporal': {
        'title': 'Estética Corporal',
        'icon': Icons.fitness_center_outlined,
        'services': [
          {
            'name': 'Corrente Russa',
            'description': 'Fortalecimento muscular com eletroestimulação',
          },
          {
            'name': 'Endermologia',
            'description': 'Massagem mecânica para celulite',
          },
          {
            'name': 'Ventosaterapia',
            'description': 'Terapia com ventosas para drenagem',
          },
          {
            'name': 'Massagem Modeladora',
            'description': 'Modelagem corporal manual',
          },
          {
            'name': 'Massagem Relaxante',
            'description': 'Relaxamento e bem-estar',
          },
          {
            'name': 'Drenagem Linfática',
            'description': 'Redução de inchaço e retenção',
          },
          {
            'name': 'Enzimas Corporais',
            'description': 'Tratamento enzimático para gordura',
          },
          {
            'name': 'Tratamentos para Gordura Localizada',
            'description': 'Redução de medidas direcionada',
          },
          {
            'name': 'Tratamentos para Estrias, Flacidez e Celulite',
            'description': 'Melhora da textura e firmeza da pele',
          },
          {
            'name': 'PEIM (Aplicação em Microvasos)',
            'description': 'Tratamento para vasinhos e microvasos',
          },
          {
            'name': 'Método Empina Bumbum',
            'description': 'Modelagem e lifting dos glúteos',
          },
          {
            'name': 'Terapia Capilar',
            'description': 'Tratamentos para couro cabeludo e cabelos',
          },
          {
            'name': 'Pós-Operatório',
            'description': 'Recuperação e cicatrização pós-cirúrgica',
          },
        ],
      },
    };

    return Container(
      padding: EdgeInsets.all(isDesktop ? 80 : 20),
      color: Colors.grey[50],
      child: Column(
        children: [
          Text(
            'Nossos Serviços',
            style: TextStyle(
              fontSize: isDesktop ? 42 : 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Oferecemos uma ampla gama de tratamentos estéticos especializados',
            style: TextStyle(
              fontSize: isDesktop ? 18 : 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          _buildTabBar(isDesktop),
          const SizedBox(height: 30),
          _buildTabBarView(servicosData, isDesktop),
        ],
      ),
    );
  }

  Widget _buildTabBar(bool isDesktop) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[600],
        indicator: BoxDecoration(
          color: const Color(0xFF7C6A58),
          borderRadius: BorderRadius.circular(12),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: isDesktop ? 16 : 14,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: isDesktop ? 16 : 14,
        ),
        tabs: [
          Tab(
            height: isDesktop ? 60 : 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.face_outlined, size: isDesktop ? 24 : 20),
                const SizedBox(width: 8),
                Flexible(
                    child: Text('Estética Facial',
                        overflow: TextOverflow.ellipsis)),
              ],
            ),
          ),
          Tab(
            height: isDesktop ? 60 : 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.fitness_center_outlined, size: isDesktop ? 24 : 20),
                const SizedBox(width: 8),
                Flexible(
                    child: Text('Estética Corporal',
                        overflow: TextOverflow.ellipsis)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBarView(Map<String, dynamic> servicosData, bool isDesktop) {
    return Container(
      height: isDesktop ? 600 : 500,
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildServicesList(servicosData['facial']['services'], isDesktop),
          _buildServicesList(servicosData['corporal']['services'], isDesktop),
        ],
      ),
    );
  }

  Widget _buildServicesList(List<dynamic> services, bool isDesktop) {
    return AnimationLimiter(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 10),
        itemCount: services.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 400),
            child: SlideAnimation(
              verticalOffset: 30.0,
              child: FadeInAnimation(
                child: _buildServiceCard(services[index], isDesktop),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service, bool isDesktop) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(isDesktop ? 24 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: isDesktop ? 12 : 10,
            height: isDesktop ? 12 : 10,
            decoration: const BoxDecoration(
              color: Color(0xFF7C6A58),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service['name'],
                  style: TextStyle(
                    fontSize: isDesktop ? 18 : 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (service['description'] != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      service['description'],
                      style: TextStyle(
                        fontSize: isDesktop ? 15 : 13,
                        color: Colors.grey[600],
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: isDesktop ? 16 : 14,
            color: Colors.grey[400],
          ),
        ],
      ),
    );
  }
}
