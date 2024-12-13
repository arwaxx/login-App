import 'dart:ui';

import 'package:firebase_auth_youtube/screens/auth/sign_in_screen.dart';
import 'package:firebase_auth_youtube/screens/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../blocs/sign_up_bloc/sign_up_bloc.dart';

class WelcomeScreen extends StatefulWidget {
	const WelcomeScreen({super.key});

	@override
	State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
	late TabController tabController;

	@override
	void initState() {
		tabController = TabController(
			initialIndex: 0,
			length: 2,
			vsync: this,
		);
		super.initState();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Theme.of(context).colorScheme.background,
			body: SingleChildScrollView(
				child: SizedBox(
					height: MediaQuery.of(context).size.height,
					child: Stack(
						children: [
							// Background circles
							Align(
								alignment: const AlignmentDirectional(20, -1.2),
								child: Container(
									height: MediaQuery.of(context).size.width,
									width: MediaQuery.of(context).size.width,
									decoration: BoxDecoration(
										shape: BoxShape.circle,
										color: Theme.of(context).colorScheme.tertiary,
									),
								),
							),
							Align(
								alignment: const AlignmentDirectional(-2.7, -1.2),
								child: Container(
									height: MediaQuery.of(context).size.width / 1.3,
									width: MediaQuery.of(context).size.width / 1.3,
									decoration: BoxDecoration(
										shape: BoxShape.circle,
										color: Theme.of(context).colorScheme.secondary,
									),
								),
							),
							Align(
								alignment: const AlignmentDirectional(2.7, -1.2),
								child: Container(
									height: MediaQuery.of(context).size.width / 1.3,
									width: MediaQuery.of(context).size.width / 1.3,
									decoration: BoxDecoration(
										shape: BoxShape.circle,
										color: Theme.of(context).colorScheme.primary,
									),
								),
							),
							BackdropFilter(
								filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
								child: Container(),
							),
							// Back arrow and header text
							Align(
								alignment: Alignment.topLeft,
								child: Padding(
									padding: const EdgeInsets.all(16.0),
									child: Column(
										crossAxisAlignment: CrossAxisAlignment.start,
										children: [
											IconButton(
												icon: const Icon(Icons.arrow_back_ios, size: 35, color: Color(0xFF06284B),),
												onPressed: () {
													Navigator.pop(context); // Navigate back
												},
											),
											const SizedBox(height: 35),
											const Text(
												"  Let’s Sing you in.",
												style: TextStyle(
													fontSize: 44, // Match the font size in the image
													fontWeight: FontWeight.w900, // Bold
													fontFamily: 'Poppins', // Use Poppins or similar font
													color: Color(0xFF06284B),
												),
											),
											const SizedBox(height: 8),
											const Text(
												"  Welcome back.",
												style: TextStyle(
													fontSize: 40, // Slightly smaller font for the subheader
													fontWeight: FontWeight.w500,
													fontFamily: 'Poppins',
													color: Color(0xFF06284B),
												),
											),
											const SizedBox(height: 8),
											const Text(
												"  You’ve been missed!",
												style: TextStyle(
													fontSize: 38, // Slightly smaller font for the subheader
													fontWeight: FontWeight.w500,
													fontFamily: 'Poppins',
													color: Color(0xFF06284B),
												),
											),
										],
									),
								),
							),

							// TabBar and screens
							Align(
								alignment: Alignment.bottomCenter,
								child: SizedBox(
									height: MediaQuery.of(context).size.height / 1.8,
									child: Column(
										children: [
											Padding(
												padding: const EdgeInsets.symmetric(horizontal: 50.0),
												child: TabBar(
													controller: tabController,
													unselectedLabelColor:
													Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
													labelColor: Theme.of(context).colorScheme.onBackground,
													tabs: const [
														Padding(
															padding: EdgeInsets.all(12.0),
															child: Text(
																'Sign In',
																style: TextStyle(
																	fontSize: 18,
																),
															),
														),
														Padding(
															padding: EdgeInsets.all(12.0),
															child: Text(
																'Sign Up',
																style: TextStyle(
																	fontSize: 18,
																),
															),
														),
													],
												),
											),
											Expanded(
												child: TabBarView(
													controller: tabController,
													children: [
														BlocProvider<SignInBloc>(
															create: (context) => SignInBloc(
																	userRepository:
																	context.read<AuthenticationBloc>().userRepository),
															child: const SignInScreen(),
														),
														BlocProvider<SignUpBloc>(
															create: (context) => SignUpBloc(
																	userRepository:
																	context.read<AuthenticationBloc>().userRepository),
															child: const SignUpScreen(),
														),
													],
												),
											),
										],
									),
								),
							)
						],
					),
				),
			),
		);
	}
}
