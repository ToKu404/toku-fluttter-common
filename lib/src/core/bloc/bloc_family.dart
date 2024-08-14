import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

typedef _SSS = StateStreamableSource;

class BlocFamily<Parent extends _SSS> {
  const BlocFamily({
    required this.parent,
    required this.children,
  }) : assert(children.length >= 1, 'BlocFamily must have at least one child');

  final Parent parent;
  final Set<_SSS> children;

  C getChild<C extends _SSS>() => children.firstWhere((it) => it is C) as C;
}

abstract class BlocFamilyProvider<Parent extends _SSS> extends MultiBlocProvider {
  BlocFamilyProvider({
    super.key,
    required SingleChildWidget parentProvider,
    required List<SingleChildWidget> childrenProvider,
    required super.child,
  })  : assert(
          childrenProvider.isNotEmpty,
          'BlocFamilyProvider must have at least one child',
        ),
        super(providers: <SingleChildWidget>[
          parentProvider,
          ...childrenProvider,
        ]);
}

class BlocFamilyProvider2<Parent extends _SSS, Child0 extends _SSS, Child1 extends _SSS>
    extends BlocFamilyProvider<Parent> {
  BlocFamilyProvider2({
    super.key,
    required BlocFamily<Parent> family,
    required super.child,
  }) : super(
          parentProvider: BlocProvider<Parent>(
            lazy: false,
            create: (_) => family.parent,
          ),
          childrenProvider: <BlocProvider>[
            BlocProvider<Child0>(
              lazy: false,
              create: (_) => family.getChild<Child0>(),
            ),
            BlocProvider<Child1>(
              lazy: false,
              create: (_) => family.getChild<Child1>(),
            ),
          ],
        );
}

class BlocFamilyProvider3<Parent extends _SSS, Child0 extends _SSS, Child1 extends _SSS, Child2 extends _SSS>
    extends BlocFamilyProvider<Parent> {
  BlocFamilyProvider3({
    super.key,
    required BlocFamily<Parent> family,
    required super.child,
  }) : super(
          parentProvider: BlocProvider<Parent>(
            lazy: false,
            create: (_) => family.parent,
          ),
          childrenProvider: <BlocProvider>[
            BlocProvider<Child0>(
              lazy: false,
              create: (_) => family.getChild<Child0>(),
            ),
            BlocProvider<Child1>(
              lazy: false,
              create: (_) => family.getChild<Child1>(),
            ),
            BlocProvider<Child2>(
              lazy: false,
              create: (_) => family.getChild<Child2>(),
            ),
          ],
        );
}

class BlocFamilyProvider4<Parent extends _SSS, Child0 extends _SSS, Child1 extends _SSS, Child2 extends _SSS,
    Child3 extends _SSS> extends BlocFamilyProvider<Parent> {
  BlocFamilyProvider4({
    super.key,
    required BlocFamily<Parent> family,
    required super.child,
  }) : super(
          parentProvider: BlocProvider<Parent>(
            lazy: false,
            create: (_) => family.parent,
          ),
          childrenProvider: <BlocProvider>[
            BlocProvider<Child0>(
              lazy: false,
              create: (_) => family.getChild<Child0>(),
            ),
            BlocProvider<Child1>(
              lazy: false,
              create: (_) => family.getChild<Child1>(),
            ),
            BlocProvider<Child2>(
              lazy: false,
              create: (_) => family.getChild<Child2>(),
            ),
            BlocProvider<Child3>(
              lazy: false,
              create: (_) => family.getChild<Child3>(),
            ),
          ],
        );
}

class BlocFamilyProvider5<Parent extends _SSS, Child0 extends _SSS, Child1 extends _SSS, Child2 extends _SSS,
    Child3 extends _SSS, Child4 extends _SSS> extends BlocFamilyProvider<Parent> {
  BlocFamilyProvider5({
    super.key,
    required BlocFamily<Parent> family,
    required super.child,
  }) : super(
          parentProvider: BlocProvider<Parent>(
            lazy: false,
            create: (_) => family.parent,
          ),
          childrenProvider: <BlocProvider>[
            BlocProvider<Child0>(
              lazy: false,
              create: (_) => family.getChild<Child0>(),
            ),
            BlocProvider<Child1>(
              lazy: false,
              create: (_) => family.getChild<Child1>(),
            ),
            BlocProvider<Child2>(
              lazy: false,
              create: (_) => family.getChild<Child2>(),
            ),
            BlocProvider<Child3>(
              lazy: false,
              create: (_) => family.getChild<Child3>(),
            ),
            BlocProvider<Child4>(
              lazy: false,
              create: (_) => family.getChild<Child4>(),
            ),
          ],
        );
}

