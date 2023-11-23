import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 225, 221, 221),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    _currentPage = value;
                  });
                },
                children: const [
                  OnBoardingScreen(
                    heading: 'Conectando la ciudad',
                    headingText: 'EnrutaTec ',
                    image: AssetImage('images/rutona.jpg'),
                    paragraph:
                        '¿Te has preguntado alguna vez si hay una manera más eficiente de planificar tus rutas de camiones? ¡La respuesta es sí, y la solución está en EnrutaTec',
                    subheading: 'Tu mejor opcion',
                  ),
                  OnBoardingScreen(
                    heading: 'Conectando la ciudad',
                    headingText: 'EnrutaTec',
                    image: AssetImage('images/trocon.jpg'),
                    paragraph:
                        'No te conformes con las rutas convencionales. Con EnrutaTec, cada viaje se convierte en una experiencia más eficiente y libre de complicaciones.',
                    subheading: 'Disfruta de una nueva experiencia',
                  ),
                  OnBoardingScreen(
                    heading: 'Conectando la ciudad',
                    headingText: 'EnrutaTec',
                    image: AssetImage('images/tecno.png'),
                    paragraph:
                        'EnrutaTec es fácil de usar, con una interfaz intuitiva que te permite planificar tus rutas con unos pocos toques en la pantalla.',
                    subheading: 'Planifica tus rutas de manera eficiente',
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                  height: 40,
                  width: 100,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor:
                              const Color.fromARGB(255, 246, 87, 8)),
                      child: const Text("Inicio"))),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 12,
              child: ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 12,
                      width: 12,
                      margin: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: _currentPage == index
                              ? Colors.white
                              : const Color.fromARGB(255, 85, 85, 85),
                          borderRadius: BorderRadius.circular(50)),
                    );
                  }),
            )
          ],
        ));
  }
}

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen(
      {super.key,
      required this.image,
      required this.heading,
      required this.subheading,
      required this.paragraph,
      required this.headingText});

  final ImageProvider image;
  final String heading;
  final String subheading;
  final String paragraph;
  final String headingText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 35),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Image.asset(
            'images/tecno.png',
            width: 100,
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 220,
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.only(left: 10),
              decoration: const BoxDecoration(
                  border: Border(
                      left: BorderSide(
                          color: Color.fromARGB(255, 246, 87, 8), width: 4.0))),
              child: RichText(
                  text:
                      TextSpan(style: const TextStyle(fontSize: 32), children: [
                TextSpan(
                  text: headingText,
                  style:
                      const TextStyle(color: Color.fromARGB(255, 246, 87, 8)),
                ),
                TextSpan(text: heading)
              ])),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            subheading,
            style: const TextStyle(
                fontSize: 25, color: Color.fromARGB(255, 177, 175, 175)),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            paragraph,
            style: const TextStyle(color: Color.fromARGB(255, 177, 175, 175)),
          ),
        ],
      ),
    );
  }
}
