import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Чаты',
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Platform.isIOS
                ? CupertinoSearchTextField(
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                    onChanged: (value) {},
                  )
                : SearchBar(
                    hintText: "Search",
                    leading: const Icon(Icons.search),
                    onChanged: (value) {},
                  ),
              
          ],
        ),
      ),
    );
  }
}