class BlocFamilyProvider6<Parent extends _SSS, Child0 extends _SSS, Child1 extends _SSS, Child2 extends _SSS,
    Child3 extends _SSS, Child4 extends _SSS, Child5 extends _SSS> extends BlocFamilyProvider<Parent> {
  BlocFamilyProvider6({
    super.key,
    required BlocFamily<Parent> family,
    required super.child,
  }) : super(
          parentProvider: BlocProvider<Parent>(
            lazy: false,
            create: (_) => family.parent,
          ),
          childrenProvider: <BlocProvider>[
            BlocProvider<Child0>(
              lazy: false,
              create: (_) => family.getChild<Child0>(),
            ),
            BlocProvider<Child1>(
              lazy: false,
              create: (_) => family.getChild<Child1>(),
            ),
            BlocProvider<Child2>(
              lazy: false,
              create: (_) => family.getChild<Child2>(),
            ),
            BlocProvider<Child3>(
              lazy: false,
              create: (_) => family.getChild<Child3>(),
            ),
            BlocProvider<Child4>(
              lazy: false,
              create: (_) => family.getChild<Child4>(),
            ),
            BlocProvider<Child5>(
              lazy: false,
              create: (_) => family.getChild<Child5>(),
            ),
          ],
        );
}

class BlocFamilyProvider7<
    Parent extends _SSS,
    Child0 extends _SSS,
    Child1 extends _SSS,
    Child2 extends _SSS,
    Child3 extends _SSS,
    Child4 extends _SSS,
    Child5 extends _SSS,
    Child6 extends _SSS> extends BlocFamilyProvider<Parent> {
  BlocFamilyProvider7({
    super.key,
    required BlocFamily<Parent> family,
    required super.child,
  }) : super(
          parentProvider: BlocProvider<Parent>(
            lazy: false,
            create: (_) => family.parent,
          ),
          childrenProvider: <BlocProvider>[
            BlocProvider<Child0>(
              lazy: false,
              create: (_) => family.getChild<Child0>(),
            ),
            BlocProvider<Child1>(
              lazy: false,
              create: (_) => family.getChild<Child1>(),
            ),
            BlocProvider<Child2>(
              lazy: false,
              create: (_) => family.getChild<Child2>(),
            ),
            BlocProvider<Child3>(
              lazy: false,
              create: (_) => family.getChild<Child3>(),
            ),
            BlocProvider<Child4>(
              lazy: false,
              create: (_) => family.getChild<Child4>(),
            ),
            BlocProvider<Child5>(
              lazy: false,
              create: (_) => family.getChild<Child5>(),
            ),
            BlocProvider<Child6>(
              lazy: false,
              create: (_) => family.getChild<Child6>(),
            ),
          ],
        );
}

class BlocFamilyProvider8<
    Parent extends _SSS,
    Child0 extends _SSS,
    Child1 extends _SSS,
    Child2 extends _SSS,
    Child3 extends _SSS,
    Child4 extends _SSS,
    Child5 extends _SSS,
    Child6 extends _SSS,
    Child7 extends _SSS> extends BlocFamilyProvider<Parent> {
  BlocFamilyProvider8({
    super.key,
    required BlocFamily<Parent> family,
    required super.child,
  }) : super(
          parentProvider: BlocProvider<Parent>(
            lazy: false,
            create: (_) => family.parent,
          ),
          childrenProvider: <BlocProvider>[
            BlocProvider<Child0>(
              lazy: false,
              create: (_) => family.getChild<Child0>(),
            ),
            BlocProvider<Child1>(
              lazy: false,
              create: (_) => family.getChild<Child1>(),
            ),
            BlocProvider<Child2>(
              lazy: false,
              create: (_) => family.getChild<Child2>(),
            ),
            BlocProvider<Child3>(
              lazy: false,
              create: (_) => family.getChild<Child3>(),
            ),
            BlocProvider<Child4>(
              lazy: false,
              create: (_) => family.getChild<Child4>(),
            ),
            BlocProvider<Child5>(
              lazy: false,
              create: (_) => family.getChild<Child5>(),
            ),
            BlocProvider<Child6>(
              lazy: false,
              create: (_) => family.getChild<Child6>(),
            ),
            BlocProvider<Child7>(
              lazy: false,
              create: (_) => family.getChild<Child7>(),
            ),
          ],
        );
}

class BlocFamilyProvider9<
    Parent extends _SSS,
    Child0 extends _SSS,
    Child1 extends _SSS,
    Child2 extends _SSS,
    Child3 extends _SSS,
    Child4 extends _SSS,
    Child5 extends _SSS,
    Child6 extends _SSS,
    Child7 extends _SSS,
    Child8 extends _SSS> extends BlocFamilyProvider<Parent> {
  BlocFamilyProvider9({
    super.key,
    required BlocFamily<Parent> family,
    required super.child,
  }) : super(
          parentProvider: BlocProvider<Parent>(
            lazy: false,
            create: (_) => family.parent,
          ),
          childrenProvider: <BlocProvider>[
            BlocProvider<Child0>(
              lazy: false,
              create: (_) => family.getChild<Child0>(),
            ),
            BlocProvider<Child1>(
              lazy: false,
              create: (_) => family.getChild<Child1>(),
            ),
            BlocProvider<Child2>(
              lazy: false,
              create: (_) => family.getChild<Child2>(),
            ),
            BlocProvider<Child3>(
              lazy: false,
              create: (_) => family.getChild<Child3>(),
            ),
            BlocProvider<Child4>(
              lazy: false,
              create: (_) => family.getChild<Child4>(),
            ),
            BlocProvider<Child5>(
              lazy: false,
              create: (_) => family.getChild<Child5>(),
            ),
            BlocProvider<Child6>(
              lazy: false,
              create: (_) => family.getChild<Child6>(),
            ),
            BlocProvider<Child7>(
              lazy: false,
              create: (_) => family.getChild<Child7>(),
            ),
            BlocProvider<Child8>(
              lazy: false,
              create: (_) => family.getChild<Child8>(),
            ),
          ],
        );
}

