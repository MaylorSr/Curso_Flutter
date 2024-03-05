// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../products.dart';

final productProvider = StateNotifierProvider.family
    .autoDispose<ProductStateNotifier, ProductState, String>(
  (ref, String id) {
    final productsRepository = ref.watch(productsRepositoryProvider);

    return ProductStateNotifier(
      productsRepository: productsRepository,
      productId: id,
    );
  },
);

class ProductStateNotifier extends StateNotifier<ProductState> {
  final ProductsRepository productsRepository;

  ProductStateNotifier(
      {required this.productsRepository, required String productId})
      : super(
          ProductState(id: productId),
        ) {
    loadProduct();
  }

  Product newEmptyProduct() {
    return Product(
      id: 'new',
      title: '',
      description: '',
      price: 0.0,
      gender: "",
      slug: "",
      stock: 0,
      tags: const [],
      images: const [],
      sizes: const [],
    );
  }

  Future<void> loadProduct() async {
    try {
      final Product product;
      
      if (state.id != "new") {
        product = await productsRepository.getProductById(
          id: state.id,
        );
      } else {
        product = newEmptyProduct();
      }

      state = state.copyWith(
        isLoading: false,
        product: product,
      );
    } catch (e) {
      print(e);
    }
  }
}

class ProductState {
  final String id;

  final Product? product;

  final bool isLoading;

  final bool isSaving;

  ProductState({
    required this.id,
    this.product,
    this.isLoading = true,
    this.isSaving = false,
  });

  ProductState copyWith({
    //! Realmente no se cuando vaya a cambiar el id, de todas maneras no seria conveniente que se cambie este.
    String? id,
    Product? product,
    bool? isLoading,
    bool? isSaving,
  }) {
    return ProductState(
      id: id ?? this.id,
      product: product ?? this.product,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
    );
  }

  @override
  bool operator ==(covariant ProductState other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.product == product &&
        other.isLoading == isLoading &&
        other.isSaving == isSaving;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        product.hashCode ^
        isLoading.hashCode ^
        isSaving.hashCode;
  }

  @override
  String toString() {
    return 'ProductState(id: $id, product: $product, isLoading: $isLoading, isSaving: $isSaving)';
  }
}
