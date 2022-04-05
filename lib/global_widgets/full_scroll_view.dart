import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double _endReachedThreshold = 200;

class FullScrollView extends StatefulWidget {
  final SliverMultiBoxAdaptorWidget child;
  final bool Function()? placeholderChecker;
  final Widget? placeholder;
  final Future<void> Function()? onPullToRefresh;
  final Future<void> Function()? onLoadMore;
  final bool canLoadMore;

  const FullScrollView({
    Key? key,
    required this.child,
    this.placeholderChecker,
    this.placeholder,
    this.onPullToRefresh,
    this.onLoadMore,
    this.canLoadMore = false,
  }) : super(key: key);

  @override
  State<FullScrollView> createState() => _FullScrollViewState();
}

class _FullScrollViewState extends State<FullScrollView> {
  bool _isLoading = false;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _controller,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        if (widget.onPullToRefresh != null)
          CupertinoSliverRefreshControl(
            onRefresh: widget.onPullToRefresh!,
          ),
        _buildList(context),
        if (_isLoading) SliverToBoxAdapter(child: _buildLoadMore(context))
      ],
    );
  }

  Widget _buildList(BuildContext context) {
    bool isNull = true;
    if (widget.placeholderChecker == null) {
      final itemCount = widget.child.delegate.estimatedChildCount;
      isNull = itemCount == 0;
    } else {
      isNull = widget.placeholderChecker!();
    }

    if (isNull) {
      return SliverFillRemaining(child: Center(child: widget.placeholder));
    }

    return widget.child;
  }

  Widget _buildLoadMore(BuildContext context) {
    if (!_isLoading) return const SizedBox.shrink();
    return Center(
      child: Container(
        width: 20,
        height: 20,
        margin: const EdgeInsets.all(16),
        child: const CupertinoActivityIndicator(),
      ),
    );
  }

  void _onScroll() {
    if (!widget.canLoadMore) return;

    if (!_controller.hasClients || _isLoading) return;

    final thresholdReached =
        _controller.position.extentAfter < _endReachedThreshold;

    if (thresholdReached) {
      if (widget.onLoadMore != null) {
        setState(() => _isLoading = true);

        widget.onLoadMore!().then((_) => setState(() => _isLoading = false));
      }
    }
  }
}