class BlocFamilyProvider10<
    Parent extends _SSS,
    Child0 extends _SSS,
    Child1 extends _SSS,
    Child2 extends _SSS,
    Child3 extends _SSS,
    Child4 extends _SSS,
    Child5 extends _SSS,
    Child6 extends _SSS,
    Child7 extends _SSS,
    Child8 extends _SSS,
    Child9 extends _SSS> extends BlocFamilyProvider<Parent> {
  BlocFamilyProvider10({
    super.key,
    required BlocFamily<Parent> family,
    required super.child,
  }) : super(
          parentProvider: BlocProvider<Parent>(
            lazy: false,
            create: (_) => family.parent,
          ),
          childrenProvider: <BlocProvider>[
            BlocProvider<Child0>(
              lazy: false,
              create: (_) => family.getChild<Child0>(),
            ),
            BlocProvider<Child1>(
              lazy: false,
              create: (_) => family.getChild<Child1>(),
            ),
            BlocProvider<Child2>(
              lazy: false,
              create: (_) => family.getChild<Child2>(),
            ),
            BlocProvider<Child3>(
              lazy: false,
              create: (_) => family.getChild<Child3>(),
            ),
            BlocProvider<Child4>(
              lazy: false,
              create: (_) => family.getChild<Child4>(),
            ),
            BlocProvider<Child5>(
              lazy: false,
              create: (_) => family.getChild<Child5>(),
            ),
            BlocProvider<Child6>(
              lazy: false,
              create: (_) => family.getChild<Child6>(),
            ),
            BlocProvider<Child7>(
              lazy: false,
              create: (_) => family.getChild<Child7>(),
            ),
            BlocProvider<Child8>(
              lazy: false,
              create: (_) => family.getChild<Child8>(),
            ),
            BlocProvider<Child9>(
              lazy: false,
              create: (_) => family.getChild<Child9>(),
            ),
          ],
        );
}

class BlocFamilyProvider11<
    Parent extends _SSS,
    Child0 extends _SSS,
    Child1 extends _SSS,
    Child2 extends _SSS,
    Child3 extends _SSS,
    Child4 extends _SSS,
    Child5 extends _SSS,
    Child6 extends _SSS,
    Child7 extends _SSS,
    Child8 extends _SSS,
    Child9 extends _SSS,
    Child10 extends _SSS> extends BlocFamilyProvider<Parent> {
  BlocFamilyProvider11({
    super.key,
    required BlocFamily<Parent> family,
    required super.child,
  }) : super(
          parentProvider: BlocProvider<Parent>(
            lazy: false,
            create: (_) => family.parent,
          ),
          childrenProvider: <BlocProvider>[
            BlocProvider<Child0>(
              lazy: false,
              create: (_) => family.getChild<Child0>(),
            ),
            BlocProvider<Child1>(
              lazy: false,
              create: (_) => family.getChild<Child1>(),
            ),
            BlocProvider<Child2>(
              lazy: false,
              create: (_) => family.getChild<Child2>(),
            ),
            BlocProvider<Child3>(
              lazy: false,
              create: (_) => family.getChild<Child3>(),
            ),
            BlocProvider<Child4>(
              lazy: false,
              create: (_) => family.getChild<Child4>(),
            ),
            BlocProvider<Child5>(
              lazy: false,
              create: (_) => family.getChild<Child5>(),
            ),
            BlocProvider<Child6>(
              lazy: false,
              create: (_) => family.getChild<Child6>(),
            ),
            BlocProvider<Child7>(
              lazy: false,
              create: (_) => family.getChild<Child7>(),
            ),
            BlocProvider<Child8>(
              lazy: false,
              create: (_) => family.getChild<Child8>(),
            ),
            BlocProvider<Child9>(
              lazy: false,
              create: (_) => family.getChild<Child9>(),
            ),
            BlocProvider<Child10>(
              lazy: false,
              create: (_) => family.getChild<Child10>(),
            ),
          ],
        );
}

