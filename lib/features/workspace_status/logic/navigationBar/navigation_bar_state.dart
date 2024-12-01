// ignore_for_file: public_member_api_docs, sort_constructors_first
class NavigationBarState {
  int currentIndex;
  NavigationBarState({
    this.currentIndex = 1,
  });

  NavigationBarState copyWith({
    int? currentIndex,
  }) {
    return NavigationBarState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
