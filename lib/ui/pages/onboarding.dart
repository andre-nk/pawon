part of "pages.dart";

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorModel.kWhite,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Spacer(),
              Text(
                "Pawon.",
                style: Font.headingXL.copyWith(
                  fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(height: Spacers.xl100),
              Container(
                width: double.infinity,
                child: Image.asset("assets/illustrations.png", fit: BoxFit.cover)
              ),
              SizedBox(height: Spacers.xl108),
              Text(
                "Simpan resep kamu disini!",
                style: Font.incXLMedium,
              ),
              SizedBox(height: Spacers.xl108),
              PrimaryButton(
                content: "Langsung mulai",
                isGoogleButton: false,
                isCTA: true,
                onPressed: (){
                  Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child: SignInPage()));
                },
              ),
              Spacer(),
            ],
          ),
        ),
      )
    );
  }
}