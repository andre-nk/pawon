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
            isMinified: false,
            isGoogleButton: true,
            isCTA: true,
            onPressed: (){
              showDialog(
                context: context,
                builder: (context){
                  return CustomDialog(
                    title: "Batalkan pembuatan resep?",
                    content: "Kamu belum selesai membuat resep baru, jika kamu mau kembali ke Beranda, informasi resep ini akan terhapus.",
                    negativeText: "Kembali",
                    positiveText: "Lanjutkan",
                    negativeFunction: (){
                      Navigator.pop(context);
                    },
                    positiveFunction: (){
                      Navigator.pop(context);
                    },
                  );
                }
              );
            }
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
          Text("Masuk ke akun kamu dulu ya!", style: Font.incXLMedium)
        ],
      );
    }

    Widget forms(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomForms(isSearchForm: false, placeholder: "E-mail kamu", controller: emailController, isObscured: false),
          CustomForms(isSearchForm: false, placeholder: "Kata sandi kamu", controller: passwordController, isObscured: true),
          Container(
            width: double.infinity,
            child: PrimaryButton(
              content: "Masuk ke akun kamu",
              isMinified: false,
              isGoogleButton: false,
              isCTA: false,
              onPressed: (){
                Navigator.push(context, PageTransition(child: WrapperPage(), type: PageTransitionType.rightToLeftWithFade));
              }
            ),
          ),
          SizedBox(height: Spacers.m16),
          Text(
            "Lupa kata sandi?",
            style: Font.incLRegular
          ),
          googleButton(),
          SizedBox(height: Spacers.l32),
          GestureDetector(
            onTap: (){
              Navigator.push(context, PageTransition(child: SignUpPage(), type: PageTransitionType.rightToLeftWithFade));
            },
            child: Align(
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