// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on _HomeControllerBase, Store {
  late final _$indexHomeAtom =
      Atom(name: '_HomeControllerBase.indexHome', context: context);

  @override
  int get indexHome {
    _$indexHomeAtom.reportRead();
    return super.indexHome;
  }

  @override
  set indexHome(int value) {
    _$indexHomeAtom.reportWrite(value, super.indexHome, () {
      super.indexHome = value;
    });
  }

  late final _$ingredientMapAtom =
      Atom(name: '_HomeControllerBase.ingredientMap', context: context);

  @override
  ObservableMap<dynamic, dynamic> get ingredientMap {
    _$ingredientMapAtom.reportRead();
    return super.ingredientMap;
  }

  @override
  set ingredientMap(ObservableMap<dynamic, dynamic> value) {
    _$ingredientMapAtom.reportWrite(value, super.ingredientMap, () {
      super.ingredientMap = value;
    });
  }

  late final _$receitasAtom =
      Atom(name: '_HomeControllerBase.receitas', context: context);

  @override
  ObservableList<Receita> get receitas {
    _$receitasAtom.reportRead();
    return super.receitas;
  }

  @override
  set receitas(ObservableList<Receita> value) {
    _$receitasAtom.reportWrite(value, super.receitas, () {
      super.receitas = value;
    });
  }

  late final _$listSelectedIngredientsAtom = Atom(
      name: '_HomeControllerBase.listSelectedIngredients', context: context);

  @override
  ObservableList<String> get listSelectedIngredients {
    _$listSelectedIngredientsAtom.reportRead();
    return super.listSelectedIngredients;
  }

  @override
  set listSelectedIngredients(ObservableList<String> value) {
    _$listSelectedIngredientsAtom
        .reportWrite(value, super.listSelectedIngredients, () {
      super.listSelectedIngredients = value;
    });
  }

  late final _$imagePathAtom =
      Atom(name: '_HomeControllerBase.imagePath', context: context);

  @override
  String? get imagePath {
    _$imagePathAtom.reportRead();
    return super.imagePath;
  }

  @override
  set imagePath(String? value) {
    _$imagePathAtom.reportWrite(value, super.imagePath, () {
      super.imagePath = value;
    });
  }

  late final _$imageAtom =
      Atom(name: '_HomeControllerBase.image', context: context);

  @override
  File? get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(File? value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  late final _$isStrictModeAtom =
      Atom(name: '_HomeControllerBase.isStrictMode', context: context);

  @override
  bool get isStrictMode {
    _$isStrictModeAtom.reportRead();
    return super.isStrictMode;
  }

  @override
  set isStrictMode(bool value) {
    _$isStrictModeAtom.reportWrite(value, super.isStrictMode, () {
      super.isStrictMode = value;
    });
  }

  late final _$getImageFromGalleryAsyncAction =
      AsyncAction('_HomeControllerBase.getImageFromGallery', context: context);

  @override
  Future<dynamic> getImageFromGallery() {
    return _$getImageFromGalleryAsyncAction
        .run(() => super.getImageFromGallery());
  }

  late final _$getImageFromCameraAsyncAction =
      AsyncAction('_HomeControllerBase.getImageFromCamera', context: context);

  @override
  Future<dynamic> getImageFromCamera() {
    return _$getImageFromCameraAsyncAction
        .run(() => super.getImageFromCamera());
  }

  late final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase', context: context);

  @override
  void selectIndex(dynamic value) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.selectIndex');
    try {
      return super.selectIndex(value);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addRecipe(Receita receita) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.addRecipe');
    try {
      return super.addRecipe(receita);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addIngredientsToList(String ingredients) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.addIngredientsToList');
    try {
      return super.addIngredientsToList(ingredients);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addIngredientMap(
      {required String medida,
      required String ingrediente,
      required String quantidade}) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.addIngredientMap');
    try {
      return super.addIngredientMap(
          medida: medida, ingrediente: ingrediente, quantidade: quantidade);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStrictMode() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.setStrictMode');
    try {
      return super.setStrictMode();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFlexibleMode() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.setFlexibleMode');
    try {
      return super.setFlexibleMode();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
indexHome: ${indexHome},
ingredientMap: ${ingredientMap},
receitas: ${receitas},
listSelectedIngredients: ${listSelectedIngredients},
imagePath: ${imagePath},
image: ${image},
isStrictMode: ${isStrictMode}
    ''';
  }
}
