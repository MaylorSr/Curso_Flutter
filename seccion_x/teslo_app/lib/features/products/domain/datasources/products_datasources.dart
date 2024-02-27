
import 'package:teslo_shop/features/products/domain/products_domain.dart';

abstract class ProductsDataSources {
  Future<Product> getProductById({required String id});
  
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 0});
  
  Future<List<Product>> getProductsBySearch({required String term});

  Future<Product> createUpdateProduct({required Map<String, dynamic> productLike});
}
