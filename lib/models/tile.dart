import 'package:equatable/equatable.dart';
import 'package:eco_slide_puzzle/models/models.dart';

/// {@template tile}
/// Model for a puzzle tile.
/// {@endtemplate}
class Tile extends Equatable {
  /// {@macro tile}
  const Tile({
    required this.imagePath,
    required this.value,
    required this.correctPosition,
    required this.currentPosition,
    this.isWhitespace = false,
  });

  /// Value representing the correct position of [Tile] in a list.
  final int value;

  // Image that is displayed on the tile;
  final String imagePath;

  /// The correct 2D [Position] of the [Tile]. All tiles must be in their
  /// correct position to complete the puzzle.
  final Position correctPosition;

  /// The current 2D [Position] of the [Tile].
  final Position currentPosition;

  /// Denotes if the [Tile] is the whitespace tile or not.
  final bool isWhitespace;

  /// Create a copy of this [Tile] with updated current position.
  Tile copyWith({required Position currentPosition}) {
    return Tile(
      imagePath: imagePath,
      value: value,
      correctPosition: correctPosition,
      currentPosition: currentPosition,
      isWhitespace: isWhitespace,
    );
  }

  @override
  List<Object> get props => [
        value,
        correctPosition,
        currentPosition,
        isWhitespace,
      ];



  Map<String, dynamic> toJson() => _TileToJson(this);
  factory Tile.fromJson(Map<dynamic, dynamic> json) => _TileFromJson(json);
}
Tile _TileFromJson(Map<dynamic, dynamic> json) {
  return Tile(
      imagePath: json['imagePath'],
      value: json['value'],
      correctPosition: Position.fromJson(json['correctPosition']),
      currentPosition: Position.fromJson(json['currentPosition']),
      isWhitespace: json['isWhitespace']
  );
}

//2
Map<String, dynamic> _TileToJson(Tile instance) => <String, dynamic>{
  'imagePath': instance.imagePath,
  'value': instance.value,
  'correctPosition': instance.correctPosition.toJson(),
  'currentPosition': instance.currentPosition.toJson(),
  'isWhitespace': instance.isWhitespace
};