class BlocFamilyProvider12<
    Parent extends _SSS,
    Child0 extends _SSS,
    Child1 extends _SSS,
    Child2 extends _SSS,
    Child3 extends _SSS,
    Child4 extends _SSS,
    Child5 extends _SSS,
    Child6 extends _SSS,
    Child7 extends _SSS,
    Child8 extends _SSS,
    Child9 extends _SSS,
    Child10 extends _SSS,
    Child11 extends _SSS> extends BlocFamilyProvider<Parent> {
  BlocFamilyProvider12({
    super.key,
    required BlocFamily<Parent> family,
    required super.child,
  }) : super(
          parentProvider: BlocProvider<Parent>(
            lazy: false,
            create: (_) => family.parent,
          ),
          childrenProvider: <BlocProvider>[
            BlocProvider<Child0>(
              lazy: false,
              create: (_) => family.getChild<Child0>(),
            ),
            BlocProvider<Child1>(
              lazy: false,
              create: (_) => family.getChild<Child1>(),
            ),
            BlocProvider<Child2>(
              lazy: false,
              create: (_) => family.getChild<Child2>(),
            ),
            BlocProvider<Child3>(
              lazy: false,
              create: (_) => family.getChild<Child3>(),
            ),
            BlocProvider<Child4>(
              lazy: false,
              create: (_) => family.getChild<Child4>(),
            ),
            BlocProvider<Child5>(
              lazy: false,
              create: (_) => family.getChild<Child5>(),
            ),
            BlocProvider<Child6>(
              lazy: false,
              create: (_) => family.getChild<Child6>(),
            ),
            BlocProvider<Child7>(
              lazy: false,
              create: (_) => family.getChild<Child7>(),
            ),
            BlocProvider<Child8>(
              lazy: false,
              create: (_) => family.getChild<Child8>(),
            ),
            BlocProvider<Child9>(
              lazy: false,
              create: (_) => family.getChild<Child9>(),
            ),
            BlocProvider<Child10>(
              lazy: false,
              create: (_) => family.getChild<Child10>(),
            ),
            BlocProvider<Child11>(
              lazy: false,
              create: (_) => family.getChild<Child11>(),
            ),
          ],
        );
}

class BlocFamilyProvider13<
    Parent extends _SSS,
    Child0 extends _SSS,
    Child1 extends _SSS,
    Child2 extends _SSS,
    Child3 extends _SSS,
    Child4 extends _SSS,
    Child5 extends _SSS,
    Child6 extends _SSS,
    Child7 extends _SSS,
    Child8 extends _SSS,
    Child9 extends _SSS,
    Child10 extends _SSS,
    Child11 extends _SSS,
    Child12 extends _SSS> extends BlocFamilyProvider<Parent> {
  BlocFamilyProvider13({
    super.key,
    required BlocFamily<Parent> family,
    required super.child,
  }) : super(
          parentProvider: BlocProvider<Parent>(
            lazy: false,
            create: (_) => family.parent,
          ),
          childrenProvider: <BlocProvider>[
            BlocProvider<Child0>(
              lazy: false,
              create: (_) => family.getChild<Child0>(),
            ),
            BlocProvider<Child1>(
              lazy: false,
              create: (_) => family.getChild<Child1>(),
            ),
            BlocProvider<Child2>(
              lazy: false,
              create: (_) => family.getChild<Child2>(),
            ),
            BlocProvider<Child3>(
              lazy: false,
              create: (_) => family.getChild<Child3>(),
            ),
            BlocProvider<Child4>(
              lazy: false,
              create: (_) => family.getChild<Child4>(),
            ),
            BlocProvider<Child5>(
              lazy: false,
              create: (_) => family.getChild<Child5>(),
            ),
            BlocProvider<Child6>(
              lazy: false,
              create: (_) => family.getChild<Child6>(),
            ),
            BlocProvider<Child7>(
              lazy: false,
              create: (_) => family.getChild<Child7>(),
            ),
            BlocProvider<Child8>(
              lazy: false,
              create: (_) => family.getChild<Child8>(),
            ),
            BlocProvider<Child9>(
              lazy: false,
              create: (_) => family.getChild<Child9>(),
            ),
            BlocProvider<Child10>(
              lazy: false,
              create: (_) => family.getChild<Child10>(),
            ),
            BlocProvider<Child11>(
              lazy: false,
              create: (_) => family.getChild<Child11>(),
            ),
            BlocProvider<Child12>(
              lazy: false,
              create: (_) => family.getChild<Child12>(),
            ),
          ],
        );
}

