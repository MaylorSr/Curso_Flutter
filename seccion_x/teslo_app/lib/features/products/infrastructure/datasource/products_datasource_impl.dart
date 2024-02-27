import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/products/domain/products_domain.dart';
import 'package:teslo_shop/features/products/infrastructure/products_infrastructure.dart';

class ProductsDataSourceImpl extends ProductsDataSources {
  late final Dio dio;
  final String accesToken;

  ProductsDataSourceImpl({required this.accesToken})
      : dio = DioRest.dioProducts(
          accesToken: accesToken,
        );

  @override
  Future<Product> createUpdateProduct(
      {required Map<String, dynamic> productLike}) {
    // TODO: implement createUpdateProduct
    throw UnimplementedError();
  }

  @override
  Future<Product> getProductById({required String id}) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProductsByPage(
      {int limit = 10, int offset = 0}) async {
    final response = await dio
        .get<List>('${Environment.getProducts}?limit=$limit&offset=$offset');

    final List<Product> products = [];

    for (var product in (response.data ?? [])) {
      final productResponse = ProductMapper.jsonToEntity(product);
      products.add(productResponse);
    }

    return products;
  }

  @override
  Future<List<Product>> getProductsBySearch({required String term}) {
    // TODO: implement getProductsBySearch
    throw UnimplementedError();
  }
}
