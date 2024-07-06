class StateGame {
  state(List grid, List move, int symbol) {
    grid [move[0]][move[1]] = symbol;
    return grid;
  }
}


