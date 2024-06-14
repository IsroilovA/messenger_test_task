import 'package:get_it/get_it.dart';
import 'package:messenger_test_task/service/messenger_repository.dart';

final GetIt locator = GetIt.instance;

Future<void> initialiseLocator() async {
  locator.registerSingleton(MessengerRepository());
}
