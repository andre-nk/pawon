part of "pages.dart";

class CustomLoaderPage extends StatelessWidget {
  const CustomLoaderPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorModel.kWhite,
      body: SafeArea(
        child: Center(
          child: SpinPerfect(
            infinite: true,
            child: Image.asset(
              "assets/loader_${Random().nextInt(4) + 1}.png",
              height: 100,
              width: 100
            )
          )
        )
      )
    );
  }
}