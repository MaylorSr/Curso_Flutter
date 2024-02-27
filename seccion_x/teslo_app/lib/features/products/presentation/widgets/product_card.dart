import 'package:flutter/widgets.dart';
import 'package:teslo_shop/features/products/products.dart';
import 'package:teslo_shop/features/shared/shared.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //* Imágen
        _ImageViewer(images: product.images),

        //* Title
        Text(
          product.title,
          textAlign: TextAlign.center,
        ),
        const CustomSizedBox(
          heigth: 20,
        ),
      ],
    );
  }
}

class _ImageViewer extends StatelessWidget {
  final List<String> images;
  const _ImageViewer({required this.images});

  @override
  Widget build(BuildContext context) {
    //*Propiedades de la imágen en común
    const boxFit = BoxFit.cover;
    const double heigthImage = 250;

    if (images.isEmpty) {
      return CustomClipRReact(
        child: Image.asset(
          'assets/images/no-image.jpg',
          height: heigthImage,
          fit: boxFit,
        ),
      );
    }
    return CustomClipRReact(
      child: FadeInImage(
        placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
        image: NetworkImage(images.first),
        height: heigthImage,
        fit: boxFit,
        fadeOutDuration: const Duration(milliseconds: 100),
        fadeInDuration: const Duration(milliseconds: 200),
      ),
    );
  }
}
