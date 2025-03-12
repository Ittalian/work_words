import 'package:flutter/material.dart';
import 'package:work_words/config/routes.dart';
import 'package:work_words/models/word.dart';
import 'package:work_words/services/word_memorize_service.dart';
import 'package:work_words/views/widgets/base/base_button.dart';
import 'package:work_words/views/widgets/base/base_image_container.dart';
import 'package:work_words/views/widgets/loading/loading_dialog.dart';

class MemorizeStart extends StatefulWidget {
  final List<String> categories;

  const MemorizeStart({
    super.key,
    required this.categories,
  });

  @override
  State<MemorizeStart> createState() => MemorizeStartState();
}

class MemorizeStartState extends State<MemorizeStart> {
  TextEditingController countController = TextEditingController();
  String category = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      category = widget.categories.first;
    });
  }

  void moveMemorize(BuildContext context, List<Word> words, int questionCount) {
    Navigator.pushNamed(
      context,
      Routes.memorize,
      arguments: {
        'words': words,
        'questionCount': questionCount,
      },
    );
  }

  void setCategory(String value) {
    setState(() {
      category = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseImageContainer(
      imagePath: 'images/memorize_start.jpg',
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.white.withOpacity(0.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '問題数',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(120, 0, 120, 30),
                        child: TextField(
                          controller: countController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Text(
                        'カテゴリ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        color: Colors.white.withOpacity(0.5),
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.fromLTRB(19, 0, 10, 0),
                        child: DropdownButton<String>(
                          value: category,
                          items: widget.categories.map((String category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                          onChanged: (value) => setCategory(value!),
                        ),
                      ),
                      const SizedBox(height: 20),
                      BaseButton(
                        label: '開始',
                        onPressed: () async {
                          await LoadingDialog.show(context, 'テストを始めます');
                          List<Word> words =
                              await WordMemorizeService().fetchWords(category);
                          int questionCount = countController.text.isEmpty
                              ? words.length
                              : int.tryParse(countController.text) ??
                                  words.length;
                          await LoadingDialog.hide(context);
                          moveMemorize(
                            context,
                            words,
                            questionCount,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