class BlocFamilyProvider14<
    Parent extends _SSS,
    Child0 extends _SSS,
    Child1 extends _SSS,
    Child2 extends _SSS,
    Child3 extends _SSS,
    Child4 extends _SSS,
    Child5 extends _SSS,
    Child6 extends _SSS,
    Child7 extends _SSS,
    Child8 extends _SSS,
    Child9 extends _SSS,
    Child10 extends _SSS,
    Child11 extends _SSS,
    Child12 extends _SSS,
    Child13 extends _SSS> extends BlocFamilyProvider<Parent> {
  BlocFamilyProvider14({
    super.key,
    required BlocFamily<Parent> family,
    required super.child,
  }) : super(
          parentProvider: BlocProvider<Parent>(
            lazy: false,
            create: (_) => family.parent,
          ),
          childrenProvider: <BlocProvider>[
            BlocProvider<Child0>(
              lazy: false,
              create: (_) => family.getChild<Child0>(),
            ),
            BlocProvider<Child1>(
              lazy: false,
              create: (_) => family.getChild<Child1>(),
            ),
            BlocProvider<Child2>(
              lazy: false,
              create: (_) => family.getChild<Child2>(),
            ),
            BlocProvider<Child3>(
              lazy: false,
              create: (_) => family.getChild<Child3>(),
            ),
            BlocProvider<Child4>(
              lazy: false,
              create: (_) => family.getChild<Child4>(),
            ),
            BlocProvider<Child5>(
              lazy: false,
              create: (_) => family.getChild<Child5>(),
            ),
            BlocProvider<Child6>(
              lazy: false,
              create: (_) => family.getChild<Child6>(),
            ),
            BlocProvider<Child7>(
              lazy: false,
              create: (_) => family.getChild<Child7>(),
            ),
            BlocProvider<Child8>(
              lazy: false,
              create: (_) => family.getChild<Child8>(),
            ),
            BlocProvider<Child9>(
              lazy: false,
              create: (_) => family.getChild<Child9>(),
            ),
            BlocProvider<Child10>(
              lazy: false,
              create: (_) => family.getChild<Child10>(),
            ),
            BlocProvider<Child11>(
              lazy: false,
              create: (_) => family.getChild<Child11>(),
            ),
            BlocProvider<Child12>(
              lazy: false,
              create: (_) => family.getChild<Child12>(),
            ),
            BlocProvider<Child13>(
              lazy: false,
              create: (_) => family.getChild<Child13>(),
            ),
          ],
        );
}

class BlocFamilyProvider15<
    Parent extends _SSS,
    Child0 extends _SSS,
    Child1 extends _SSS,
    Child2 extends _SSS,
    Child3 extends _SSS,
    Child4 extends _SSS,
    Child5 extends _SSS,
    Child6 extends _SSS,
    Child7 extends _SSS,
    Child8 extends _SSS,
    Child9 extends _SSS,
    Child10 extends _SSS,
    Child11 extends _SSS,
    Child12 extends _SSS,
    Child13 extends _SSS,
    Child14 extends _SSS> extends BlocFamilyProvider<Parent> {
  BlocFamilyProvider15({
    super.key,
    required BlocFamily<Parent> family,
    required super.child,
  }) : super(
          parentProvider: BlocProvider<Parent>(
            lazy: false,
            create: (_) => family.parent,
          ),
          childrenProvider: <BlocProvider>[
            BlocProvider<Child0>(
              lazy: false,
              create: (_) => family.getChild<Child0>(),
            ),
            BlocProvider<Child1>(
              lazy: false,
              create: (_) => family.getChild<Child1>(),
            ),
            BlocProvider<Child2>(
              lazy: false,
              create: (_) => family.getChild<Child2>(),
            ),
            BlocProvider<Child3>(
              lazy: false,
              create: (_) => family.getChild<Child3>(),
            ),
            BlocProvider<Child4>(
              lazy: false,
              create: (_) => family.getChild<Child4>(),
            ),
            BlocProvider<Child5>(
              lazy: false,
              create: (_) => family.getChild<Child5>(),
            ),
            BlocProvider<Child6>(
              lazy: false,
              create: (_) => family.getChild<Child6>(),
            ),
            BlocProvider<Child7>(
              lazy: false,
              create: (_) => family.getChild<Child7>(),
            ),
            BlocProvider<Child8>(
              lazy: false,
              create: (_) => family.getChild<Child8>(),
            ),
            BlocProvider<Child9>(
              lazy: false,
              create: (_) => family.getChild<Child9>(),
            ),
            BlocProvider<Child10>(
              lazy: false,
              create: (_) => family.getChild<Child10>(),
            ),
            BlocProvider<Child11>(
              lazy: false,
              create: (_) => family.getChild<Child11>(),
            ),
            BlocProvider<Child12>(
              lazy: false,
              create: (_) => family.getChild<Child12>(),
            ),
            BlocProvider<Child13>(
              lazy: false,
              create: (_) => family.getChild<Child13>(),
            ),
            BlocProvider<Child14>(
              lazy: false,
              create: (_) => family.getChild<Child14>(),
            ),
          ],
        );
}

