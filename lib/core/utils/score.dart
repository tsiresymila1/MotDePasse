String getScoreByIndex(int index) {
  switch (index) {
    case 0:
      return "0";
    case 1:
      return "100";
    case 2:
      return "250";
    case 3:
      return "500";
    case 4:
      return "1000";
    default:
      return "2000";
  }
}