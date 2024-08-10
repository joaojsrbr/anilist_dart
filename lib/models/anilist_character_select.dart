import 'models.dart';

class AnilistCharacterSelect extends AnilistSelect {
  @override
  String get name => 'Characters';
  static const Map<String, dynamic> argumentName = {
    'first': null,
    'last': null,
    'full': null,
    'native': null,
    'alternative': null
  };

  static const Map<String, dynamic> argumentImage = {
    'large': null,
    'medium': null,
  };

  @override
  String get query {
    return '''
    query (\$id: Int) {
  Character (id: \$id) {
    $elements
      }
}
    ''';
  }

  String queryElements(Map<String, dynamic> arguments) {
    return arguments.keys.map((k) {
      if (arguments[k] != null) {
        return '$k {${queryElements(arguments[k])}}';
      } else {
        return k;
      }
    }).join(',');
  }

  void withName() => add('name', subArguments: argumentName);
  void withNameFirst() => addSub('name', 'first');
  void withoutNameFirst() => removeSub('name', 'first');
  void withNameLast() => addSub('name', 'last');
  void withoutNameLast() => removeSub('name', 'last');
  void withNameFull() => addSub('name', 'full');
  void withoutNameFull() => removeSub('name', 'full');
  void withNameNative() => addSub('name', 'native');
  void withoutNameNative() => removeSub('name', 'native');
  void withNameAlternative() => addSub('name', 'alternative');
  void withoutNameAlternative() => removeSub('name', 'alternative');
  void withoutName() => remove('name');

  void withImage() => add('image', subArguments: argumentImage);
  void withoutImage() => remove('image');

  void withDescription() => add('description');
  void withoutDescription() => remove('description');

  void withIsFavourite() => add('isFavourite');
  void withoutIsFavourite() => remove('isFavourite');

  void withSiteUrl() => add('siteUrl');
  void withoutSiteUrl() => remove('siteUrl');

  void withFavourites() => add('favourites');
  void withoutFavourites() => remove('favourites');
}
