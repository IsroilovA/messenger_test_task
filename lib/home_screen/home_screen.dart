import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_test_task/home_screen/cubit/home_cubit.dart';
import 'package:messenger_test_task/home_screen/widgets/user_chat.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: false,
        title: Text(
          'Чаты',
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        //pull down to refresh
        child: RefreshIndicator.adaptive(
          onRefresh: () {
            return BlocProvider.of<HomeCubit>(context).getUsers();
          },
          child: Column(
            children: [
              //show different text fields according to platforn
              Platform.isIOS
                  ? CupertinoSearchTextField(
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface),
                      onChanged: (value) {
                        BlocProvider.of<HomeCubit>(context).onSearch(value);
                      },
                    )
                  : SearchBar(
                      shadowColor: WidgetStateColor.resolveWith(
                          (states) => Colors.transparent),
                      shape: WidgetStateProperty.resolveWith((states) =>
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      hintText: "Поиск",
                      leading: const Icon(Icons.search),
                      onChanged: (value) {
                        BlocProvider.of<HomeCubit>(context).onSearch(value);
                      },
                    ),
              const SizedBox(
                height: 20,
              ),
              //render list of chats
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeInitial) {
                    BlocProvider.of<HomeCubit>(context).getUsers();
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (state is HomeUsersLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (state is HomeUsersFetched) {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.users.length,
                        itemBuilder: (context, index) {
                          return UserChat(
                            user: state.users[index],
                          );
                        },
                      ),
                    );
                  } else if (state is HomeError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        "Что то пошло не так",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
