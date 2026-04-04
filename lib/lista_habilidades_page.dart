import 'package:flutter/material.dart';
import 'package:reino_mobile_app/lib/habilidade.dart';

final List<Habilidade> habilidades = [
  Habilidade(nome: 'Flutter', descricao: 'Desenvolvimento mobile multiplataforma', nivel: 'Iniciante', favorita: true),
  Habilidade(nome: 'Python', descricao: 'Linguagem principal para análise de dados', nivel: 'Intermediário', favorita: true),
  Habilidade(nome: 'Data Science', descricao: 'Ciência de dados e modelagem estatística', nivel: 'Iniciante', favorita: true),
  Habilidade(nome: 'Data Analysis', descricao: 'Análise e visualização de dados', nivel: 'Intermediário', favorita: true),
];

class ListaHabilidadesPage extends StatefulWidget {
  const ListaHabilidadesPage({super.key});

  @override
  State<ListaHabilidadesPage> createState() => _ListaHabilidadesPageState();
}

class _ListaHabilidadesPageState extends State<ListaHabilidadesPage> {

  bool _ordenarPorNivel = true;

  bool _apenasFinalize = false;

  List<Habilidade> get _listaFiltrada {
    List<Habilidade> lista = _apenasFinalize
        ? habilidades.where((h) => h.favorita).toList()
        : List.from(habilidades);

    if (_ordenarPorNivel) {
      const ordem = ['Avançado', 'Intermediário', 'Iniciante'];
      lista.sort((a, b) => ordem.indexOf(a.nivel).compareTo(ordem.indexOf(b.nivel)));
    }

    return lista;
  }

  IconData _icone(String nivel) {
    switch (nivel) {
      case 'Avançado': return Icons.star;
      case 'Intermediário': return Icons.trending_up;
      default: return Icons.school;
    }
  }

  Color _corIcone(String nivel) {
    switch (nivel) {
      case 'Avançado': return Colors.green;
      case 'Intermediário': return Colors.orange;
      default: return Colors.blue;
    }
  }

  Color _corCard(String nivel) {
    switch (nivel) {
      case 'Avançado': return Colors.green.shade50;
      case 'Intermediário': return Colors.orange.shade50;
      default: return Colors.blue.shade50;
    }
  }

  @override
  Widget build(BuildContext context) {
    final lista = _listaFiltrada;

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF006994),
        foregroundColor: Colors.white,
        title: const Text('Minhas Habilidades'),
        actions: [
          IconButton(
            icon: Icon(_apenasFinalize ? Icons.star : Icons.star_border),
            tooltip: 'Favoritas',
            onPressed: () => setState(() => _apenasFinalize = !_apenasFinalize),
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            tooltip: 'Ordenar por nível',
            onPressed: () => setState(() => _ordenarPorNivel = !_ordenarPorNivel),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: lista.length,
        itemBuilder: (context, index) {
          final h = lista[index];
          return Card(
            color: _corCard(h.nivel),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: Icon(_icone(h.nivel), color: _corIcone(h.nivel), size: 32),
              title: Text(
                h.nome,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(h.descricao),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    h.favorita ? Icons.star : Icons.star_border,
                    color: h.favorita ? Colors.amber : Colors.grey,
                    size: 18,
                  ),
                  const SizedBox(height: 2),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: _corIcone(h.nivel),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      h.nivel,
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ],
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${h.nome} — ${h.nivel}'),
                    duration: const Duration(seconds: 2),
                  ),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => _DetalheHabilidadePage(habilidade: h),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _DetalheHabilidadePage extends StatelessWidget {
  final Habilidade habilidade;

  const _DetalheHabilidadePage({required this.habilidade});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF006994),
        foregroundColor: Colors.white,
        title: Text(habilidade.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  habilidade.nome,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(habilidade.descricao, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 16),
                Text('Nível: ${habilidade.nivel}', style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 4),
                Text(
                  'Favorita: ${habilidade.favorita ? "⭐ Sim" : "Não"}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}