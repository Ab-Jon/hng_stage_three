import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Load 3D'),
        ),
        body: const Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  double model_spacing = 1.0;
  double female_rotation = 180.0;
  double male_rotation = 0.0;


  void moveModelCloser(){
    setState(() {
      if (model_spacing > 0.5) model_spacing -= 0.2;
    });
  }
  void moveModelsApart(){
    setState(() {
      if(model_spacing < 2.0) model_spacing += 0.2;
    });
  }

  void rotateFemale(){
    setState(() {
      female_rotation = (female_rotation + 15) % 360;
    });
  }

  void rotateMale(){
    setState(() {
      male_rotation = (male_rotation + 15) % 360;
    });
  }

  void resetModels(){
    setState(() {
      model_spacing = 1.0;
      female_rotation = 180.0;
      male_rotation = 0.0;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Expanded(
            child: Row(
                children: [
                  Expanded(
                    child: ModelViewer(
                      src: 'assets/avatar_female.glb',
                      backgroundColor: Colors.white,
                      autoPlay: true,
                      autoRotate: false,
                      ar: true,
                      cameraOrbit: "$female_rotation deg",
                      cameraTarget: "${-model_spacing}m 1m 0m",
                    ),
                  ),
                  Expanded(
                    child: ModelViewer(
                      src: 'assets/avatar_male.glb',
                      backgroundColor: Colors.white,
                      autoPlay: true,
                      autoRotate: false,
                      ar: true,
                      cameraOrbit: "$male_rotation deg",
                      cameraTarget: "${model_spacing}m 1m 0m",
                    ),
                  ),
                ]
            ),
          ),
          //Controls
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: moveModelCloser,
                        child: const Icon(Icons.arrow_forward)),
                    ElevatedButton(
                        onPressed: moveModelsApart,
                        child: const Icon(Icons.arrow_back))
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: rotateFemale,
                        child: const Icon(Icons.female)),
                    ElevatedButton(
                        onPressed: rotateMale,
                        child: const Icon(Icons.male)),
                    ElevatedButton(
                      onPressed: resetModels,
                      child: const Icon(Icons.restore),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),)
                  ],
                )
              ],
            ),)
        ]
    );

  }
}