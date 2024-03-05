import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_shop/features/shared/shared.dart';

import '../../products.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: const _ProductsView(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nuevo producto'),
        icon: const Icon(Icons.add),
        onPressed: () {
          context.push('/product/new');
        },
      ),
    );
  }
}

class _ProductsView extends ConsumerStatefulWidget {
  const _ProductsView();

  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends ConsumerState<_ProductsView> {
  void loadMoreProducts() {
    ref.read(productsStateNotifierProvider.notifier).loadNextPage();
  }

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    //* 400 píxeles de margen

    _controller.addListener(
      () {
        if (_controller.position.pixels + 400 >=
            _controller.position.maxScrollExtent) {
          loadMoreProducts();
        }
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final List<Product> products =
        ref.watch(productsStateNotifierProvider).products;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Expanded(
            child: MasonryGridView.count(
              controller: _controller,
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 35,
              physics: const BouncingScrollPhysics(),
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                final Product product = products[index];
                return GestureDetector(
                  onTap: () => context.push(
                    '/product/${product.id}',
                  ),
                  child: ProductCard(product: product),
                );
              },
            ),
          ),
          CustomSizedBox(
            heigth: size.height * 0.1,
          )
        ],
      ),
    );
  }
}
