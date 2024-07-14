
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class VideoListPage extends StatefulWidget {
  @override
  _VideoListPageState createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {
  var Stid;
  var ID;
  // String dateselect = '';
  // final date = new DateTime.now();
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      Stid = spref.getString("Studentid");
      ID = spref.getString("id");


    });
    print("sharedPreference Data get");
  }

  bool _isLoading = false;
  String dateselect = '';
  final date = new DateTime.now();

  Future<void> _pickAndUploadVideo() async {

    setState(() {
      _isLoading = true;
    });

    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null) {
      final file = result.files.first;
      final filePath = file.path;

      if (filePath != null) {
        final fileName = file.name;
        final fileRef =
            FirebaseStorage.instance.ref().child('videos/$fileName');
        final uploadTask = fileRef.putFile(File(filePath));

        final snapshot = await uploadTask.whenComplete(() => {});
        final downloadUrl = await snapshot.ref.getDownloadURL();

        await FirebaseFirestore.instance.collection('videos').add({
          'url': downloadUrl,
          'name': fileName,
          'uploaded_at': Timestamp.now(),
          "StudentId": Stid,
          "Teacherid": ID,
          'date': DateFormat('dd/MM/yyyy').format(date),
          // 'date': DateFormat('dd/MM/yyyy').format(date),
        });

        setState(() {
          _isLoading = false;
        });
        print("done");
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }
  void showDeleteDialog(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete this  video?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("OK"),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection("videos")
                    .doc(docId)
                    .delete();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green
            .shade100,
        child: Icon(Icons.upload),
        onPressed: _pickAndUploadVideo,
      ),
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.green.shade200,elevation: 4,shadowColor: Colors.grey,
        title: Text('Video List'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('videos')
            .where("StudentId", isEqualTo: Stid)
            .where("Teacherid", isEqualTo: ID)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final videos = snapshot.data?.docs ?? [];

          return ListView.builder(
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];
              final url = video['url'];

              return ListTile(
                title: Container(
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(10)),

                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(video['date'],style: TextStyle(fontSize: 12),),
                            ),
                            SizedBox(width: 10,),
                          ],),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(Icons.play_circle_fill, size: 40, color: Colors.green.shade400),
                            SizedBox(
                              width: 20,
                            ),
                            Text(video['name'], style: TextStyle( fontWeight: FontWeight.w500)),
                            IconButton(onPressed: (){ showDeleteDialog(context, video.id);}, icon: Icon(CupertinoIcons.delete,),color: Colors.black,)
                          ],
                        ),

                      ],
                    )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoPlayerPage(url: url),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class VideoPlayerPage extends StatefulWidget {
  final String url;

  VideoPlayerPage({required this.url});

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
