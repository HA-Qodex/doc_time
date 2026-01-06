import 'package:doc_time/model/call_model.dart';
import 'package:doc_time/repository/home_repository.dart';
import 'package:doc_time/viewmodel/call_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeRepositoryProvider = Provider.autoDispose<HomeRepository>((ref) {
  return HomeRepository();
});

final callProvider = AsyncNotifierProvider<CallViewmodel, CallModel>(() {
  return CallViewmodel();
});
