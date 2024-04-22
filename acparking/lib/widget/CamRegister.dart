// ignore_for_file: unnecessary_null_comparison, file_names, override_on_non_overriding_member, use_build_context_synchronously

import 'dart:io';
//import 'package:acparking/widget/Pconfi.dart';
import 'package:acparking/widget/resul_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:permission_handler/permission_handler.dart';

class CamRegister extends StatefulWidget {
  const CamRegister({super.key});
  @override
  State<CamRegister> createState() => _CamRegisterState();
}

class Controlcamera extends GetxController {
  bool _isGranted = false;
  late final Future<void> _future;
  CameraController? _cameraController;
  final textRecognizer = TextRecognizer();
  late final String text;
}

class _CamRegisterState extends State<CamRegister> with WidgetsBindingObserver {
  final controlador = Get.put(Controlcamera());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this as WidgetsBindingObserver);
    controlador._future = _requestCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this as WidgetsBindingObserver);
    stopCamera();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (controlador._cameraController == null ||
        !controlador._cameraController!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      stopCamera();
    } else if (state == AppLifecycleState.resumed &&
        controlador._cameraController != null &&
        controlador._cameraController!.value.isInitialized) {
      startCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: controlador._future,
      builder: (context, snapshot) {
        return Stack(
          children: [
            if (controlador._isGranted)
              FutureBuilder<List<CameraDescription>>(
                future: availableCameras(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _initCameraController(snapshot.data!);
                    return Center(
                        child: CameraPreview(controlador._cameraController!));
                  } else {
                    return const LinearProgressIndicator();
                  }
                },
              ),
            Container(
                child: controlador._isGranted
                    ? Column(
                        children: [
                          Expanded(child: Container()),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: ElevatedButton(
                              onPressed: _scan,
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(20),
                                backgroundColor:
                                    Colors.green, // <-- Button color
                                foregroundColor:
                                    Colors.blueGrey, // <-- Splash color
                              ),
                              child: const Icon(
                                Icons.camera_front,
                                color: Colors.white,
                                size: 70,
                              ),
                            ),
                          )
                        ],
                      )
                    : const Center(
                        child: Text('Actualizar Permisos'),
                      ))
          ],
        );
      },
    ));
  }

  Future<void> _requestCamera() async {
    final status = await Permission.camera.request();
    controlador._isGranted = status == PermissionStatus.granted;
  }

  void startCamera() {
    if (CameraController != null) {
      _selectedCamera(controlador._cameraController!.description);
    }
  }

  void stopCamera() {
    if (CameraController != null) {
      controlador._cameraController!.dispose();
    }
  }

  void _initCameraController(List<CameraDescription> cameras) {
    if (controlador._cameraController != null) {
      return;
    }
    CameraDescription? camera;
    for (var i = 0; 1 < cameras.length; i++) {
      final CameraDescription current = cameras[i];
      if (current.lensDirection == CameraLensDirection.back) {
        camera = current;
        break;
      }
    }

    if (camera != null) {
      _selectedCamera(camera);
    }
  }

  Future<void> _selectedCamera(CameraDescription camera) async {
    controlador._cameraController =
        CameraController(camera, ResolutionPreset.max, enableAudio: false);
    await controlador._cameraController!.initialize();
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _scan() async {
    if (controlador._cameraController == null) return;
    final navigator = Navigator.of(context);
    try {
      final picture = await controlador._cameraController!.takePicture();
      final file = File(picture.path);
      final inputImage = InputImage.fromFile(file);
      final recognizerText =
          await controlador.textRecognizer.processImage(inputImage);
      await navigator.push(MaterialPageRoute(
        builder: (context) => ResultPage(text: recognizerText.text),
      ));
      if (kDebugMode) {
        print(controlador.textRecognizer);
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
