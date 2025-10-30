import 'package:flutter_riverpod/legacy.dart';

final homePageProvider = StateNotifierProvider<HomePageNotifier, int>((ref) {
  return HomePageNotifier();
});

class HomePageNotifier extends StateNotifier<int> {
  HomePageNotifier() : super(0);

  void setIndex(int index) {
    state = index;
  }
}
