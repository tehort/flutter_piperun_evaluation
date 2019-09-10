class ActivityStatus {
  int index;
  String description;

  ActivityStatus(this.index, this.description);

  // É utilizado uma lista e uma classe, pois dart nao possui suporte a enumracao com type
  static List<ActivityStatus> getList() {
    return [
      ActivityStatus(0, 'Planejada'),
      ActivityStatus(1, 'Aberta'),
      ActivityStatus(2, 'Concluída'),
      ActivityStatus(3, 'Cancelada'),
      ActivityStatus(4, 'No-Show'),
      ActivityStatus(5, 'Indiferente'),
    ];
  }
}