class BlocFamilyProvider16<
    Parent extends _SSS,
    Child0 extends _SSS,
    Child1 extends _SSS,
    Child2 extends _SSS,
    Child3 extends _SSS,
    Child4 extends _SSS,
    Child5 extends _SSS,
    Child6 extends _SSS,
    Child7 extends _SSS,
    Child8 extends _SSS,
    Child9 extends _SSS,
    Child10 extends _SSS,
    Child11 extends _SSS,
    Child12 extends _SSS,
    Child13 extends _SSS,
    Child14 extends _SSS,
    Child15 extends _SSS> extends BlocFamilyProvider<Parent> {
  BlocFamilyProvider16({
    super.key,
    required BlocFamily<Parent> family,
    required super.child,
  }) : super(
          parentProvider: BlocProvider<Parent>(
            lazy: false,
            create: (_) => family.parent,
          ),
          childrenProvider: <BlocProvider>[
            BlocProvider<Child0>(
              lazy: false,
              create: (_) => family.getChild<Child0>(),
            ),
            BlocProvider<Child1>(
              lazy: false,
              create: (_) => family.getChild<Child1>(),
            ),
            BlocProvider<Child2>(
              lazy: false,
              create: (_) => family.getChild<Child2>(),
            ),
            BlocProvider<Child3>(
              lazy: false,
              create: (_) => family.getChild<Child3>(),
            ),
            BlocProvider<Child4>(
              lazy: false,
              create: (_) => family.getChild<Child4>(),
            ),
            BlocProvider<Child5>(
              lazy: false,
              create: (_) => family.getChild<Child5>(),
            ),
            BlocProvider<Child6>(
              lazy: false,
              create: (_) => family.getChild<Child6>(),
            ),
            BlocProvider<Child7>(
              lazy: false,
              create: (_) => family.getChild<Child7>(),
            ),
            BlocProvider<Child8>(
              lazy: false,
              create: (_) => family.getChild<Child8>(),
            ),
            BlocProvider<Child9>(
              lazy: false,
              create: (_) => family.getChild<Child9>(),
            ),
            BlocProvider<Child10>(
              lazy: false,
              create: (_) => family.getChild<Child10>(),
            ),
            BlocProvider<Child11>(
              lazy: false,
              create: (_) => family.getChild<Child11>(),
            ),
            BlocProvider<Child12>(
              lazy: false,
              create: (_) => family.getChild<Child12>(),
            ),
            BlocProvider<Child13>(
              lazy: false,
              create: (_) => family.getChild<Child13>(),
            ),
            BlocProvider<Child14>(
              lazy: false,
              create: (_) => family.getChild<Child14>(),
            ),
            BlocProvider<Child15>(
              lazy: false,
              create: (_) => family.getChild<Child15>(),
            ),
          ],
        );
}

class BlocFamilyProvider17<
    Parent extends _SSS,
    Child0 extends _SSS,
    Child1 extends _SSS,
    Child2 extends _SSS,
    Child3 extends _SSS,
    Child4 extends _SSS,
    Child5 extends _SSS,
    Child6 extends _SSS,
    Child7 extends _SSS,
    Child8 extends _SSS,
    Child9 extends _SSS,
    Child10 extends _SSS,
    Child11 extends _SSS,
    Child12 extends _SSS,
    Child13 extends _SSS,
    Child14 extends _SSS,
    Child15 extends _SSS,
    Child16 extends _SSS> extends BlocFamilyProvider<Parent> {
  BlocFamilyProvider17({
    super.key,
    required BlocFamily<Parent> family,
    required super.child,
  }) : super(
          parentProvider: BlocProvider<Parent>(
            lazy: false,
            create: (_) => family.parent,
          ),
          childrenProvider: <BlocProvider>[
            BlocProvider<Child0>(
              lazy: false,
              create: (_) => family.getChild<Child0>(),
            ),
            BlocProvider<Child1>(
              lazy: false,
              create: (_) => family.getChild<Child1>(),
            ),
            BlocProvider<Child2>(
              lazy: false,
              create: (_) => family.getChild<Child2>(),
            ),
            BlocProvider<Child3>(
              lazy: false,
              create: (_) => family.getChild<Child3>(),
            ),
            BlocProvider<Child4>(
              lazy: false,
              create: (_) => family.getChild<Child4>(),
            ),
            BlocProvider<Child5>(
              lazy: false,
              create: (_) => family.getChild<Child5>(),
            ),
            BlocProvider<Child6>(
              lazy: false,
              create: (_) => family.getChild<Child6>(),
            ),
            BlocProvider<Child7>(
              lazy: false,
              create: (_) => family.getChild<Child7>(),
            ),
            BlocProvider<Child8>(
              lazy: false,
              create: (_) => family.getChild<Child8>(),
            ),
            BlocProvider<Child9>(
              lazy: false,
              create: (_) => family.getChild<Child9>(),
            ),
            BlocProvider<Child10>(
              lazy: false,
              create: (_) => family.getChild<Child10>(),
            ),
            BlocProvider<Child11>(
              lazy: false,
              create: (_) => family.getChild<Child11>(),
            ),
            BlocProvider<Child12>(
              lazy: false,
              create: (_) => family.getChild<Child12>(),
            ),
            BlocProvider<Child13>(
              lazy: false,
              create: (_) => family.getChild<Child13>(),
            ),
            BlocProvider<Child14>(
              lazy: false,
              create: (_) => family.getChild<Child14>(),
            ),
            BlocProvider<Child15>(
              lazy: false,
              create: (_) => family.getChild<Child15>(),
            ),
            BlocProvider<Child16>(
              lazy: false,
              create: (_) => family.getChild<Child16>(),
            ),
          ],
        );
}

