abstract class ShopStates  {}

class ShopInitialState extends ShopStates {}

class ShopChangeState extends ShopStates {}

class ShopLoadingState extends ShopStates {}

class ShopSuccessState extends ShopStates {}

class ShopErrorState extends ShopStates {
  final String? error;
  ShopErrorState(this.error);
}

