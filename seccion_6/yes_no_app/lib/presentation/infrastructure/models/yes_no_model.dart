import 'package:yes_no_app/presentation/domain/entities/message.dart';

const jAnswer = 'answer';
const jForced = 'forced';
const jImage = 'image';

class YesNoModel {
  final String answer;
  final bool forced;
  final String image;

  YesNoModel({
    required this.answer,
    required this.forced,
    required this.image,
  });

  factory YesNoModel.fromJsonMap(Map<String, dynamic> json) => YesNoModel(
        answer: json[jAnswer],
        forced: json[jForced],
        image: json[jImage],
      );

  // Para convertirlo en map en vez de hacer lo contrario
  Map<String, dynamic> toJson() => {
        jAnswer: answer,
        jForced: forced,
        jImage: image,
      };

  Message toMessageEntity() => Message(
      text: answer == 'Yes' ? 'Si' : 'No',
      fromWho: FromWho.hers,
      imageUrl: image);
}
