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
  final _likeValueNotifier = ValueNotifier<bool>(false);
  final _addCommentTextController = TextEditingController();

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
              _likeValueNotifier.value = postModel?.isLiked ?? false;
              if (postModel != null) {
                return Column(
                  children: [
                    Text(postModel.title),
                    Text(postModel.description),
                    SizedBox(height: Dimens.unit),
                    divider(),
                    SizedBox(height: Dimens.unit),
                    ValueListenableBuilder(
                      valueListenable: _likeValueNotifier,
                      builder: (context, value, child) => GestureDetector(
                        onTap: () {
                          final isLike = !value;
                          if (isLike) {
                            _postsBloc.likePost(postModel.id);
                          } else if (!isLike && postModel.isLiked) {
                            _postsBloc.unlikePost(postModel.id);
                          }
                          _likeValueNotifier.value = isLike;
                        },
                        child: Row(children: [
                          SvgPicture.asset(
                            SdAssets.likeIcon,
                            color: value
                                ? SdColors.primaryColor
                                : SdColors.greyColor,
                            package: commonUiPackage,
                            height: Dimens.unit2,
                            width: Dimens.unit2,
                          ),
                          SizedBox(width: Dimens.unit),
                          Text('${postModel.likes}')
                        ]),
                      ),
                    ),
                    SizedBox(height: Dimens.unit2),
                    Row(children: [
                      SvgPicture.asset(
                        SdAssets.commentIcon,
                        package: commonUiPackage,
                        height: Dimens.unit2,
                        width: Dimens.unit2,
                      ),
                      SizedBox(
                        width: Dimens.unit,
                      ),
                      Text('${postModel.comments}')
                    ]),
                    SizedBox(height: Dimens.unit),
                    divider(),
                    SizedBox(height: Dimens.unit5),
                    _addCommentWidget(),
                    FutureBuilder(),
                    _comments(),
                  ],
                );
              } else {
                return Text('No data for the post');
              }
            },
          ),
        ),
      );

  Widget _addCommentWidget() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(
          top: Dimens.unit,
          bottom: Dimens.unit,
        ),
        child: Row(children: [
          Expanded(
              child: inputField(
            inputFieldKey: Key('add_comment_field'),
            controller: _addCommentTextController,
            hint: 'Add your comment',
          )),
          GestureDetector(
            onTap: () => _addCommentAction(_addCommentTextController.text),
            child: Container(
              height: Dimens.unit3,
              width: Dimens.unit3,
              child: Center(
                child: SvgPicture.asset(
                  SdAssets.sendIcon,
                  color: SdColors.secondaryColor,
                  package: commonUiPackage,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _comments(List<CommentModel> comments) => Container(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Container();
          },
        ),
      );

  void _addCommentAction(String message) {
    _addCommentTextController.clear();
  }
}