class BlocFamilyProvider18<
    Parent extends _SSS,
    Child0 extends _SSS,
    Child1 extends _SSS,
    Child2 extends _SSS,
    Child3 extends _SSS,
    Child4 extends _SSS,
    Child5 extends _SSS,
    Child6 extends _SSS,
    Child7 extends _SSS,
    Child8 extends _SSS,
    Child9 extends _SSS,
    Child10 extends _SSS,
    Child11 extends _SSS,
    Child12 extends _SSS,
    Child13 extends _SSS,
    Child14 extends _SSS,
    Child15 extends _SSS,
    Child16 extends _SSS,
    Child17 extends _SSS> extends BlocFamilyProvider<Parent> {
  BlocFamilyProvider18({
    super.key,
    required BlocFamily<Parent> family,
    required super.child,
  }) : super(
          parentProvider: BlocProvider<Parent>(
            lazy: false,
            create: (_) => family.parent,
          ),
          childrenProvider: <BlocProvider>[
            BlocProvider<Child0>(
              lazy: false,
              create: (_) => family.getChild<Child0>(),
            ),
            BlocProvider<Child1>(
              lazy: false,
              create: (_) => family.getChild<Child1>(),
            ),
            BlocProvider<Child2>(
              lazy: false,
              create: (_) => family.getChild<Child2>(),
            ),
            BlocProvider<Child3>(
              lazy: false,
              create: (_) => family.getChild<Child3>(),
            ),
            BlocProvider<Child4>(
              lazy: false,
              create: (_) => family.getChild<Child4>(),
            ),
            BlocProvider<Child5>(
              lazy: false,
              create: (_) => family.getChild<Child5>(),
            ),
            BlocProvider<Child6>(
              lazy: false,
              create: (_) => family.getChild<Child6>(),
            ),
            BlocProvider<Child7>(
              lazy: false,
              create: (_) => family.getChild<Child7>(),
            ),
            BlocProvider<Child8>(
              lazy: false,
              create: (_) => family.getChild<Child8>(),
            ),
            BlocProvider<Child9>(
              lazy: false,
              create: (_) => family.getChild<Child9>(),
            ),
            BlocProvider<Child10>(
              lazy: false,
              create: (_) => family.getChild<Child10>(),
            ),
            BlocProvider<Child11>(
              lazy: false,
              create: (_) => family.getChild<Child11>(),
            ),
            BlocProvider<Child12>(
              lazy: false,
              create: (_) => family.getChild<Child12>(),
            ),
            BlocProvider<Child13>(
              lazy: false,
              create: (_) => family.getChild<Child13>(),
            ),
            BlocProvider<Child14>(
              lazy: false,
              create: (_) => family.getChild<Child14>(),
            ),
            BlocProvider<Child15>(
              lazy: false,
              create: (_) => family.getChild<Child15>(),
            ),
            BlocProvider<Child16>(
              lazy: false,
              create: (_) => family.getChild<Child16>(),
            ),
            BlocProvider<Child17>(
              lazy: false,
              create: (_) => family.getChild<Child17>(),
            ),
          ],
        );
}

class BlocFamilyProvider19<
    Parent extends _SSS,
    Child0 extends _SSS,
    Child1 extends _SSS,
    Child2 extends _SSS,
    Child3 extends _SSS,
    Child4 extends _SSS,
    Child5 extends _SSS,
    Child6 extends _SSS,
    Child7 extends _SSS,
    Child8 extends _SSS,
    Child9 extends _SSS,
    Child10 extends _SSS,
    Child11 extends _SSS,
    Child12 extends _SSS,
    Child13 extends _SSS,
    Child14 extends _SSS,
    Child15 extends _SSS,
    Child16 extends _SSS,
    Child17 extends _SSS,
    Child18 extends _SSS> extends BlocFamilyProvider<Parent> {
  BlocFamilyProvider19({
    super.key,
    required BlocFamily<Parent> family,
    required super.child,
  }) : super(
          parentProvider: BlocProvider<Parent>(
            lazy: false,
            create: (_) => family.parent,
          ),
          childrenProvider: <BlocProvider>[
            BlocProvider<Child0>(
              lazy: false,
              create: (_) => family.getChild<Child0>(),
            ),
            BlocProvider<Child1>(
              lazy: false,
              create: (_) => family.getChild<Child1>(),
            ),
            BlocProvider<Child2>(
              lazy: false,
              create: (_) => family.getChild<Child2>(),
            ),
            BlocProvider<Child3>(
              lazy: false,
              create: (_) => family.getChild<Child3>(),
            ),
            BlocProvider<Child4>(
              lazy: false,
              create: (_) => family.getChild<Child4>(),
            ),
            BlocProvider<Child5>(
              lazy: false,
              create: (_) => family.getChild<Child5>(),
            ),
            BlocProvider<Child6>(
              lazy: false,
              create: (_) => family.getChild<Child6>(),
            ),
            BlocProvider<Child7>(
              lazy: false,
              create: (_) => family.getChild<Child7>(),
            ),
            BlocProvider<Child8>(
              lazy: false,
              create: (_) => family.getChild<Child8>(),
            ),
            BlocProvider<Child9>(
              lazy: false,
              create: (_) => family.getChild<Child9>(),
            ),
            BlocProvider<Child10>(
              lazy: false,
              create: (_) => family.getChild<Child10>(),
            ),
            BlocProvider<Child11>(
              lazy: false,
              create: (_) => family.getChild<Child11>(),
            ),
            BlocProvider<Child12>(
              lazy: false,
              create: (_) => family.getChild<Child12>(),
            ),
            BlocProvider<Child13>(
              lazy: false,
              create: (_) => family.getChild<Child13>(),
            ),
            BlocProvider<Child14>(
              lazy: false,
              create: (_) => family.getChild<Child14>(),
            ),
            BlocProvider<Child15>(
              lazy: false,
              create: (_) => family.getChild<Child15>(),
            ),
            BlocProvider<Child16>(
              lazy: false,
              create: (_) => family.getChild<Child16>(),
            ),
            BlocProvider<Child17>(
              lazy: false,
              create: (_) => family.getChild<Child17>(),
            ),
            BlocProvider<Child18>(
              lazy: false,
              create: (_) => family.getChild<Child18>(),
            ),
          ],
        );
}

