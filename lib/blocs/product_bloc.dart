import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_poss_gp01/blocs/realm_bloc.dart';
import 'package:mobile_poss_gp01/events/product_event.dart';
import 'package:mobile_poss_gp01/resources/static_values.dart';
import 'package:mobile_poss_gp01/states/product_state.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';

class ProductBloc extends AbstractBloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductLoadInitial()) {
    on<ProductItemFetched>(_itemFetched);
    // on<AppMgmtOauthCodeReturned>(_oauthCodeReturned);
    // on<AppMgmtDrawerOpened>(_drawerOpened);
    // on<AppMgmtDrawerClosed>(_drawerClosed);
  }

  Future<void> _itemFetched(ProductItemFetched event, Emitter<ProductState> emit) async {
    // emit(ProductLoadInProgress());
    // String searchText = event.value;
    // bool isCatalogItemCode = StaticValues.catalogItemCodeRegexp.hasMatch(event.value);
    // String catalogItemCode;
    // if (isCatalogItemCode) {
    //   catalogItemCode = searchText;
    //   /* catalogItem */
    //   Logger.info(
    //       className: "ProductBloc", event: "_itemFetched", message: "search text $searchText is catalogItemCode");
    //   Earmark? _earmark = getEarmarkByCatalogItem(searchText);
    //
    //   if (_earmark == null) {
    //     throw RealmException("findProductBySearchText productItem not found in earmark");
    //   } else {
    //     Logger.info(message: "found productItem in earmark $_earmark");
    //     _productInfoRes = ProductInfoRes(earmark: _earmark);
    //   }
    // } else {
    //   /* inventoryId or itemNumber */
    //   Logger.info(message: "search text $searchText is inventoryId or itemNumber");
    //   _productInfoRes = getProductItemFromStoreByItemNumberOrInventoryId(searchText);
    //
    //   if (!_productInfoRes.isInStore && _productInfoRes.earmark == null) {
    //     /* 不在本店也不在earmark */
    //     throw RealmException("findProductBySearchText productItem not found");
    //   }
    //   catalogItemCode = _productInfoRes.inventory!.catalogItem!;
    // }
    //
    // /* 本店catalogItem商品 */
    // List<StoreProductInfoPOJO> storeCatalogItems = getProductItemFromStoreByCatalogItem(catalogItemCode);
    // _productInfoRes.storeCatalogItems = storeCatalogItems;
  }
}
