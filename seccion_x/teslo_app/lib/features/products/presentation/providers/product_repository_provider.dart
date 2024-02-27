import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/products/domain/products_domain.dart';
import 'package:teslo_shop/features/products/infrastructure/products_infrastructure.dart';

final productsRepositoryProvider = Provider<ProductsRepository>(
  (ref) {
    final productsRepository = ProductsRepositoryImpl(
      dataSources: ProductsDataSourceImpl(
        accesToken: ref.watch(authProvider).user?.token ?? '',
      ),
    );
    return productsRepository;
  },
);

