// ignore_for_file: public_member_api_docs

import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:eco_slide_puzzle/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../data/data_repository.dart';
import '../../models/ScoreBoard.dart';
import '../../models/player.dart';

part 'puzzle_event.dart';
part 'puzzle_state.dart';

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  var _uid = FirebaseAuth.instance.currentUser!.uid;
  PuzzleBloc(this._size, this.imgPath, {this.random, required  DataRepository repository})
      : repository = repository,
      super(const PuzzleState()) {
    on<PuzzleInitialized>(_onPuzzleInitialized);
    on<TileTapped>(_onTileTapped);
    on<PuzzleReset>(_onPuzzleReset);

  }

  final int _size;

  final Random? random;
  final DataRepository repository;
  String imgPath;

  ScoreBoard scoreBoard = ScoreBoard(score: 0, numberOfMoves: 0, timeTaken: 0, datePlayed: DateTime.now());


  void _onPuzzleInitialized (
    PuzzleInitialized event,
    Emitter<PuzzleState> emit,
  ) async {

      //final puzzle = await _generatePuzzle(_size, shuffle: event.shufflePuzzle);
      final puzzle = await _generatePuzzle(_size, shuffle: false);

      // setupPlayer();

      emit(
        PuzzleState(
          puzzle: puzzle.sort(),
          puzzleStatus: PuzzleStatus.incomplete,
          numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
        ),

      );

  }

  void dispose() {
    close();

  }
  void _onTileTapped(TileTapped event, Emitter<PuzzleState> emit) async{
    final tappedTile = event.tile;
    var uid = FirebaseAuth.instance.currentUser!.uid;
    if (state.puzzleStatus == PuzzleStatus.incomplete) {
      if (state.puzzle.isTileMovable(tappedTile)) {
        final mutablePuzzle = Puzzle(tiles: [...state.puzzle.tiles]);
        final puzzle = mutablePuzzle.moveTiles(tappedTile, []);
        if (puzzle.isComplete() && emit.isDone) {
          emit(
            state.copyWith(
              puzzle: puzzle.sort(),
              puzzleStatus: PuzzleStatus.complete,
              tileMovementStatus: TileMovementStatus.moved,
              numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
              numberOfMoves: state.numberOfMoves + 1,
              lastTappedTile: tappedTile,
            ),
          );
          // update the database
          //updatePlayer(state.numberOfMoves);
           await updateScoreBoard(1);
          await updateTiles(uid, state.puzzle.tiles);
        } else {
          emit(
            state.copyWith(
              puzzle: puzzle.sort(),
              tileMovementStatus: TileMovementStatus.moved,
              numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
              numberOfMoves: state.numberOfMoves + 1,
              lastTappedTile: tappedTile,
            ),
          );

          // update the database
          //updatePlayer(state.numberOfMoves);
          await updateScoreBoard(1);

          await updateTiles(uid, state.puzzle.tiles);
        }
      } else {
        emit(
          state.copyWith(tileMovementStatus: TileMovementStatus.cannotBeMoved),
        );
      }
    } else {
      emit(
        state.copyWith(tileMovementStatus: TileMovementStatus.cannotBeMoved),
      );
    }
  }

  void _onPuzzleReset(PuzzleReset event, Emitter<PuzzleState> emit) async {
    final puzzle = await  _generatePuzzle(_size);
    updatePlayer(0);
    resetScoreBoard();
    await (0);

    emit(
      PuzzleState(
        puzzle: puzzle.sort(),
        puzzleStatus: PuzzleStatus.incomplete,
        numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
      ),
    );
  }

  /// Build a randomized, solvable puzzle of the given size.
  Future<Puzzle> _generatePuzzle(int size, {bool shuffle = true}) async
  {
    List<Tile> tiles = [];
    final correctPositions = <Position>[];
    final currentPositions = <Position>[];
    final whitespacePosition = Position(x: size, y: size);

    await repository.getTiles(_uid, tiles);
    print( " TILES " + tiles.toString());
    tiles.forEach((element) { print(" OUTSIDE GET TILES " + element.toJson().toString()); });
    if (tiles.isNotEmpty && !shuffle){
      print ("=============== Saved tiles found");
      shuffle = false;
    }else {
      print ("++++++++++++ Nothing saved in Tiles ");

      shuffle= true;
      // Create all possible board positions.
      for (var y = 1; y <= size; y++) {
        for (var x = 1; x <= size; x++) {
          if (x == size && y == size) {
            correctPositions.add(whitespacePosition);
            currentPositions.add(whitespacePosition);
          } else {
            final position = Position(x: x, y: y);
            correctPositions.add(position);
            currentPositions.add(position);
          }
        }
      }

      if (shuffle) {
        // Randomize only the current tile posistions.
        currentPositions.shuffle(random);
      }

      tiles = _getTileListFromPositions(
        size,
        correctPositions,
        currentPositions,
      );
    }
    var puzzle = Puzzle(tiles: tiles);

    if (shuffle) {
      // Assign the tiles new current positions until the puzzle is solvable and
      // zero tiles are in their correct position.
      while (!puzzle.isSolvable() || puzzle.getNumberOfCorrectTiles() != 0) {
        currentPositions.shuffle(random);
        tiles = _getTileListFromPositions(
          size,
          correctPositions,
          currentPositions,
        );
        puzzle = Puzzle(tiles: tiles);
      }

    }
    var uid = FirebaseAuth.instance.currentUser!.uid;

    //await updateTiles(uid, tiles);
    await setupPlayer();
    await repository.getStartupScoreBoard(uid, scoreBoard);
    print (" after startup score board is " + scoreBoard.toJson().toString());
    //await updateScoreBoard(0);
    return puzzle;
  }

  /// Build a list of tiles - giving each tile their correct position and a
  /// current position.
  List<Tile> _getTileListFromPositions(
    int size,
    List<Position> correctPositions,
    List<Position> currentPositions,
  ) {
    final whitespacePosition = Position(x: size, y: size);
    return [
      for (int i = 1; i <= size * size; i++)
        if (i == size * size)
          Tile(
            imagePath: imgPath,
            value: i,
            correctPosition: whitespacePosition,
            currentPosition: currentPositions[i - 1],
            isWhitespace: true,
          )
        else
          Tile(
            imagePath: imgPath,
            value: i,
            correctPosition: correctPositions[i - 1],
            currentPosition: currentPositions[i - 1],
          )
    ];
  }

  // List<Image> splitImage(String originalImagePath, int size) {
  //   // extract the Image from the path
  //   img_lib.Image? image =
  //       img_lib.decodeNamedImage(File(imgPath).readAsBytesSync(), 'puffin.jpg');

  //   int x = 0, y = 0;
  //   int width = ((image?.width)! / size).round();
  //   int height = ((image?.height)! / size).round();

  //   // split image to parts
  //   List<img_lib.Image> parts = [];
  //   for (int i = 0; i < size; i++) {
  //     for (int j = 0; j < size; j++) {
  //       parts.add(img_lib.copyCrop(image!, x, y, width, height));
  //       x += width;
  //     }
  //     x = 0;
  //     y += height;
  //   }

  //   // convert image from image package to Image Widget to display
  //   List<Image> output = [];
  //   for (var img in parts) {
  //     output.add(Image.memory(Uint8List.fromList(img_lib.encodeJpg(img))));
  //   }

  //   return output;
  // }

  setupPlayer() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var email = FirebaseAuth.instance.currentUser!.email;
    print ("uid " + uid);
    print ("email " + email!);

    try {
     var _gamePlayer =
      await repository.getPlayer(uid);

      if (_gamePlayer == null) {
        print (" player is null");

        if (uid != null && email != null) {
          _gamePlayer = new Player(
              email: email,
              //uid: uid,
              dateCreated: DateTime.now()

              );


          await repository.addPlayer(uid,_gamePlayer);
          return;
        }
      } else {
        print('Found it');
        print(_gamePlayer.email);
      }
    }catch (error){
      print("Exception is caught ........");
      print(error.toString());
    }
  }

  updatePlayer(int numMoves) async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var email = FirebaseAuth.instance.currentUser!.email;
    print ("uid " + uid);
    print ("email " + email!);
    print ("Number of Moves " + numMoves.toString());

    try {
      Player? _gamePlayer;
      _gamePlayer =
      await repository.getPlayer(uid);
   //   _gamePlayer?.scoreBoard.numberOfMoves += numMoves;
      print(" FOund PLayer before update " + _gamePlayer!.toJson().toString());
      await repository.updatePlayer(uid,_gamePlayer);
      print ("Updating player " + _gamePlayer.toString());
      return ;


    }catch (error){
      print("Exception is caught ........");
      print(error.toString());
    }
  }
  updateTiles(String uid, List<Tile> tiles) async{
    print(" Updating tiles");
      await repository.updateTiles(uid, tiles);
  }

  updateScoreBoard(int moves) async {
    try {
      var uid = FirebaseAuth.instance.currentUser!.uid;
      /*
      bool hasVal = false;
      if (moves == 0) {
        hasVal = await  repository.getScoreBoard(uid, scoreBoard);
        print (" Got from DB " + hasVal.toString());
        if (!hasVal) {
         scoreBoard = ScoreBoard(score: 0, numberOfMoves: 0,
             timeTaken: 0, datePlayed: DateTime.now());
          }
        }
*/
      print(" Score Board " + scoreBoard.toJson().toString());

        ScoreBoard toUpdate;
        if (moves > 0) {
          scoreBoard.numberOfMoves = scoreBoard.numberOfMoves + moves;
          toUpdate = scoreBoard;

          await repository.updateScoreBoard(uid, toUpdate);
        }

    } catch (error) {
      print(" Error " + error.toString());
    }
  }
    resetScoreBoard() async {
      try {
        var uid = FirebaseAuth.instance.currentUser!.uid;


        scoreBoard.numberOfMoves = 0;

        await repository.updateScoreBoard(uid, scoreBoard);

      }catch(error){
        print (" Error " + error.toString());
      }
    }

}
