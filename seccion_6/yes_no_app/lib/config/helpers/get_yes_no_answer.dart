import 'package:dio/dio.dart';
import 'package:yes_no_app/presentation/domain/entities/message.dart';
import 'package:yes_no_app/presentation/infrastructure/models/yes_no_model.dart';

class GetYesNoAnswer {
  final _dio = Dio();

  Future<Message> getAnswer() async {
    final response = await _dio.get('https://yesno.wtf/api');

    return YesNoModel.fromJsonMap(response.data).toMessageEntity();
  }
}
