import 'package:bloc/bloc.dart';
import 'package:incdnc/model_class/add_product_model.dart';
import 'package:incdnc/model_class/list_product.dart';
import 'package:incdnc/screens/api_bloc/product_list/event.dart';
import 'package:incdnc/screens/api_bloc/product_list/state.dart';
import 'package:incdnc/service/register_service.dart';

class ListBloc extends Bloc<ProductListEvent, ProductListState> {
  int page = 1;
  AlbumService? albumService;
  ProductListModel? productListModel;
  ProductListModel? productListModelTemp;
  AddProductModel? addProductModel;
  List<Datum>? lastpageList;
  bool? fav = false;
  ListBloc({
    this.albumService,
  }) : super(ListInitState()) {
    on<ProductListEvent>((event, emit) async {
      if (event is LoadingEvent) {
        emit(ListLoadingState(loading: "lloopp"));
      }
      if (event is ListEvent) {
        // ignore: await_only_futures
        productListModel = (await RegisterApi().productList(page: page));
        page++;
        // ignore: avoid_print
        print(page);
        emit(ListLoadedState(productListModel: productListModel, page: page));
      }
      if (event is DeleteEvent) {
        await RegisterApi().deleteProduct(deleteId: event.id);
        event.allData!.removeAt(event.index!);
        emit(DeleteState(allData: event.allData));
      }
     /* if(event is DataAddedevent){
        productListModelTemp = (await RegisterApi().dataAdded(lastpage: event.lastpage));
        emit(DataAddedState(lastData: productListModelTemp!.data!.data!.last));
      }*/
      if(event is APEvent){

        productListModelTemp = await RegisterApi().addProduct(addproductModel:event.addProductModel,lastPage: event.lastPage);
        print(productListModelTemp);
        emit(DataAddedState(lastData: productListModelTemp!.data!.data!.last));
      }
      if(event is LikeUnlike){
        if(fav==event.fav){
          fav = true;
        }else
          {
            fav = false;
          }
        print("$fav 2====>");
        emit(FavUnfavState(fav: fav));
      }

    });
  }
}
