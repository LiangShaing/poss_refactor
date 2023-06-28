import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_poss_gp01/blocs/realm_bloc.dart';
import 'package:mobile_poss_gp01/database_objects/product/pojo/store_product_info_pojo.dart';
import 'package:mobile_poss_gp01/database_objects/realm/model/realm_models.dart';
import 'package:mobile_poss_gp01/events/product_event.dart';
import 'package:mobile_poss_gp01/repositories/product_repository.dart';
import 'package:mobile_poss_gp01/resources/static_values.dart';
import 'package:mobile_poss_gp01/states/product_state.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';
import 'package:realm/realm.dart';

class ProductBloc extends AbstractBloc<ProductEvent, ProductState> {
  ProductRepository productRepository;

  ProductBloc({required this.productRepository}) : super(ProductLoadInitial()) {
    on<ProductItemFetched>(_itemFetched);
    // on<AppMgmtOauthCodeReturned>(_oauthCodeReturned);
    // on<AppMgmtDrawerOpened>(_drawerOpened);
    // on<AppMgmtDrawerClosed>(_drawerClosed);
  }

  Future<void> _itemFetched(ProductItemFetched event, Emitter<ProductState> emit) async {
    emit(ProductLoadInProgress());
    String searchText = event.value;
    bool isCatalogItemCode = StaticValues.catalogItemCodeRegexp.hasMatch(event.value);
    String catalogItemCode;
    Earmark? earmark;

    /* 如果小於8碼不搜尋*/
    if (searchText.length < 8) {
      Logger.debug(message: "ProductBloc _itemFetched searchText.length < 8");
      emit(const ProductLoadFailure("輸入內容不得小於8碼"));
    }

    if (isCatalogItemCode) {
      catalogItemCode = searchText;
      /* catalogItem */
      Logger.info(
          className: "ProductBloc", event: "_itemFetched", message: "search text $searchText is catalogItemCode");
      earmark = productRepository.findEarmarkByCatalogItem(searchText);

      // if (earmark == null) {
      //   throw RealmException("findProductBySearchText productItem not found in earmark");
      // } else {
      //   Logger.info(message: "found productItem in earmark $earmark");
      //   _productInfoRes = ProductInfoRes(earmark: earmark);
      // }
    } else {
      /* inventoryId or itemNumber */
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

// Earmark? _getEarmarkByCatalogItem(String catalogItem) {
//   try {
//     Earmark? earmark = realmService.realm.query<Earmark>(r'catalogItem ==[c] $0', [catalogItem]).firstOrNull;
//     realmService.loggerNewRelicInfo("getEarmarkByCatalogItem", "catalogItem [$catalogItem]");
//     return earmark;
//   } catch (e) {
//     realmService.loggerNewRelicError("getEarmarkByCatalogItem", "catalogItem [$catalogItem]");
//     rethrow;
//   }
// }
  }
}
