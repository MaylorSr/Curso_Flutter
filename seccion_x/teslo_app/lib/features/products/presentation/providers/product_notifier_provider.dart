import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../products.dart';
import 'product_repository_provider.dart';

final productsStateNotifierProvider =
    StateNotifierProvider<ProductStateNotifier, ProductsState>(
  (ref) {
    final ProductsRepository productsRepository =
        ref.watch(productsRepositoryProvider);

    return ProductStateNotifier(repository: productsRepository);
  },
);

class ProductStateNotifier extends StateNotifier<ProductsState> {
  final ProductsRepository repository;

  ProductStateNotifier({required this.repository}) : super(ProductsState()) {
    loadNextPage();
  }

  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final products = await repository.getProductsByPage();

    if (products.isEmpty) {
      state = state.copyWith(isLastPage: true, isLoading: false);
      return;
    }

    state = state.copyWith(
      isLastPage: false,
      isLoading: false,
      offset: state.offset + 10,
      //* El state va a ser los products que ya tenemos más los productos nuevos que acabamos de añadir
      products: [...state.products, ...products],
    );
    return;
  }
}

class ProductsState {
  final bool isLastPage, isLoading;

  final int limit, offset;

  final List<Product> products;

  ProductsState({
    this.isLastPage = false,
    this.isLoading = false,
    this.limit = 10,
    this.offset = 0,
    this.products = const [],
  });

  copyWith({
    bool? isLastPage,
    isLoading,
    int? limit,
    offset,
    List<Product>? products,
  }) {
    return ProductsState(
        isLastPage: isLastPage ?? this.isLastPage,
        isLoading: isLoading ?? this.isLoading,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        products: products ?? this.products);
  }
}
