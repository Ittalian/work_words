import 'package:flutter/material.dart';
import 'package:work_words/config/routes.dart';
import 'package:work_words/services/category_memorize_service.dart';
import 'package:work_words/views/widgets/base/base_button.dart';
import 'package:work_words/views/widgets/base/base_image_container.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseImageContainer(
      imagePath: 'images/home.jpg',
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0),
        body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BaseButton(
              label: 'テストを始める',
              onPressed: () async {
                List<String> categories = await fetchCategories();
                moveMemorizeStart(context, categories);
              },
            ),
          ],
        ),
      ),),
    );
  }

  Future<List<String>> fetchCategories() async {
    return await CategoryMemorizeService().fetchCategories();
  }

  void moveMemorizeStart(BuildContext context, List<String> categories) {
    Navigator.pushNamed(
      context,
      Routes.memorizeStart,
      arguments: {
        'categories': categories,
      },
    );
  }
}
