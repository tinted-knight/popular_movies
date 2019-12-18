import 'package:flutter/material.dart';
import 'package:popular_movies/base/logic/BaseBloc.dart';
import 'package:popular_movies/logic/BackdropBloc.dart';
import 'package:popular_movies/views/widgets/AppBarTransparent.dart';

import 'PosterPageViewWithIndicator.dart';

class FullscreenBackdrop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("::build >> FullscreenBackdrop");
    final BackdropBloc bloc = BlocProvider.of<BackdropBloc>(context);

    return Scaffold(
      appBar: null,
      body: StreamBuilder<BackdropBlocState>(
        stream: bloc.states,
        initialData: BackdropStateLoading(),
        builder: _buildFromStream,
      ),
    );
  }

  Widget _buildFromStream(
      BuildContext context, AsyncSnapshot<BackdropBlocState> snapshot) {
    Widget content = CircularProgressIndicator();
    switch (snapshot.data.runtimeType) {
      case BackdropStateValues:
        BackdropStateValues state = snapshot.data;
        content = PosterPageViewWithIndicator(
          items: state.values.backdrops,
          heroTag: state.values.id.toString(),
        );
        break;
    }

    return _withAppBar(content);
  }

  Widget _withAppBar(Widget child) {
    return Stack(
      children: <Widget>[
        Center(
          child: child,
        ),
        AppBarTransparent(),
      ],
    );
  }
}
