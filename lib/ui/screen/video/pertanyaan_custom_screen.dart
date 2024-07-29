import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wawancara_ai/data/cubit/pertanyaan/cubit/pertanyaan_cubit.dart';
import 'package:wawancara_ai/ui/screen/video/countdown_screen.dart';
import 'package:wawancara_ai/ui/widget/button/primary_button.dart';
import 'package:wawancara_ai/ui/widget/text_field/text_field_widget.dart';
import 'package:wawancara_ai/utils/assets.dart';
import 'package:wawancara_ai/utils/typography.dart';

class PertanyaanCustom extends StatefulWidget {
  const PertanyaanCustom({super.key});

  @override
  State<PertanyaanCustom> createState() => _PertanyaanCustomState();
}

class _PertanyaanCustomState extends State<PertanyaanCustom> {
  final TextEditingController _pertanyaanController = TextEditingController();
  final TextEditingController _durasiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PertanyaanCubit(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    img_walkthrough_3,
                    height: 250,
                  ),
                  const Text("Buat Pertanyaan", style: overpassBlack3010),
                  TextFieldwidget(
                      hintText: "Pertanyaan*",
                      controller: _pertanyaanController,
                      onChanged: (value) {
                        setState(() {});
                      }),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          child: TextFieldwidget(
                              hintText: "Durasi*",
                              controller: _durasiController,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {});
                              })),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
          child: ButtonWidget(
              dataFilled: _pertanyaanController.text.isNotEmpty && _durasiController.text.isNotEmpty,
              text: "Mulai",
              onPressed: () {
                Navigator.pushNamed(context, CountScreen.routename, arguments: true);
                context.read<PertanyaanCubit>().updatePertanyaanAndDurasi(_pertanyaanController.text, int.parse(_durasiController.text), "custom");
              }),
        ),
      ),
    );
  }
}
