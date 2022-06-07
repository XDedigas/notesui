class NoteModel {
  String title;
  String content;
  DateTime date;

  NoteModel({required this.title, required this.content, required this.date});
}

final Map<String, int> categories = {
  'Notas': 112,
  'Trabalho': 58,
  'Casa': 23,
  'Concluído': 31,
};

final List<NoteModel> notes = [
  NoteModel(
    title: 'Comprar passagem',
    content: 'Comprar passagem aérea da GOL por R\$318.38',
    date: DateTime(2022, 06, 07, 20, 30),
  ),
  NoteModel(
    title: 'Caminhar com o cachorro',
    content: 'Caminhar com o cachorro no seu parque favorito.',
    date: DateTime(2022, 06, 07, 18, 30),
  ),
];
