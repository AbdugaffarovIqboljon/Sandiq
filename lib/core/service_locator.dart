import 'package:sandiq/data/network_service.dart';
import 'package:sandiq/domain/repository/repository.dart';

late final Repository repository;

Future<void> serviceLocator() async {
  repository = RepositoryImplementation(
    network: HttpService(),
  );
}