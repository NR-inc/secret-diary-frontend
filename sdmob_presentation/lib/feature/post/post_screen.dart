import 'package:common_ui/common_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sddomain/export/domain.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:ssecretdiary/feature/widgets/base_state.dart';

class PostScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PostState();
}

class _PostState extends BaseState<PostScreen> {
  final PostsBloc _postsBloc = Injector.getInjector().get<PostsBloc>();

  final _titleTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  final _checkValueNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    _postsBloc.errorStream.handleError(handleError);
    _postsBloc.postCreationStream.listen((event) {
      Navigator.pop(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Create post')),
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
          child: Column(children: <Widget>[
        inputField(
          inputFieldKey: Key(Locators.postTitleFieldLocator),
          errorFieldKey: Key(Locators.postTitleErrorLocator),
          controller: _titleTextController,
          hint: SdStrings.postTitleHint,
        ),
        inputField(
          inputFieldKey: Key(Locators.postDescriptionFieldLocator),
          errorFieldKey: Key(Locators.postDescriptionErrorLocator),
          controller: _descriptionTextController,
          hint: SdStrings.postDescriptionHint,
        ),
        Row(children: <Widget>[
          Text(SdStrings.postVisibilityFlagHint),
          ValueListenableBuilder(
            valueListenable: _checkValueNotifier,
            builder: (context, value, child) => Checkbox(
              value: value,
              tristate: false,
              onChanged: (bool value) => _checkValueNotifier.value = value,
            ),
          ),
        ]),
        simpleButton(
          key: Key(Locators.createPostButtonLocator),
          text: SdStrings.createPostButton,
          onPressed: () => _postsBloc.createPost(
            _titleTextController.text,
            _descriptionTextController.text,
            _checkValueNotifier.value,
          ),
        )
      ]));
}
