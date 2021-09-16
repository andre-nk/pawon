part of "pages.dart";

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorModel.kWhite,
        body: SafeArea(
          child: ListView(
            children: [
              SizedBox(height: 76),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Pawon.",
                  style: Font.headingXL.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 96),
              Container(
                  width: double.infinity,
                  child: Image.asset("assets/illustrations.png",
                      fit: BoxFit.cover)),
              SizedBox(height: 140),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Simpan resep kamu disini!",
                  style: Font.incXLMedium,
                ),
              ),
              SizedBox(height: 120),
              Align(
                alignment: Alignment.center,
                child: PrimaryButton(
                  content: "Langsung mulai",
                  isMinified: false,
                  isGoogleButton: false,
                  isCTA: true,
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        child: SignInPage()
                      )
                    );
                  },
                ),
              ),
              SizedBox(height: 120),
            ],
          ),
        ));
  }
}
