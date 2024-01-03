import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktik/config/theme/app_theme.dart';
import 'package:toktik/infrastructure/datasources/local_video_datasource_impl.dart';
import 'package:toktik/infrastructure/repositories/video_post_repository_impl.dart';
import 'package:toktik/presentation/providers/discover_provider.dart';
import 'package:toktik/presentation/screens/discover/discover_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repo =
        VideoPostRepositoryImpl(videoPostDataSource: LocalVideoDatasource());
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          // cuando se cree el objeto, se inicia la llamada a la instancia
          lazy: false,
          // .. operador de cascada, es
          create: (_) => DiscoverProvider(reporitory: repo)..loadNextPage(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme().getTheme(),
        title: 'Tok Tik',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Tok Tik'),
          ),
          body: const DiscoverScreen(),
        ),
      ),
    );
  }
}
