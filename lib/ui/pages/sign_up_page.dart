part of "pages.dart";

class SignUpPage extends StatefulWidget {
  const SignUpPage({ Key? key }) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {

    TextEditingController nameController = TextEditingController();
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
            content: "Daftar dengan Google",
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
          Text("Daftar akun kamu dulu ya!", style: Font.incXLMedium)
        ],
      );
    }

    Widget forms(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomForms(placeholder: "Nama kamu", controller: nameController, isObscured: false),
          CustomForms(placeholder: "E-mail kamu", controller: emailController, isObscured: false),
          CustomForms(placeholder: "Kata sandi kamu", controller: passwordController, isObscured: true),
          Container(
            width: double.infinity,
            child: PrimaryButton(
              content: "Masuk ke akun kamu",
              isGoogleButton: false,
              isCTA: false,
              onPressed: (){}
            ),
          ),
          googleButton(),
          SizedBox(height: Spacers.l32),
          GestureDetector(
            onTap: (){
              Navigator.push(context, PageTransition(child: SignInPage(), type: PageTransitionType.rightToLeftWithFade));
            },
            child: Align(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  style: Font.incLRegular.copyWith(
                    color: ColorModel.majorText
                  ),
                  children: <TextSpan>[
                    TextSpan(text: 'Udah punya akun? '),
                    TextSpan(text: 'Masuk saja!', style: TextStyle(fontWeight: FontWeight.bold, color: ColorModel.majorText)),
                  ],
                ),
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
            vertical: 100,
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