class EndPoint {
  static const baseUrl =
      // "http://192.168.100.72:5000/";
      "https://ibm-backend-final-project-production.up.railway.app/";
  static const adminWorkSpaces = "admin/workspaces";
  static const adminBooks = "admin/books";

  static const login = "login";
  static const workSpaceRooms = "workspace/rooms";

  static const addRoom = "room";
  static const updateBook = "book";
  static const updateBookStatus = "book/status";
  static const deleteRoom = "room";

  static const register = "register";
  static const editProfile = "user"; // with put request
  static const refresh = "refresh"; // with put request
  static const addWorkSpace = "workspace"; // with post request
}
