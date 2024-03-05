// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/config/config.dart';

import '../../../shared/shared.dart';
import '../../products.dart';

final productStateNotifierProvider = StateNotifierProvider.autoDispose
    .family<FormProductStateNotifier, ProductFormState, Product>(
  (ref, product) {
    //En este punto estamos llamando a otro provider para ejecutar un metodo suyo.
    final createUpdateCallBack =
        ref.watch(productsStateNotifierProvider.notifier).createOrUpdateProduct;

    return FormProductStateNotifier(
        product: product, onSubmitCallBack: createUpdateCallBack);
  },
);

class FormProductStateNotifier extends StateNotifier<ProductFormState> {
  final Future<bool> Function({required Map<String, dynamic> productLike})?
      onSubmitCallBack;

  FormProductStateNotifier({
    this.onSubmitCallBack,
    required Product product,
  }) : super(ProductFormState()) {
    state = ProductFormState(
      id: product.id,
      description: product.description,
      title: Title.dirty(product.title),
      price: Price.dirty(product.price),
      slug: Slug.dirty(product.slug),
      inStock: Stock.dirty(product.stock),
      gender: product.gender,
      images: product.images,
      sizes: product.sizes,
      tags: product.tags.join(', '),
    );
  }

  Future<bool> onFormSubmit() async {
    _touchedEveryField();
    if (!state.isValid) return false;

    if (onSubmitCallBack == null) return false;

    final productLike = {
      "id": state.id == 'new' ? null : state.id,
      "title": state.title.value,
      "price": state.price.value,
      "description": state.description,
      "slug": state.slug.value,
      "stock": state.inStock.value,
      "sizes": state.sizes,
      "gender": state.gender,
      "tags": state.tags.split(','),
      "images": state.images
          .map(
            (image) =>
                image.replaceAll('${Environment.apiUrl}/files/product/', ''),
          )
          .toList()
    };

    try {
      return await onSubmitCallBack!(productLike: productLike);
    } catch (e) {
      return false;
    }
  }

  void _touchedEveryField() {
    state = state.copyWith(
      isValid: Formz.validate(
        [
          Title.dirty(state.title.value),
          Price.dirty(state.price.value),
          Slug.dirty(state.slug.value),
          Stock.dirty(state.inStock.value),
        ],
      ),
    );
  }

  void onTitleChanged(String value) {
    state = state.copyWith(
      title: Title.dirty(value),
      isValid: Formz.validate(
        [
          Title.dirty(value),
          Price.dirty(state.price.value),
          Slug.dirty(state.slug.value),
          Stock.dirty(state.inStock.value),
        ],
      ),
    );
  }

  void onPriceChanged(double value) {
    state = state.copyWith(
      price: Price.dirty(value),
      isValid: Formz.validate(
        [
          Title.dirty(state.title.value),
          Slug.dirty(state.slug.value),
          Stock.dirty(state.inStock.value),
        ],
      ),
    );
  }

  void onSlugChanged(String value) {
    state = state.copyWith(
      slug: Slug.dirty(value),
      isValid: Formz.validate(
        [
          Title.dirty(state.title.value),
          Price.dirty(state.price.value),
          Slug.dirty(value),
          Stock.dirty(state.inStock.value),
        ],
      ),
    );
  }

  void onStockChanged(int value) {
    state = state.copyWith(
      inStock: Stock.dirty(value),
      isValid: Formz.validate(
        [
          Title.dirty(state.title.value),
          Price.dirty(state.price.value),
          Slug.dirty(state.slug.value),
          Stock.dirty(value),
        ],
      ),
    );
  }

  void onSizeChanged(List<String> value) {
    state = state.copyWith(sizes: value);
  }

  void onGenderChanged(String value) {
    state = state.copyWith(gender: value);
  }

  void onDescriptionChanged(String value) {
    state = state.copyWith(description: value);
  }

  void onTagsChanged(String value) {
    state = state.copyWith(tags: value);
  }
}

class ProductFormState {
  final bool isValid;

  final String? id;

  final Title title;

  final Slug slug;

  final Price price;

  final List<String> sizes;

  final String gender;

  final Stock inStock;

  final String description;

  final String tags;

  final List<String> images;

  ProductFormState({
    this.isValid = false,
    this.id,
    this.title = const Title.pure(),
    this.slug = const Slug.pure(),
    this.price = const Price.pure(),
    this.sizes = const [],
    this.gender = 'men',
    this.inStock = const Stock.pure(),
    this.description = '',
    this.tags = '',
    this.images = const [],
  });

  ProductFormState copyWith({
    bool? isValid,
    String? id,
    Title? title,
    Slug? slug,
    Price? price,
    List<String>? sizes,
    String? gender,
    Stock? inStock,
    String? description,
    String? tags,
    List<String>? images,
  }) {
    return ProductFormState(
      isValid: isValid ?? this.isValid,
      id: id ?? this.id,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      price: price ?? this.price,
      sizes: sizes ?? this.sizes,
      gender: gender ?? this.gender,
      inStock: inStock ?? this.inStock,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      images: images ?? this.images,
    );
  }
}
