import 'package:evalio_app/blocs/display_post_list_bloc.dart';
import 'package:evalio_app/blocs/posts_bloc.dart';
import 'package:evalio_app/presentation/common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostsList extends StatelessWidget {
  final CommonProcessing common = CommonProcessing();

  // 日付のフォーマット(yyyyMMdd)
  final _format = DateFormat("yyyyMMdd", "ja_JP");

  @override
  Widget build(BuildContext context) {
    final _streamCtrl = Provider.of<DisplayPostsListBloc>(context);
    final _postsCtrl = Provider.of<PostsBloc>(context);

    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  splashColor: Colors.green.shade100,
                  onTap: () {
                    _streamCtrl.selectedTrend();
                    _streamCtrl.selectedIndexChanged(0);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: _streamCtrl.getISTrend
                                ? Colors.green
                                : Colors.grey.shade300),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.trending_up,
                            color: _streamCtrl.getISTrend
                                ? Colors.green
                                : Colors.grey,
                          ),
                        ),
                        Text(
                          'トレンド',
                          style: _streamCtrl.getISTrend
                              ? TextStyle(fontSize: 17)
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  splashColor: Colors.green.shade100,
                  onTap: () {
                    _streamCtrl.selectedNew();
                    _streamCtrl.selectedIndexChanged(1);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: _streamCtrl.getIsNew
                                  ? Colors.green
                                  : Colors.grey.shade300)),
                    ),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.fiber_new,
                            color: _streamCtrl.getIsNew
                                ? Colors.green
                                : Colors.grey,
                          ),
                        ),
                        Text(
                          '最新',
                          style: _streamCtrl.getIsNew
                              ? TextStyle(fontSize: 17)
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: Expanded(
              child: IndexedStack(
                index: _streamCtrl.getCurIndex,
                children: <Widget>[
                  _postsCtrl.getPostTrendModelDoc == null
                      ? CircularProgressIndicator()
                      : common.postList(
                          _postsCtrl.getPostTrendModelDoc, _format, context),
                  _postsCtrl.getPostTrendModelDoc == null
                      ? CircularProgressIndicator()
                      : common.postList(
                          _postsCtrl.getPostNewModelDoc, _format, context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
