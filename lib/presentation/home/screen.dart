import 'package:antassistant/bloc/auth/bloc.dart';
import 'package:antassistant/bloc/auth/state.dart';
import 'package:antassistant/bloc/data/bloc.dart';
import 'package:antassistant/bloc/data/event.dart';
import 'package:antassistant/bloc/data/state.dart';
import 'package:antassistant/presentation/home/widget/authenticated.dart';
import 'package:antassistant/presentation/home/widget/unauthenticated.dart';
import 'package:antassistant/presentation/login/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ANTAssistant"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LoginScreenProvider()));
            },
            tooltip: "Добавить пользователя",
          ),
          BlocBuilder<UserDataBloc, UserDataState>(
            builder: (BuildContext context, UserDataState state) {
              return IconButton(
                icon: Icon(Icons.refresh),
                onPressed: (state is DataLoaded)
                    ? () {
                        BlocProvider.of<UserDataBloc>(context)
                            .add(AskForUpdate());
                      }
                    : null,
                tooltip: "Обновить данные",
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthBlocState>(
        builder: (BuildContext context, AuthBlocState state) {
          if (state is Authenticated) {
            return AuthenticatedWidget();
          } else if (state is Unauthenticated) {
            return UnauthenticatedWidget();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
