import 'dart:collection';

/// Defines the mapping between the prefecture ids and the icons needed
/// to be displayed for each prefecture.
class IconPrefectureMap{
  static const Map<String, String> iconMap = {
    '10' : 'assets/acropolis.png', // Attica
    '15' : 'assets/poseidon.png', // Dodecanese
    '23' : 'assets/white-tower.png', // Thessaloniki
    '34' : 'assets/spartan-helmet.png', // Lakonia
    '39' : 'assets/centaur.png' // Magnhsia
  };
}