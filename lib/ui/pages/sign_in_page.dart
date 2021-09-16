part of "pages.dart";

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Widget googleButton() {
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
            onPressed: () {
              context.read<AuthCubit>().signInWithGoogle();
            }
          )
        ],
      );
    }

    Widget title() {
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

    Widget forms() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomForms(
              isSearchForm: false,
              placeholder: "E-mail kamu",
              controller: emailController,
              isObscured: false),
          SizedBox(height: Spacers.l28),
          CustomForms(
              isSearchForm: false,
              placeholder: "Kata sandi kamu",
              controller: passwordController,
              isObscured: true),
          SizedBox(height: Spacers.l28),
          Container(
            width: double.infinity,
            child: PrimaryButton(
              content: "Masuk ke akun kamu",
              isMinified: false,
              isGoogleButton: false,
              isCTA: false,
              onPressed: () {
                context.read<AuthCubit>().signIn(
                  email: emailController.text,
                  password: passwordController.text
                );
              }
            )
          ),
          SizedBox(height: Spacers.m16),
          Text("Lupa kata sandi?", style: Font.incLRegular),
          googleButton(),
          SizedBox(height: Spacers.l32),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: SignUpPage(),
                      type: PageTransitionType.rightToLeftWithFade));
            },
            child: Align(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  style: Font.incLRegular.copyWith(color: ColorModel.majorText),
                  children: <TextSpan>[
                    TextSpan(text: 'Belum punya akun? '),
                    TextSpan(
                        text: 'Daftar dulu!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorModel.majorText)),
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
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state){
          if(state is AuthSuccess){
            Navigator.push(
              context,
              PageTransition(
                child: WrapperPage(),
                type: PageTransitionType.rightToLeftWithFade
              )
            );
          } else if (state is AuthFailed){
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                content: state.error,
                icon: Icon(
                  Ionicons.alert_circle_outline,
                  color: ColorModel.primaryRed,
                ),
              )
            );
          }
        },
        builder: (context, state) {
          if(state is AuthLoading){
            return SafeArea(
              child: Center(
                child: CircularProgressIndicator()
              )
            );
          } else {
            return SafeArea(
              child: ListView(
                padding: EdgeInsets.symmetric(
                  vertical: 120,
                  horizontal: 40,
                ),
                children: [title(), SizedBox(height: 52), forms()],
              ),
            );
          }
        },
      )
    );
  }
}
