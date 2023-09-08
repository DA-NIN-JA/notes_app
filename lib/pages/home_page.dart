import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/note.dart';
import './new_note.dart';
import '../providers/note_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes App"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: (notesProvider.isLoading == false)
          ? SafeArea(
              child: (notesProvider.notes.length > 0)
                  ? ListView(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.4),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(36)),
                          margin: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: TextField(
                            onChanged: (val) {
                              setState(() {
                                searchQuery = val;
                              });
                            },
                            onSubmitted: (value) {
                              
                            },
                            decoration: InputDecoration(
                              hintText: "Search",
                              hintStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w300),
                              icon: Icon(
                                Icons.search,
                                size: 32,
                              ),
                              border: InputBorder.none,
                            ),
                            onTapOutside: (event) => FocusScope.of(context).unfocus(),
                          ),
                        ),
                        (notesProvider.getFilteredNotes(searchQuery).length > 0)
                            ? Container(
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                child: GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                  itemCount: notesProvider
                                      .getFilteredNotes(searchQuery)
                                      .length,
                                  itemBuilder: (context, index) {
                                    Note currentNote = notesProvider
                                        .getFilteredNotes(searchQuery)[index];

                                    return GestureDetector(
                                      onTap: () {
                                        // Update
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  AddNewNotePage(
                                                    isUpdate: true,
                                                    note: currentNote,
                                                  )),
                                        );
                                      },
                                      onLongPress: () {
                                        // Delete
                                        notesProvider.deleteNote(currentNote);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(8),
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withOpacity(0.4),
                                              width: 2),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              currentNote.title!,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                            Text(
                                              currentNote.content!,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey[700]),
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  "No notes found!",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                      ],
                    )
                  : Center(
                      child: Text("No notes yet!!"),
                    ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 16, 16),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => const AddNewNotePage(
                        isUpdate: false,
                      )),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
