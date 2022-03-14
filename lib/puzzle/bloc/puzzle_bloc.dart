// ignore_for_file: public_member_api_docs


import 'dart:math';

import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:eco_slide_puzzle/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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

  ScoreBoard scoreBoard = ScoreBoard(score: 0, numberOfMoves: 0, timeTaken: 0,
      datePlayed: DateTime.now(), size: 0);


  void _onPuzzleInitialized (
    PuzzleInitialized event,
    Emitter<PuzzleState> emit,
  ) async {
      scoreBoard.size = _size;
      //final puzzle = await _generatePuzzle(_size, shuffle: event.shufflePuzzle);
      final puzzle = await _generatePuzzle(_size, shuffle: false);

      emit(
        PuzzleState(
          puzzle: puzzle.sort(),
          puzzleStatus: PuzzleStatus.incomplete,
          numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
          numberOfMovesTotal: scoreBoard.numberOfMoves,
          score : scoreBoard.score,
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
        if (puzzle.isComplete() ) {

          scoreBoard.score = scoreBoard.score + 1;
          await updateScoreBoard(1);
          emit(
            state.copyWith(
              puzzle: puzzle.sort(),
              puzzleStatus: PuzzleStatus.complete,
              tileMovementStatus: TileMovementStatus.moved,
              numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
              numberOfMoves: state.numberOfMoves + 1,
              numberOfMovesTotal: scoreBoard.numberOfMoves,
              score : scoreBoard.score,
              lastTappedTile: tappedTile,
            ),
          );


          await updateTiles(uid, state.puzzle.tiles);
        } else {
          await updateScoreBoard(1);
          emit(

            state.copyWith(
              puzzle: puzzle.sort(),
              tileMovementStatus: TileMovementStatus.moved,
              numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
              numberOfMoves: state.numberOfMoves + 1,
              numberOfMovesTotal: scoreBoard.numberOfMoves,
              score : scoreBoard.score,
              lastTappedTile: tappedTile,
            ),
          );


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

    emit(
      PuzzleState(
        puzzle: puzzle.sort(),
        puzzleStatus: PuzzleStatus.incomplete,
        numberOfMovesTotal: scoreBoard.numberOfMoves,
        numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
        score : scoreBoard.score,
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

    await repository.getTiles(_uid, _size, tiles);
   // print( " TILES " + tiles.toString());
    /*
    tiles.forEach((element) {
      print(" OUTSIDE GET TILES " + element.toJson().toString()); });

     */
    if (tiles.isNotEmpty && !shuffle){
      if (kDebugMode) {
        print ("=============== Saved tiles found");
      }
      shuffle = false;
    }else {
      if (kDebugMode) {
        print ("++++++++++++ Nothing saved in Tiles ");
      }

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
    if (kDebugMode) {
      print (" after startup score board is " + scoreBoard.toJson().toString());
    }
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


  setupPlayer() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var email = FirebaseAuth.instance.currentUser!.email;
    String? displayName= FirebaseAuth.instance.currentUser?.displayName;

    if (kDebugMode) {
      print ("uid " + uid);
      print ("email " + email!);
      print ("displayName" + displayName!);
    }


    try {
     var _gamePlayer =
      await repository.getPlayer(uid);

      if (_gamePlayer == null) {
        print (" player is null");

        if (null != uid && email != null) {
          _gamePlayer = new Player(
              email: email,
             displayName: displayName,
              dateCreated: DateTime.now()

              );


          await repository.addPlayer(uid,_gamePlayer);
          return;
        }
      } else {
        await updateName(_gamePlayer);
        if (kDebugMode) {
          print('Found it');
          print(_gamePlayer.email);
        }

      }
    }catch (error){
      if (kDebugMode) {
        print("Exception is caught ........");
        print(error.toString());
      }


    }
  }
  updateName(Player gamePlayer) async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var email = FirebaseAuth.instance.currentUser!.email;
    String? displayName= FirebaseAuth.instance.currentUser?.displayName;

    if (kDebugMode) {
      print ("uid " + uid);
      print ("email " + email!);
      print ("displayName" + displayName!);
    }


    try {

      if (gamePlayer != null) {
        {
          if (kDebugMode) {
            print('Found it');
            print(gamePlayer.email);
          }

          if (gamePlayer.displayName == null && displayName != null) {
            Player updatePlayer = Player(email: gamePlayer.email,
                displayName: displayName,
                dateCreated: gamePlayer.dateCreated);
            repository.updatePlayer(uid, updatePlayer);
          }
        }
      }
    }catch (error){
      if (kDebugMode) {
        print("Exception is caught ........");
        print(error.toString());
      }


    }
  }

  updatePlayer(int numMoves) async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var email = FirebaseAuth.instance.currentUser!.email;

    if (kDebugMode) {
      print ("uid " + uid);
      print ("email " + email!);
      print ("Number of Moves " + numMoves.toString());
    }


    try {
      Player? _gamePlayer;
      _gamePlayer =
      await repository.getPlayer(uid);
   //   _gamePlayer?.scoreBoard.numberOfMoves += numMoves;
      if (kDebugMode) {
        print(" FOund PLayer before update " + _gamePlayer!.toJson().toString());
      }
      await repository.updatePlayer(uid,_gamePlayer!);
      if (kDebugMode) {
        print ("Updating player " + _gamePlayer.toString());
      }
      return ;


    }catch (error){

      if (kDebugMode) {
        print("Exception is caught ........");
        print(error.toString());
      }
    }
  }
  updateTiles(String uid, List<Tile> tiles) async{
   // print(" Updating tiles");
      await repository.updateTiles(uid,_size, tiles);
  }

  updateScoreBoard(int moves) async {
    try {
      var uid = FirebaseAuth.instance.currentUser!.uid;

    if (kDebugMode) {
      print(" Score Board " + scoreBoard.toJson().toString());
    }

       // ScoreBoard toUpdate;
        if (moves > 0) {
          scoreBoard.numberOfMoves = scoreBoard.numberOfMoves + moves;
         // toUpdate = scoreBoard;

          await repository.updateScoreBoard(uid, scoreBoard);
        }

    } catch (error) {
      if (kDebugMode) {
        print(" Error " + error.toString());
      }
    }
  }
    resetScoreBoard() async {
      try {
        var uid = FirebaseAuth.instance.currentUser!.uid;


        scoreBoard.numberOfMoves = 0;

        await repository.updateScoreBoard(uid, scoreBoard);

      }catch(error){
        if (kDebugMode) {
          print (" Error " + error.toString());
        }
      }
    }



}