class BlocFamilyProvider20<
    Parent extends _SSS,
    Child0 extends _SSS,
    Child1 extends _SSS,
    Child2 extends _SSS,
    Child3 extends _SSS,
    Child4 extends _SSS,
    Child5 extends _SSS,
    Child6 extends _SSS,
    Child7 extends _SSS,
    Child8 extends _SSS,
    Child9 extends _SSS,
    Child10 extends _SSS,
    Child11 extends _SSS,
    Child12 extends _SSS,
    Child13 extends _SSS,
    Child14 extends _SSS,
    Child15 extends _SSS,
    Child16 extends _SSS,
    Child17 extends _SSS,
    Child18 extends _SSS,
    Child19 extends _SSS> extends BlocFamilyProvider<Parent> {
  BlocFamilyProvider20({
    super.key,
    required BlocFamily<Parent> family,
    required super.child,
  }) : super(
          parentProvider: BlocProvider<Parent>(
            lazy: false,
            create: (_) => family.parent,
          ),
          childrenProvider: <BlocProvider>[
            BlocProvider<Child0>(
              lazy: false,
              create: (_) => family.getChild<Child0>(),
            ),
            BlocProvider<Child1>(
              lazy: false,
              create: (_) => family.getChild<Child1>(),
            ),
            BlocProvider<Child2>(
              lazy: false,
              create: (_) => family.getChild<Child2>(),
            ),
            BlocProvider<Child3>(
              lazy: false,
              create: (_) => family.getChild<Child3>(),
            ),
            BlocProvider<Child4>(
              lazy: false,
              create: (_) => family.getChild<Child4>(),
            ),
            BlocProvider<Child5>(
              lazy: false,
              create: (_) => family.getChild<Child5>(),
            ),
            BlocProvider<Child6>(
              lazy: false,
              create: (_) => family.getChild<Child6>(),
            ),
            BlocProvider<Child7>(
              lazy: false,
              create: (_) => family.getChild<Child7>(),
            ),
            BlocProvider<Child8>(
              lazy: false,
              create: (_) => family.getChild<Child8>(),
            ),
            BlocProvider<Child9>(
              lazy: false,
              create: (_) => family.getChild<Child9>(),
            ),
            BlocProvider<Child10>(
              lazy: false,
              create: (_) => family.getChild<Child10>(),
            ),
            BlocProvider<Child11>(
              lazy: false,
              create: (_) => family.getChild<Child11>(),
            ),
            BlocProvider<Child12>(
              lazy: false,
              create: (_) => family.getChild<Child12>(),
            ),
            BlocProvider<Child13>(
              lazy: false,
              create: (_) => family.getChild<Child13>(),
            ),
            BlocProvider<Child14>(
              lazy: false,
              create: (_) => family.getChild<Child14>(),
            ),
            BlocProvider<Child15>(
              lazy: false,
              create: (_) => family.getChild<Child15>(),
            ),
            BlocProvider<Child16>(
              lazy: false,
              create: (_) => family.getChild<Child16>(),
            ),
            BlocProvider<Child17>(
              lazy: false,
              create: (_) => family.getChild<Child17>(),
            ),
            BlocProvider<Child18>(
              lazy: false,
              create: (_) => family.getChild<Child18>(),
            ),
            BlocProvider<Child19>(
              lazy: false,
              create: (_) => family.getChild<Child19>(),
            ),
          ],
        );
}
