import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// StateFul cubit base for work. Almost like bloc
abstract class BaseStatefulCubit<SF extends StatefulWidget, C extends Cubit<S>,
    S> extends State<SF> {
  late C cubit;
  void initCubit();
  @override
  void initState() {
    initCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildWidgets(context);
  }

  // init cubit
  Widget buildWidgets(BuildContext context) {
    return BlocProvider<C>(
      lazy: true,
      create: (_) => cubit,
      child: BlocConsumer<C, S>(
        builder: builder,
        listener: listener,
      ),
    );
  }

  /// render view
  Widget builder(BuildContext context, S state);

  /// listener notifier
  void listener(BuildContext context, S state) {}
}
