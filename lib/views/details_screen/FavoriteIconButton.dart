import 'package:flutter/material.dart';
import 'package:popular_movies/base/logic/BaseBloc.dart';
import 'package:popular_movies/logic/DetailsMarkFavoriteBloc.dart';

class FavoriteIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DetailsMarkFavoriteBloc favoritesLogic =
        BlocProvider.of<DetailsMarkFavoriteBloc>(context);

    return IconButton(
      onPressed: () => favoritesLogic.switchMark(),
      icon: StreamBuilder<FavoriteState>(
        stream: favoritesLogic.states,
        initialData: FavoriteState.inProgress,
        builder: (_, snapshot) {
          switch (snapshot.data) {
            case FavoriteState.marked:
              return Icon(Icons.favorite);
            case FavoriteState.notMarked:
              return Icon(Icons.favorite_border);
            case FavoriteState.inProgress:
              return Container(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(),
              );
          }
          return null;
        },
      ),
    );
  }
}
