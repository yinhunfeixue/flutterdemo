import 'package:flutter/material.dart';
import 'package:myapp/widgets/Box.dart';

class ListResponse {
  List data;
  int total;

  ListResponse(this.data, this.total);
}

class RefreshList extends StatefulWidget {
  final Future<ListResponse> Function(int) requestFun;
  final Widget Function(Object, int) itemBuilder;
  final int startPage;

  RefreshList(this.requestFun, this.itemBuilder, {this.startPage = 1});

  @override
  State<StatefulWidget> createState() {
    return new FreshListState();
  }
}

class FreshListState extends State<RefreshList> {
  int currentPage;
  List dataSource = [];
  ScrollController _controller = new ScrollController();
  bool loading = false;
  int total;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: this._onRefresh,
        child: ListView.builder(
            controller: this._controller,
            itemCount: dataSource.length + 1,
            itemBuilder: _itemBuilder));
  }

  Future _onRefresh() async {
    this._reset();
    this._request();
  }

  Widget _itemBuilder(BuildContext context, int index) {
    if (index < dataSource.length) {
      return widget.itemBuilder(dataSource[index], index);
    }

    String text = _getBottomText();
    if (text != null) {
      return Box(
          padding: 10,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: new TextStyle(color: Colors.black26),
          ));
    }
    return null;
  }

  String _getBottomText() {
    if (loading) {
      return '加载中';
    } else if (_isEnd) {
      return '暂无更多';
    }
    return null;
  }

  bool get _isEnd {
    return this.total != null && dataSource.length >= this.total;
  }

  void _reset() {
    this.dataSource.clear();
    this.currentPage = widget.startPage;
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels >
          _controller.position.maxScrollExtent - 100) {
        this._request();
      }
    });
    this._reset();
    this._request();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _request() async {
    if (widget.requestFun == null) {
      return;
    }

    if (_isEnd) {
      return;
    }

    if (this.loading) {
      return;
    }

    setState(() {
      loading = true;
    });
    ListResponse res = await widget.requestFun(this.currentPage);

    if (res != null && res.data != null) {
      this.dataSource.addAll(res.data);
    }
    setState(() {
      currentPage = currentPage + 1;
      loading = false;
      total = res.total;
    });
  }
}
