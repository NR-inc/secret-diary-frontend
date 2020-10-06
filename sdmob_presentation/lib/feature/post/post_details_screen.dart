import 'package:common_ui/common_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sddomain/export/domain.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:ssecretdiary/feature/widgets/base_state.dart';

class PostDetailsScreen extends StatefulWidget {
  final String postId;

  PostDetailsScreen({
    @required this.postId,
  });

  @override
  State<StatefulWidget> createState() => _PostDetailsState();
}

class _PostDetailsState extends BaseState<PostDetailsScreen> {
  final PostsBloc _postsBloc = Injector.getInjector().get<PostsBloc>();

  @override
  void initState() {
    _postsBloc.errorStream.handleError(handleError);
    _postsBloc.getPost(postId: widget.postId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Post Details')),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: StreamBuilder(
            stream: _postsBloc.loadingProgressStream,
            builder: (
              BuildContext context,
              AsyncSnapshot<bool> loadingProgress,
            ) {
              return Stack(children: <Widget>[
                _content,
                showLoader(
                  show: loadingProgress.hasData && loadingProgress.data,
                )
              ]);
            },
          ),
        ));
  }

  Widget get _content => Center(
        child: Container(
          child: StreamBuilder(
            stream: _postsBloc.postDetailsStream,
            builder: (BuildContext context, AsyncSnapshot<PostModel> result) {
              final postModel = result.data;
              if (postModel != null) {
                return Column(
                  children: [
                    Text(postModel.title),
                    Text(postModel.description),
                    SizedBox(height: Dimens.unit),
                    divider(),
                    SizedBox(height: Dimens.unit),
                    Row(children: [
                      SvgPicture.asset(
                        SdAssets.likeIcon,
                        package: commonUiPackage,
                        height: Dimens.unit2,
                        width: Dimens.unit2,
                      ),
                      SizedBox(
                        width: Dimens.unit,
                      ),
                      Text('${postModel.likes ?? 0}')
                    ]),
                    SizedBox(height: Dimens.unit),
                    divider(),
                    SizedBox(height: Dimens.unit),
                  ],
                );
              } else {
                return Text('No data for the post');
              }
            },
          ),
        ),
      );
}
