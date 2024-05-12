import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../app.routes.dart';
import '../../../../../go.routes.dart';
import '../../../../config/app.config.dart';
import '../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../auth/model/user.dart';
import '../../provider/home.dart';

class SearchUsers extends SearchDelegate {
  SearchUsers({String hintText = 'Search User'})
      : super(
          searchFieldLabel: hintText,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, color: context.theme.primaryColor),
        tooltip: 'Clear',
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
        color: context.theme.primaryColor,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer(
      builder: (_, ref, __) => ref.watch(usersStreamProvider(query)).when(
            loading: riverpodLoading,
            error: riverpodError,
            data: (snapshot) {
              final users =
                  snapshot.docs.map((e) => e.data()).toList().removeOwn;
              return query.isEmpty
                  ? displayNoQuerySearchScreen()
                  : users.isEmpty
                      ? displayNoUsersFoundScreen()
                      : ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (_, index) {
                            final user = users[index];
                            return KListTile(
                              title: Text(user.name,
                                  style: context.text.titleMedium),
                              subtitle: Text(user.email,
                                  style: context.text.bodyMedium),
                              leading: user.imageWidget,
                              onTap: () => context.goPush(
                                  '${AppRoutes.messageRoute}/${user.uid}'),
                            );
                          },
                        );
            },
          ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer(
      builder: (_, ref, __) => ref.watch(usersStreamProvider(query)).when(
            loading: riverpodLoading,
            error: riverpodError,
            data: (snapshot) {
              final users =
                  snapshot.docs.map((e) => e.data()).toList().removeOwn;
              return query.isEmpty || query.length < 3
                  ? displayNoQuerySearchScreen()
                  : users.isEmpty
                      ? displayNoUsersFoundScreen()
                      : ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (_, index) {
                            final user = users[index];
                            return KListTile(
                              title: Text(user.name,
                                  style: context.text.titleMedium),
                              subtitle: Text(user.email,
                                  style: context.text.bodyMedium),
                              leading: user.imageWidget,
                              onTap: () => context.goPush(
                                  '${AppRoutes.messageRoute}/${user.uid}'),
                            );
                          },
                        );
            },
          ),
    );
  }

  Widget displayNoQuerySearchScreen() {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: const [
          Icon(Icons.group, color: Colors.grey, size: 70.0),
          Text(
            'Search User by email',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }

  Widget displayNoUsersFoundScreen() {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: const [
          Icon(Icons.engineering_sharp, color: Colors.grey, size: 70.0),
          Text(
            'No user found',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
