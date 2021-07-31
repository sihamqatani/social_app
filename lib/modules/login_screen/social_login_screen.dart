import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:social_app/layouts/home_screen.dart';
import 'package:social_app/modules/login_cubit/cubit.dart';
import 'package:social_app/modules/login_cubit/state.dart';
import 'package:social_app/modules/register/register.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local/cashe_helper.dart';

class SocialLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  late var emailController = TextEditingController();
  late var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginState>(
          listener: (cintext, state) => {
                if (state is SocialLoginErrorState)
                  {print('login error')}
                else if (state is SocialLoginSuccessState)
                  {
                    CashHelper.saveData(
                      key: 'uId',
                      value: state.uId,
                    ).then((value) => navigateAndFinish(context, HomeScreen()))
                  }
              },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: SingleChildScrollView(
                child: Center(
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'LOGIN',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'login now to communicate with friends',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(color: Colors.grey),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            defaultFormField(
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'must enter email';
                                  }
                                },
                                label: 'Email Address',
                                prefix: Icons.email_outlined),
                            SizedBox(
                              height: 20,
                            ),
                            defaultFormField(
                                suffix:
                                    SocialLoginCubit.get(context).iconVisiblity,
                                suffixPressed: () {
                                  SocialLoginCubit.get(context)
                                      .changPasswordVisibilty();
                                },
                                isPassword:
                                    SocialLoginCubit.get(context).isPasword,
                                controller: passwordController,
                                type: TextInputType.visiblePassword,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'must enter Password';
                                  }
                                },
                                label: 'Password',
                                prefix: Icons.lock_clock_outlined,
                                onSubmit: (value) {
                                  if (formKey.currentState!.validate()) {
                                    print('done');
                                    SocialLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);

                                    print('22');
                                  }
                                }),
                            SizedBox(
                              height: 20,
                            ),
                            Conditional.single(
                              context: context,
                              conditionBuilder: (context) =>
                                  state is! SocialLoginloadingState,
                              widgetBuilder: (context) => defaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      print('done');
                                      SocialLoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);

                                      print('22');
                                    }
                                  },
                                  text: 'Login'),
                              fallbackBuilder: (context) => Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('you Don \'t have account?'),
                                TextButton(
                                    onPressed: () {
                                      navigateTo(
                                        context,
                                        Register(),
                                      );
                                    },
                                    child: Text('REGISTER')),
                              ],
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            );
          }),
    );
  }
}
