import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/exceptions/request_exception_data.dart';
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
      {required Map<String, dynamic> productLike}) async {
    //* Para saber si tengo que actualizar o crear el producto es por el id cuando me venga el product, ya que si lo creo no establezco el id

    try {
      final String? id = productLike['id'];
      final String method = id == null ? 'POST' : 'PATCH';
      final String url = id == null ? '/post' : '/products/$id';

      productLike.remove('id');

      final response = await dio.request(
        url,
        data: productLike,
        options: Options(
          method: method,
        ),
      );
      final product = ProductMapper.jsonToEntity(response.data);
      return product;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Product> getProductById({required String id}) async {
    try {
      final response = await dio.get("${Environment.getProductById}$id");

      final Product product = ProductMapper.jsonToEntity(response.data);

      return product;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw NotFoundException(
            statusCode: 404, errMessage: "El id: $id no existe.");
      }
      throw Exception;
    } catch (e) {
      print(e);
      throw Exception();
    }
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
