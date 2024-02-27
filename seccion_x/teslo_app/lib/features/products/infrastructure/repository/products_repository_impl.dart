import 'package:teslo_shop/features/products/domain/products_domain.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  final ProductsDataSources dataSources;

  ProductsRepositoryImpl({required this.dataSources});

  @override
  Future<Product> createUpdateProduct(
      {required Map<String, dynamic> productLike}) {
    return dataSources.createUpdateProduct(productLike: productLike);
  }

  @override
  Future<Product> getProductById({required String id}) {
    return dataSources.getProductById(id: id);
  }

  @override
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 0}) {
    return dataSources.getProductsByPage(limit: limit, offset: offset);
  }

  @override
  Future<List<Product>> getProductsBySearch({required String term}) {
    return getProductsBySearch(term: term);
  }
}
