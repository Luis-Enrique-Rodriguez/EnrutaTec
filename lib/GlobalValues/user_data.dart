class Usr_Data {
  String UsuarioAct = "", FotoPerfil = "", EmailAct = "";

  void EmailUsr(String email) {
    EmailAct = email;
  }

  void FotoUsr(String fotoP) {
    FotoPerfil = fotoP;
  }

  void ActUsr(String actusr) {
    UsuarioAct = actusr;
  }

  void limpiar() {
    UsuarioAct = "";
    FotoPerfil = "";
    EmailAct = "";
  }
}
