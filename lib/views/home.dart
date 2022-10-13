// import 'package:couchdb_test/cubits/data_cubit.dart';
import 'package:couchdb_test/blocs/home_bloc.dart';
import 'package:couchdb_test/services/api_services.dart';
import 'package:couchdb_test/utils/connectivity_controller.dart';
import 'package:couchdb_test/utils/styles.dart';
import 'package:couchdb_test/views/add_new_docs_form.dart';
import 'package:couchdb_test/views/docs_detail_screen.dart';
// import 'package:couchdb_test/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

// import '../utils/connectivity.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var rm = RemoteService();
  
  final HomeBloc _homeBloc = HomeBloc();
  final ConnectivityController _conCon = ConnectivityController();
  // final RemoteService rm = RemoteService();
  // final DataCubit postCubit = DataCubit();
  var data = [];
  @override
  void initState() {
    _homeBloc.add(GetDataEvent());
    _conCon.checkForConnectivityChange();
    _conCon.checkInitialConnectivity();
    // rm.getData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("All DOCS",style: TextStyle(color: white,fontSize: 15,letterSpacing: 3),),
        actions: [
          IconButton(onPressed: (){
            showModalBottomSheet(
              context: context,
              enableDrag: true,
              isDismissible: false,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
                )
              ),
              builder: (ctx)=>  AddnewDocsForm(bloc: _homeBloc,)
            );
          }, 
          icon: const Icon(Icons.add, color: Colors.white,size: 25,))
        ],
      ),
      body: LiquidPullToRefresh(
        backgroundColor: white,
        color: black.withOpacity(0.5),
        showChildOpacityTransition: false,
        onRefresh: () async => _homeBloc.add(GetDataEvent()),
        child: BlocProvider(
          create: (_) => _homeBloc,
          child: BlocListener<HomeBloc,HomeState>(
            listener: (context, state) {
              if(state is DataError){
                 ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                  ),
                );
              }
            },
            child: BlocBuilder<HomeBloc,HomeState>(
              builder: (context,state){
                if(state is DataLoading){
                  return const Center(child: CircularProgressIndicator());
                }else if(state is DataLoaded){
                  return _buildDataList(context,state.data);
                }else{
                  return const SizedBox();
                }
              },
            ),
          ),
        ),
      ),  
    );
  }

  _buildDataList(context,data){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context,index){
        return itemTile(data[index]);
      },
    );
  }

  Widget itemTile(data){
    return InkWell(
      onTap: () => Navigator.push(context,MaterialPageRoute(builder: (_) => 
       BlocProvider<HomeBloc>.value(
        value: _homeBloc,
        child: DocsDetailPage(data: data,),
       )
        
        )),                        
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: grey.withOpacity(0.3)
        ),
        padding: const EdgeInsets.only(top: 30,bottom: 30,left: 30),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.value.name),
                Text(data.value.email),
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: (){
                _homeBloc.add(DeleteDataEvent(docID: data.doc.id,revID: data.doc.rev));
              }, 
              icon: const Icon(Icons.delete,color: red,size: 30,) 
            ) 
          ],
        ),
      ),
    );
  }

}