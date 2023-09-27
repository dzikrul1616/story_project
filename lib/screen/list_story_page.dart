import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:story_app/const/color.dart';
import 'package:story_app/reusable/drawer.dart';
import 'package:story_app/reusable/empty_app_bar.dart';
import 'package:story_app/reusable/flag_icon.dart';
import 'package:story_app/reusable/search.dart';
import 'package:story_app/screen/add_story_page.dart';
import 'package:story_app/screen/list_story_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StoryListPage extends StatelessWidget {
  const StoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => ListStoryProvider(),
        child: Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.white,
              backgroundColor: appPrimary,
              title: Text(
                AppLocalizations.of(context)!.story_page,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                FlagIconWidget(
                  colors: Colors.white,
                ),
              ],
            ),
            drawer: DrawerPage(),
            floatingActionButton: FloatingActionButton(
              backgroundColor: appCyan,
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddStoryPage())),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
            body: Consumer<ListStoryProvider>(builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: RefreshIndicator(
                  onRefresh: value.refresh,
                  child: ListView(
                    children: [
                      SearchWidget(
                        onChanged: (data) => value.filterStory(data),
                      ),
                      value.isLoading
                          ? ListView.builder(
                              itemCount: 10,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Shimmer.fromColors(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[200],
                                      ),
                                    ),
                                    baseColor: Colors.white,
                                    highlightColor: appCyan,
                                  ),
                                );
                              },
                            )
                          : value.filteredStory.length == 0
                              ? Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 400,
                                    child: Center(
                                      child: Text(
                                        "No Data result",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: value.filteredStory.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final data = value.filteredStory[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: InkWell(
                                        onTap: () => value.recomendationDetail(
                                            context,
                                            data['photoUrl'],
                                            data['name'],
                                            data['description'],
                                            value.convertToTimeAgo(
                                                data['createdAt']),
                                            data['lat'] == null
                                                ? 'no latitude, '
                                                : '${data['lat'].toString()}',
                                            data['lon'] == null
                                                ? 'no longitude'
                                                : '${data['lon'].toString()}'),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey[200],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 100,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    data['photoUrl'],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'by : ${data['name']}',
                                                      style: TextStyle(
                                                          fontSize: 12.0,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                    const SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    Text(
                                                      data['description'],
                                                      style: TextStyle(
                                                          fontSize: 14.0,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.location_pin,
                                                            size: 10,
                                                            color: Colors.grey),
                                                        const SizedBox(
                                                          width: 5.0,
                                                        ),
                                                        Text(
                                                          data['lat'] == null
                                                              ? 'no latitude, '
                                                              : '${data['lat'].toString()}, ',
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                        Text(
                                                          data['lon'] == null
                                                              ? 'no longitude'
                                                              : data['lon']
                                                                  .toString(),
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    Text(
                                                      value.convertToTimeAgo(
                                                          data['createdAt']),
                                                      style: TextStyle(
                                                          fontSize: 12.0,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                    ],
                  ),
                ),
              );
            })));
  }
}
