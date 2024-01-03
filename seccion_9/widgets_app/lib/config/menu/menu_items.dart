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
];
