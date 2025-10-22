import 'package:flutter_riverpod/legacy.dart';
import 'package:kicksy/data/shoe.dart';

final selectedImageProvider = StateProvider<int>((ref) => 0);
final selectedSizeProvider = StateProvider<String?>((ref) => null);

final sneakerDetailsProvider =
    StateNotifierProvider<SneakerDetailsNotifier, List<Shoe>>(
      (ref) => SneakerDetailsNotifier(),
    );

class SneakerDetailsNotifier extends StateNotifier<List<Shoe>> {
  SneakerDetailsNotifier() : super([]);
}
