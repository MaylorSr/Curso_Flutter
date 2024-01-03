import 'package:flutter/material.dart';

class MenuItem {
  final String tittle, subTitle, link;
  final IconData icon;

  MenuItem(
      {required this.tittle,
      required this.subTitle,
      required this.link,
      required this.icon});
}

List<MenuItem> appMenuItems = <MenuItem>[
  MenuItem(
    tittle: 'Botones',
    subTitle: 'Varios botones de Flutter',
    link: '/buttons',
    icon: Icons.smart_button_outlined,
  ),
  MenuItem(
    tittle: 'Tarjetas',
    subTitle: 'Un contenedor con estilo',
    link: '/cards',
    icon: Icons.credit_card,
  ),
  MenuItem(
    tittle: 'Progress indicators',
    subTitle: 'Generales y Controlados',
    link: '/progress',
    icon: Icons.refresh_rounded,
  ),
  MenuItem(
    tittle: 'Snackbars y dialogos',
    subTitle: 'Snackbars en pantalla',
    link: '/snackbars',
    icon: Icons.info_outline,
  ),
  MenuItem(
    tittle: 'Animated container',
    subTitle: 'Staful widget animado',
    link: '/animated',
    icon: Icons.check_box_outline_blank_rounded,
  ),
  MenuItem(
    tittle: 'UI Controls',
    subTitle: 'Una serie de controles.',
    link: '/ui-controls',
    icon: Icons.car_rental_outlined,
  ),
  MenuItem(
    tittle: 'Tutorial',
    subTitle: 'Tutorial de mi app.',
    link: '/tutorial',
    icon: Icons.accessible_rounded,
  ),
  MenuItem(
    tittle: 'Infinite scroll y Pull',
    subTitle: 'Listas infinitas y pull refresh.',
    link: '/infinite',
    icon: Icons.list_alt_rounded,
  ),
  MenuItem(
    tittle: 'Counter Screen',
    subTitle: 'Page para incrementar el counter con riverpod.',
    link: '/counter',
    icon: Icons.add,
  ),
  MenuItem(
    tittle: 'Theme Changer Screen',
    subTitle: 'Page cambiar el tema de la app.',
    link: '/theme-changer',
    icon: Icons.mode_night_outlined,
  ),
];
