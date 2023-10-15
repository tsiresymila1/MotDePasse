import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:motdepasse/presentation/widgets/counter.dart';
import 'package:motdepasse/presentation/widgets/storage.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    controller.text = context.storage.read<String>("duration") ?? "3";
    return Container(
      padding: const EdgeInsets.only(top: 20),
      color: Colors.deepOrange.withOpacity(1),
      child: Scaffold(
        backgroundColor: Colors.deepOrange.withOpacity(0.8),
        appBar: AppBar(
          leading: const BackButton(),
          backgroundColor: Colors.transparent,
          title: const Text(
            "Settings",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                leading: const Text(
                  "Duration (minutes)",
                  style: TextStyle(fontSize: 16),
                ),
                trailing: Counter(
                  initialState: int.parse(
                      context.storage.read<String>("duration") ?? "3"),
                  onChanged: (int value) {
                    context.storage.write("duration", value.toString());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
