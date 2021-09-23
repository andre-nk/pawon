import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pawon/cubit/auth_cubit.dart';
import 'package:pawon/cubit/page_cubit.dart';
import 'package:pawon/cubit/plan_cubit.dart';
import 'package:pawon/cubit/recipe_cubit.dart';
import 'package:pawon/cubit/recipe_picker_cubit.dart';
import 'package:pawon/shared/shared.dart';
import 'package:pawon/ui/pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  runApp(
    MyApp(), // Wrap your app
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PageCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => RecipeCubit()),
        BlocProvider(create: (context) => PlanCubit()),
        BlocProvider(create: (context) => RecipePickerCubit())
      ],
      child: MaterialApp(
        theme: ThemeData(
          splashColor: ColorModel.disabledRed.withOpacity(0.5),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: MaterialColor(0xFFE7973F, ColorModel.color))
            .copyWith(
            primary: ColorModel.primaryRed.withOpacity(0.75),
            secondary: ColorModel.primaryRed.withOpacity(0.75),
          ),
          primarySwatch: MaterialColor(0xFFE7973F, ColorModel.color)
        ),
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            print(state);
            if(state is AuthSuccess){
              return WrapperPage();
            } else if (state is NotAuthenticated){
              return OnboardingPage();
            } else {
              return OnboardingPage();
            }
          },
        ),
      ),
    );
  }
}
