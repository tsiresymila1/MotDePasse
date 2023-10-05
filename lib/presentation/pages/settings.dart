import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:motdepasse/presentation/widgets/storage.dart';
import 'package:motdepasse/presentation/widgets/switch.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    final formDeleteKey = GlobalKey<FormBuilderState>();
    List<String> words = (context.storage.read<List<dynamic>>("words") ?? [])
        .map((e) => e.toString())
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FormBuilder(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  FormBuilderTextField(
                    name: "word",
                    decoration: const InputDecoration(hintText: "Add new word"),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        formKey.currentState?.save();
                        words.add(formKey.currentState?.value["word"]);
                        context.storage.write("words", words);
                        setState(() {});
                      },
                      child: const Text("Save"))
                ],
              ),
            ),
            FormBuilder(
              key: formDeleteKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  FormBuilderTextField(
                    name: "word",
                    decoration: const InputDecoration(
                        hintText: "Delete words ( separated by ;)"),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        formDeleteKey.currentState?.save();
                        context.storage.write(
                            "words",
                            words
                                .where((element) => !(formDeleteKey
                                            .currentState?.value["word"]
                                            .toString()
                                            .trim()
                                            .split(";") ??
                                        [])
                                    .contains(element))
                                .toList());
                        setState(() {});
                      },
                      child: const Text("Delete"))
                ],
              ),
            ),
            ListTile(
              title: const Text("From saved words"),
              trailing: SwitchWidget(
                  initialState: context.storage.read<bool>("saved") ?? false,
                  onChanged: (e) {
                    context.storage.write("saved", e);
                  }),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: words.length,
                    itemBuilder: (context, index) {
                      String current = words[index];
                      return ListTile(
                        title: Text(current),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
