// import 'dart:io';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:video_player/video_player.dart';
//
// class VideoListPage extends StatelessWidget {
//
//   bool _isLoading = true;
//   Future<void> _pickAndUploadVideo() async {
//
//     _isLoading = true;
//
//
//     final result = await FilePicker.platform.pickFiles(type: FileType.video);
//     if (result != null) {
//       final file = result.files.first;
//       final filePath = file.path;
//
//       if (filePath != null) {
//         final fileName = file.name;
//         final fileRef =
//             FirebaseStorage.instance.ref().child('videos/$fileName');
//         final uploadTask = fileRef.putFile(File(filePath));
//
//         final snapshot = await uploadTask.whenComplete(() => {});
//         final downloadUrl = await snapshot.ref.getDownloadURL();
//
//         await FirebaseFirestore.instance.collection('videos').add({
//           'url': downloadUrl,
//           'name': fileName,
//           'uploaded_at': Timestamp.now(),
//
//         });
//
//         _isLoading = false;
//         print("done");
//         //
//         // ScaffoldMessenger.of(context).showSnackBar(
//         //     SnackBar(content: Text('Video uploaded successfully!')));
//       }
//     } else {
//       _isLoading = false;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.upload),
//         onPressed: () {
//           _pickAndUploadVideo();
//         },
//       ),
//       appBar: AppBar(
//         title: Text('Video List'),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('videos').snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           final videos = snapshot.data?.docs ?? [];
//
//           return ListView.builder(
//             itemCount: videos.length,
//             itemBuilder: (context, index) {
//               final video = videos[index];
//               final url = video['url'];
//
//               return ListTile(
//                 title: Text(video['name']),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => VideoPlayerPage(url: url),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
// class VideoPlayerPage extends StatefulWidget {
//   final String url;
//
//   VideoPlayerPage({required this.url});
//
//   @override
//   _VideoPlayerPageState createState() => _VideoPlayerPageState();
// }
//
// class _VideoPlayerPageState extends State<VideoPlayerPage> {
//   late VideoPlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.url)
//       ..initialize().then((_) {
//         setState(() {});
//       });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video Player'),
//       ),
//       body: Center(
//         child: _controller.value.isInitialized
//             ? AspectRatio(
//                 aspectRatio: _controller.value.aspectRatio,
//                 child: VideoPlayer(_controller),
//               )
//             : CircularProgressIndicator(),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             _controller.value.isPlaying
//                 ? _controller.pause()
//                 : _controller.play();
//           });
//         },
//         child: Icon(
//           _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade100,
        child: Icon(Icons.upload),
        onPressed: _pickAndUploadVideo,
      ),
      appBar: AppBar(
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
                        color: Colors.blue.shade100,
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
                            Icon(Icons.play_circle),
                            SizedBox(
                              width: 20,
                            ),
                            Text(video['name']),
                            IconButton(onPressed: (){ setState(() {
                              FirebaseFirestore.instance.collection("videos").doc(videos[index].id).delete();
                            });}, icon: Icon(CupertinoIcons.delete,),color: Colors.black,)
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
