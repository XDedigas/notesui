import 'package:flutter/material.dart';
import '../models/noteModel.dart';
import 'package:intl/intl.dart';

class NotesUI extends StatefulWidget {
  const NotesUI({Key? key}) : super(key: key);

  @override
  State<NotesUI> createState() => _NotesUIState();
}

class _NotesUIState extends State<NotesUI> with SingleTickerProviderStateMixin {
  int _indexCategoriaSelecionada = 0;
  late TabController _tabController;
  final Color _cinzaEscuro = const Color.fromARGB(255, 184, 184, 184);
  final Color _cinzaClaro = const Color.fromARGB(179, 231, 231, 231);
  final Color _azul = Colors.blue;
  final Color _preto = Colors.black;
  final Color _branco = Colors.white;
  final Color _transparente = Colors.transparent;
  final DateFormat _dateFormat = DateFormat('dd MMM');
  final DateFormat _timeFormat = DateFormat.Hm();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  Widget _buildCategoryCard(int index, String title, int count) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _indexCategoriaSelecionada = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        height: 240.0,
        width: 175.0,
        decoration: BoxDecoration(
          color: _indexCategoriaSelecionada == index ? _azul : _cinzaClaro,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            _indexCategoriaSelecionada == index
                ? BoxShadow(
                    color: _preto,
                    offset: const Offset(0, 2),
                    blurRadius: 10.0,
                  )
                : BoxShadow(color: _transparente),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                title,
                style: TextStyle(
                  color: _indexCategoriaSelecionada == index
                      ? _branco
                      : _cinzaEscuro,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                count.toString(),
                style: TextStyle(
                  color: _indexCategoriaSelecionada == index ? _branco : _preto,
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 40.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/images/user.jpg'),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                const SizedBox(width: 20.0),
                const Text(
                  'Edgar Venturini',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40.0),
          SizedBox(
            height: 280.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return const SizedBox(width: 20.0);
                }
                return _buildCategoryCard(
                    index - 1,
                    categories.keys.toList()[index - 1],
                    categories.values.toList()[index - 1]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: TabBar(
              controller: _tabController,
              labelColor: _preto,
              unselectedLabelColor: _cinzaEscuro,
              indicatorColor: _azul,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 4.0,
              isScrollable: true,
              tabs: [
                criaTab('Notas'),
                criaTab('Importante'),
                criaTab('Concluído'),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          criaCardCompleto(0, true),
          const SizedBox(height: 20.0),
          criaCardCompleto(1, false),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget criaCardCompleto(int index, bool isViagem) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      padding: const EdgeInsets.all(30.0),
      decoration: BoxDecoration(
        color: _cinzaClaro,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Column(
        children: [
          criaCardPartePrincipal(index),
          const SizedBox(height: 15.0),
          addInfos(notes[index].content, _preto),
          if (isViagem) criaCardParteFinal(index),
        ],
      ),
    );
  }

  Widget criaCardParteFinal(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        addInfos(_dateFormat.format(notes[index].date), _cinzaEscuro),
        criaContainerDoCard(),
      ],
    );
  }

  Widget criaContainerDoCard() {
    return Container(
      height: 50.0,
      width: 50.0,
      decoration: BoxDecoration(
        color: _azul,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Icon(
        Icons.location_on,
        color: _branco,
      ),
    );
  }

  Widget criaCardPartePrincipal(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        addInfos(notes[index].title, _preto),
        addInfos(_timeFormat.format(notes[index].date), _cinzaEscuro),
      ],
    );
  }

  Widget addInfos(String info, Color cor) {
    return Text(
      info,
      style: TextStyle(
        color: cor,
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget criaTab(String nomeTab) {
    return Tab(
      child: Text(
        nomeTab,
        style: const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
