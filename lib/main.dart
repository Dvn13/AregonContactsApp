import 'package:contacts_app/Helpers/constants/project.dart';
import 'package:contacts_app/Helpers/constants/text.dart';
import 'package:contacts_app/Helpers/manager/network/main_build.dart';
import 'package:contacts_app/Pages/contacts/service/contacts_service.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/city_bloc/city_bloc.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/contacs_bloc/contacts_bloc.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/contact_detail_bloc/contact_bloc.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/town_bloc/town_bloc.dart';
import 'package:contacts_app/Pages/login/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final contactsListBloc = ContactsListBloc(
      ContactsService(ProjectConstants.instance.networkManager));
  final cityListBloc =
      CitysListBloc(ContactsService(ProjectConstants.instance.networkManager));
  final townListBloc =
      TownsListBloc(ContactsService(ProjectConstants.instance.networkManager));
  final contactBloc =
      ContactBloc(ContactsService(ProjectConstants.instance.networkManager));
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ContactsListBloc>(
          create: (context) => contactsListBloc,
        ),
        BlocProvider<CitysListBloc>(
          create: (context) => cityListBloc,
        ),
        BlocProvider<ContactBloc>(
          create: (context) => contactBloc,
        ),
        BlocProvider<TownsListBloc>(
          create: (context) => townListBloc,
        ),
      ],
      child: MaterialApp(
        title: ConstText.materialAppTitle,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: LoginView(),
        builder: MainBuild.build,
      ),
    );
  }
}
