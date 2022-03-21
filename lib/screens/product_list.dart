import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incdnc/commons/common_widget.dart';
import 'package:incdnc/model_class/list_product.dart';
import 'package:incdnc/screens/add_products.dart';
import 'package:incdnc/screens/api_bloc/product_list/bloc.dart';
import 'package:incdnc/screens/api_bloc/product_list/event.dart';
import 'package:incdnc/screens/api_bloc/product_list/state.dart';
import 'package:incdnc/screens/profile_screen.dart';

import 'package:incdnc/service/get_it.dart';


class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  ProductListModel? productListModel;
  List<Datum>? list = [];
  ListBloc? listBloc;
  bool hasNextPage = true;
  bool loadApi = true;
  bool? finaFav;
  List<Datum> allData = [];
  late ScrollController scrollController = ScrollController();

  @override
  void initState() {
    listBloc = sl<ListBloc>();
    firstLoadData();
    scrollController.addListener(loadMoreData);
    super.initState();
  }

  firstLoadData() {
    listBloc!.add(ListEvent());
  }

  loadMoreData() {
    if (hasNextPage &&
        !loadApi &&
        scrollController.position.minScrollExtent <
            scrollController.position.maxScrollExtent) {
      loadApi = true;
      firstLoadData();
      //loadApi = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.11,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30)),
                      color: Colors.blue),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                        color: Colors.white,
                      ),
                      Text(
                        'Product List',
                        style: GoogleFonts.marmelad(
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                            color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileScreen()));
                        },
                        child: const CircleAvatar(
                          backgroundImage: NetworkImage('https://cdna.artstation.com/p/assets/images/images/009/372/706/large/royy-_ledger-untitled-1.jpg?1518610660'),
                          radius: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                BlocListener<ListBloc, ProductListState>(
                  bloc: listBloc,
                  listener: (context, state) {
                    if (state is ListInitState) {
                      const CircularProgressIndicator();
                    }
                    if (state is ListLoadingState) {
                      Text(state.loading!);
                    }
                    if (state is ListLoadedState) {
                      productListModel = state.productListModel;
                      allData.addAll(productListModel!.data!.data!);
                      print(productListModel!.message);
                      if (productListModel!.data!.currentPage ==
                          productListModel!.data!.lastPage) {
                        hasNextPage = false;
                        print(hasNextPage);
                      }
                      print(hasNextPage);
                      loadApi = false;
                    }
                    if (state is DeleteState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Data Deleted")));
                      allData = [];
                      allData.addAll(state.allData!);
                    }
                    if(state is DataAddedState){
                      allData.add(state.lastData!);
                      print("data Added");
                    }
                    if(state is FavUnfavState){
                      finaFav = state.fav;
                      print("$finaFav=====>3");
                    }
                  },
                  child: BlocBuilder<ListBloc, ProductListState>(
                    bloc: listBloc,
                    builder: (context, state) {
                      return /*productListModel == null
                          ? const CircularProgressIndicator()
                          :*/
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: allData.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 150,
                                                  child: Image.network(
                                                    allData[index].img == null
                                                        ? 'https://images.unsplash.com/photo-1567581935884-3349723552ca?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8bW9iaWxlfGVufDB8fDB8fA%3D%3D&w=1000&q=80'
                                                        : allData[index].img!,
                                                    fit: BoxFit.fill,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            flex: 6,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                text(
                                                    string: allData[index].name,
                                                    color: Colors.blue,
                                                    fontsize: 18,
                                                    fontweight:
                                                        FontWeight.w600),
                                                text(
                                                    string: allData[index]
                                                        .description,
                                                    color: Colors.grey),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(allData[index].id.toString()),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: text(
                                                        string:
                                                            "Price:-${allData[index].mrp}",
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          print("tapped Like");
                                                          print("${
                                                            allData[index].fav
                                                          } allData ===>1");
                                                          allData[index].fav = false;
                                                          listBloc!.add(LikeUnlike(fav: allData[index].fav));
                                                          },
                                                        child: Icon(
                                                            Icons.favorite,
                                                            color: allData[index].fav !=
                                                                    finaFav
                                                                ? Colors.red
                                                                : Colors.grey),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: ElevatedButton(
                                                            onPressed: () {},
                                                            child:
                                                                const Text("Edit "))),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Expanded(
                                                      child: ElevatedButton(
                                                          onPressed: () {
                                                            try {
                                                              listBloc!.add(DeleteEvent(
                                                                  id: allData[
                                                                          index]
                                                                      .id,
                                                                  allData:
                                                                      allData,
                                                                  index:
                                                                      index));
                                                            } catch (e) {
                                                              throw Exception(
                                                                  "AppInterceptors().dio!.interceptors====>$e");
                                                            }
                                                          },
                                                          child:
                                                              const Text("Remove ")),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              });
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {

              double lastpage =allData.length/5;
              String demo= lastpage.toString();
              List<String> demoList=demo.split('.');
              int myPage= int.parse(demoList.first);
              print("gopalbhai ka logic:-${allData.length}");
              print("gopalbhai ka logic:-${myPage}");
              Navigator.push(context, MaterialPageRoute(builder: (context)=> AddProducts(lasPage: myPage+1,)));
            },
            child: const Icon(Icons.add),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          )),
    );
  }
}
