import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth_otp_ui/src/datas/datas.dart';




class SelectCountryScreen extends StatefulWidget {
  const SelectCountryScreen({Key? key}) : super(key: key);

  @override
  State<SelectCountryScreen> createState() => _SelectCountryScreenState();
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
 
  final _searchController = TextEditingController();
  var searchValue = "";
 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
       body: CustomScrollView(
        slivers: [

          const SliverAppBar(


            title: Text("Select Country",
                style: TextStyle(
                     color: Colors.white, fontFamily: "semi-bold")),
            elevation: 0,
         
            floating: true,
            snap: true,
            stretch: true,
            pinned: true,

            
          ),
          
          SliverToBoxAdapter(
            child: CupertinoSearchTextField(
              onChanged: (value) {
                setState(() {
                  searchValue = value;
                });
              },
              controller: _searchController,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
                countryList
                    .where((e) => e.name
                        .toString()
                        .toLowerCase()
                        .contains(searchValue.toLowerCase()))
                    .map((e) => ListTile(
                          onTap: () {
                          
                            Navigator.pop(context,
                                '+${e.phoneCode}');
                          },
                          title: Text(e.name),
                          trailing: Text('+${e.phoneCode}'),
                        ))
                    .toList()
                ),
          )
        ],
      ),
    );
  }
}
