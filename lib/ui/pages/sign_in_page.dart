part of "pages.dart";

class SignInPage extends StatefulWidget {
  const SignInPage({ Key? key }) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Widget googleButton(){
      return Column(
        children: [
          SizedBox(height: Spacers.l32),
          Container(
            height: 1,
            width: double.infinity,
            color: ColorModel.kBorder,
          ),
          SizedBox(height: Spacers.l32),
          PrimaryButton(
            content: "Masuk dengan Google",
            isGoogleButton: true,
            isCTA: true,
            onPressed: (){}
          )
        ],
      );
    }

    Widget title(){
      return Column(
        children: [
          Text(
            "Pawon.",
            style: Font.headingL,
          ),
          SizedBox(height: Spacers.s8),
          Text("Buat akun kamu dulu ya!", style: Font.incXLMedium)
        ],
      );
    }

    Widget forms(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomForms(placeholder: "E-mail kamu", controller: emailController, isObscured: false),
          CustomForms(placeholder: "Kata sandi kamu", controller: passwordController, isObscured: true),
          PrimaryButton(
            content: "Masuk ke akun kamu",
            isGoogleButton: false,
            isCTA: false,
            onPressed: (){}
          ),
          SizedBox(height: Spacers.m16),
          Text(
            "Lupa kata sandi?",
            style: Font.incLRegular
          ),
          googleButton(),
          SizedBox(height: Spacers.l32),
          Align(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                style: Font.incLRegular.copyWith(
                  color: ColorModel.majorText
                ),
                children: <TextSpan>[
                  TextSpan(text: 'Belum punya akun? '),
                  TextSpan(text: 'Daftar dulu!', style: TextStyle(fontWeight: FontWeight.bold, color: ColorModel.majorText)),
                ],
              ),
            ),
          )
        ],
      );
    }

    return Scaffold(
      backgroundColor: ColorModel.kWhite,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            vertical: 120,
            horizontal: 40,
          ),
          children: [
            title(),
            SizedBox(height: 52),
            forms()
          ],
        ),
      )
    );
  }
}