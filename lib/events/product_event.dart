abstract class ProductEvent {}

class ProductInitialed extends ProductEvent {}

class ProductItemFetched extends ProductEvent {
  final String value;

  ProductItemFetched({required this.value}) : super();
}
