import 'package:design_review_devtools_extension/models/home_page_state.dart';
import 'package:design_review_devtools_extension/widgets/double_value_widget.dart';
import 'package:design_review_devtools_extension/widgets/opacity_widget.dart';
import 'package:design_review_devtools_extension/widgets/padding_widget.dart';
import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:devtools_app_shared/ui.dart' as ui;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DevToolsExtension(child: const MyHomePage(title: 'Design review'));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HomePageState state = HomePageState();
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: state.hasImage
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  Image.memory(
                    state.image!,
                    width: 100,
                  ),
                  PaddingWidget(
                    horizonal: state.horizontalOffset,
                    vertical: state.verticalOffset,
                    onChanged: (h, v) {
                      final update = HomePageState(
                        image: state.image,
                        horizontalOffset: h,
                        verticalOffset: v,
                        opacity: state.opacity,
                        scale: state.scale,
                      );
                      setState(() {
                        state = update;
                      });
                      _send(update);
                    },
                  ),
                  OpacityWidget(
                    state.opacity,
                    onChanged: (p0) {
                      final update = HomePageState(
                        image: state.image,
                        horizontalOffset: state.horizontalOffset,
                        verticalOffset: state.verticalOffset,
                        opacity: p0,
                        scale: state.scale,
                      );

                      setState(() {
                        state = update;
                      });
                      _send(update);
                    },
                  ),
                  DoubleValueWidget(
                    'scale',
                    fallbackValue: 1,
                    value: state.scale,
                    isSigned: true,
                    label: 'if image looks incorrect try to change scale.',
                    onChanged: (p0) {
                      final update = HomePageState(
                        image: state.image,
                        horizontalOffset: state.horizontalOffset,
                        verticalOffset: state.verticalOffset,
                        opacity: state.opacity,
                        scale: p0,
                      );

                      setState(() {
                        state = update;
                      });
                      _send(update);
                    },
                  ),
                  if (state != HomePageState())
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 12,
                      children: [
                        ui.DevToolsButton(
                          onPressed: () {
                            setState(() {
                              state = HomePageState();
                            });
                            _send(HomePageState());
                          },
                          icon: Icons.clear,
                          label: 'Reset',
                        ),
                        if (state.hasImage)
                          ui.DevToolsButton(
                            onPressed: () {
                              _send(state);
                            },
                            icon: Icons.done,
                            label: 'Apply',
                          ),
                      ],
                    ),
                ],
              )
            : Column(
                children: [
                  ui.DevToolsButton(
                    onPressed: () {
                      _pickImage();
                    },
                    icon: Icons.image,
                    label: 'Select image',
                  ),
                ],
              ));
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() {
        state = HomePageState(
          image: bytes,
          horizontalOffset: state.horizontalOffset,
          verticalOffset: state.verticalOffset,
          opacity: state.opacity,
        );
      });
    }
  }

  Future<void> _send(HomePageState value) async {
    await serviceManager.callServiceExtensionOnMainIsolate(
      'ext.design_review.comparescreen',
      args: value.toJson(),
    );
  }
}
