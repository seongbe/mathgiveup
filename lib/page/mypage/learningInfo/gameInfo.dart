// API로 바꾸기
Map<int, String> gameInfo = {
  0: '월요일 게임: 스테이지 게임 2판',
  1: '화요일 게임: 1:1 게임 3판',
  2: '수요일 게임: 1:1 게임 6판',
  3: '목요일 게임: 스테이지 게임 4판',
  4: '금요일 게임: 스테이지 게임 1판',
  5: '토요일 게임: 1:1 게임 1판, 퀴즈 게임 2판',
  6: '일요일 게임: 퀴즈 게임 3판',
};

String getGameInfo(int dayIndex) {
  return gameInfo[dayIndex] ?? '정보 없음';
}
