import 'dart:io';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:ecommerce/utils/styles.dart';
import 'package:ecommerce/widgets/ecobutton.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class Add_Product_Screen extends StatefulWidget {
  const Add_Product_Screen({super.key});
  static const String id = 'Add_Product_Screen';

  @override
  State<Add_Product_Screen> createState() => _Add_Product_ScreenState();
}

class _Add_Product_ScreenState extends State<Add_Product_Screen> {
  String? selectedvalue;
  final imagepicker = ImagePicker();
  List<File> images = [];
  List<String> imageurls = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
            child: Column(
              children: [
                const Text(
                  "Add_Product_Screen",
                  style: EcoStyle.boldstyle,
                ),
                DropdownButtonFormField(
                  validator: (value) {
                    if (value == null) {
                      return 'Category must be selected';
                    }
                    return null;
                  },
                  value: selectedvalue,
                  items: categories
                      .map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedvalue = value.toString();
                    });
                  },
                ),
                EcoButton(
                  buttonName: 'PICK IMAGE',
                  onTap: pickImage,
                  isLogInButton: true,
                ),
                EcoButton(
                  buttonName: 'UPLOAD IMAGE',
                  onTap: () {
                    uploadImages();
                  },
                  isLogInButton: false,
                ),
                Container(
                    height: 35.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.20),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        // Display selected images
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                                child: Image.network(
                                  File(images[index].path).path,
                                  height: 300,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      images.removeAt(index);
                                    });
                                  },
                                  icon: const Icon(Icons.cancel_outlined))
                            ],
                          ),
                        );
                      },
                      itemCount: images.length,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  pickImage() async {
    List<XFile>? pickedImages = await imagepicker.pickMultiImage();
    if (pickedImages != null) {
      setState(() {
        images.addAll(pickedImages.map((xFile) => File(xFile.path)));
        print('Added ${pickedImages.length} images.');
      });
    } else {
      print('No images selected.');
    }
  }

  Future<String?> postImages(File imageFile) async {
    try {
      Reference ref = FirebaseStorage.instance.ref().child('images');

      await ref.putFile(imageFile);
      String downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  uploadImages() async {
    final uploadFutures = images.map((image) => postImages(image)).toList();
    final results = await Future.wait(uploadFutures);

    for (var downloadUrl in results) {
      if (downloadUrl != null) {
        imageurls.add(downloadUrl);
      }
    }

    print('Uploaded ${imageurls.length} images.');
  }
}
// // import 'dart:io';
// // import 'dart:html' as html; // Import dart:html for web support
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:ecommerce/screens/home_screen.dart';
// // import 'package:ecommerce/utils/styles.dart';
// // import 'package:ecommerce/widgets/ecobutton.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:sizer/sizer.dart';

// // class Add_Product_Screen extends StatefulWidget {
// //   const Add_Product_Screen({super.key});
// //   static const String id = 'Add_Product_Screen';

// //   @override
// //   State<Add_Product_Screen> createState() => _Add_Product_ScreenState();
// // }

// // class _Add_Product_ScreenState extends State<Add_Product_Screen> {
// //   String? selectedvalue;
// //   final imagepicker = ImagePicker();
// //   List<File> images = [];
// //   List<String> imageurls = [];

// //   @override
// //   Widget build(BuildContext context) {
// //     return SingleChildScrollView(
// //       child: Container(
// //         child: Center(
// //           child: Padding(
// //             padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
// //             child: Column(
// //               children: [
// //                 const Text(
// //                   "Add_Product_Screen",
// //                   style: EcoStyle.boldstyle,
// //                 ),
// //                 DropdownButtonFormField(
// //                   validator: (value) {
// //                     if (value == null) {
// //                       return 'Category must be selected';
// //                     }
// //                     return null;
// //                   },
// //                   value: selectedvalue,
// //                   items: categories
// //                       .map((e) => DropdownMenuItem<String>(
// //                             value: e,
// //                             child: Text(e),
// //                           ))
// //                       .toList(),
// //                   onChanged: (value) {
// //                     setState(() {
// //                       selectedvalue = value.toString();
// //                     });
// //                   },
// //                 ),
// //                 EcoButton(
// //                   buttonName: 'PICK IMAGE',
// //                   onTap: pickImage,
// //                   isLogInButton: true,
// //                 ),
// //                 EcoButton(
// //                   buttonName: 'UPLOAD IMAGE',
// //                   onTap: () {
// //                     uploadImages();
// //                   },
// //                   isLogInButton: false,
// //                 ),
// //                 Container(
// //                   height: 35.h,
// //                   decoration: BoxDecoration(
// //                     color: Colors.grey.withOpacity(0.20),
// //                     borderRadius: BorderRadius.circular(25),
// //                   ),
// //                   child: GridView.builder(
// //                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //                       crossAxisCount: 5,
// //                     ),
// //                     itemBuilder: (BuildContext context, int index) {
// //                       // Display selected images
// //                       return Padding(
// //                         padding: const EdgeInsets.all(8.0),
// //                         child: Stack(
// //                           children: [
// //                             Container(
// //                               decoration: BoxDecoration(
// //                                 border: Border.all(color: Colors.black),
// //                               ),
// //                               child: kIsWeb
// //                                   ? Image.network(images[index].path)
// //                                   : Image.file(images[index]),
// //                               height: 300,
// //                             ),
// //                             IconButton(
// //                               onPressed: () {
// //                                 setState(() {
// //                                   images.removeAt(index);
// //                                 });
// //                               },
// //                               icon: Icon(Icons.cancel_outlined),
// //                             )
// //                           ],
// //                         ),
// //                       );
// //                     },
// //                     itemCount: images.length,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   pickImage() async {
// //     List<XFile>? pickedImages = await imagepicker.pickMultiImage();
// //     if (pickedImages != null) {
// //       setState(() {
// //         images.addAll(pickedImages.map((xFile) => File(xFile.path)));
// //         print('Added ${pickedImages.length} images.');
// //       });
// //     } else {
// //       print('No images selected.');
// //     }
// //   }

// //   Future<String?> postImages(File imageFile) async {
// //     try {
// //       Reference ref = FirebaseStorage.instance
// //           .ref()
// //           .child('images')
// //           .child(imageFile.path.split('/').last);
// //       await ref.putFile(imageFile);
// //       String downloadUrl = await ref.getDownloadURL();
// //       return downloadUrl;
// //     } catch (e) {
// //       print("Error uploading image: $e");
// //       return null;
// //     }
// //   }

// //   uploadImages() async {
// //     for (var image in images) {
// //       if (kIsWeb) {
// //         final downloadUrl = await postImages(image);
// //         if (downloadUrl != null) {
// //           imageurls.add(downloadUrl);
// //         } else {
// //           print('no download url');
// //         }
// //       } else {
// //         print('try on web');
// //       }
// //     }
// //     print('Uploaded ${imageurls.length} images.');
// //   }
// // }
// import 'dart:io';
// import 'package:ecommerce/utils/styles.dart';
// import 'package:ecommerce/widgets/ecobutton.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:image_picker/image_picker.dart';
// import 'package:sizer/sizer.dart'; // Import kIsWeb to check for web platform

// class AddProductScreen extends StatefulWidget {
//   const AddProductScreen({Key? key}) : super(key: key);
//   static const String id = 'AddProductScreen';

//   @override
//   _AddProductScreenState createState() => _AddProductScreenState();
// }

// class _AddProductScreenState extends State<AddProductScreen> {
//   String? selectedValue;
//   final imagePicker = ImagePicker();
//   List<File> images = [];
//   List<String> imageUrls = [];

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         child: Center(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
//             child: Column(
//               children: [
//                 const Text(
//                   "Add Product Screen",
//                   style: EcoStyle.boldstyle,
//                 ),
//                 // DropdownButtonFormField and other UI elements here...

//                 EcoButton(
//                   buttonName: 'PICK IMAGE',
//                   onTap: pickImage,
//                   isLogInButton: true,
//                 ),
//                 EcoButton(
//                   buttonName: 'UPLOAD IMAGE',
//                   onTap: () {
//                     uploadImages();
//                   },
//                   isLogInButton: false,
//                 ),

//                 Container(
//                   height: 35.h,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.withOpacity(0.20),
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                   child: GridView.builder(
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 5,
//                     ),
//                     itemBuilder: (BuildContext context, int index) {
//                       // Display selected images
//                       return Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Stack(
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.black),
//                               ),
//                               height: 300,
//                               child: Image.network(images[index].path),
//                             ),
//                             IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   images.removeAt(index);
//                                 });
//                               },
//                               icon: const Icon(Icons.cancel_outlined),
//                             )
//                           ],
//                         ),
//                       );
//                     },
//                     itemCount: images.length,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   pickImage() async {
//     if (kIsWeb) {
//       List<XFile>? pickedImages = await imagePicker.pickMultiImage();
//       if (pickedImages != null) {
//         setState(() {
//           images.addAll(pickedImages.map((xFile) => File(xFile.path)));
//           print('Added ${pickedImages.length} images.');
//         });
//       } else {
//         print('No images selected.');
//       }
//     } else {
//       print('setup error');
//     }
//   }

//   Future<String?> postImage(File file) async {
//     try {
//       final ref = FirebaseStorage.instance.ref().child('images');
//       if (kIsWeb) {
//         // For web platform, use putFile to upload images
//         final fileBytes = await file.readAsBytes();
//         await ref.putData(fileBytes);
//       } else {
//         // For non-web platforms,  can use putData to upload image bytes
//         final fileBytes = await file.readAsBytes();
//         await ref.putData(fileBytes);
//       }

//       final downloadUrl = await ref.getDownloadURL();
//       return downloadUrl;
//     } on FirebaseException catch (e) {
//       print("Error uploading image: $e");
//       return null;
//     }
//   }

//   // Future<String?> postImage(File file) async {
//   //   try {
//   //     final ref = FirebaseStorage.instance.ref().child('images');
//   //     if (kIsWeb) {
//   //       await ref.putFile(file);
//   //     } else {
//   //       print('Unsuccessful');
//   //     }
//   //     final downloadUrl = await ref.getDownloadURL();
//   //     return downloadUrl;
//   //   } on FirebaseException catch (e) {
//   //     print("Error uploading image: $e");
//   //     return null;
//   //   }
//   // }

//   // Future<String?> postImage(File file) async {
//   //   try {
//   //     final ref = FirebaseStorage.instance.ref().child('images');
//   //     if (kIsWeb) {
//   //       await ref.putFile(file.path as File);
//   //     } else {
//   //       print('unsucessful');
//   //     }
//   //     final downloadUrl = await ref.getDownloadURL();
//   //     return downloadUrl;
//   //   } on FirebaseException catch (e) {
//   //     print("Error uploading image: $e");
//   //     return null;
//   //   }
//   // }

//   uploadImages() async {
//     for (var image in images) {
//       if (kIsWeb) {
//         final downloadUrl = await postImage(image);
//         if (downloadUrl != null) {
//           imageUrls.add(downloadUrl);
//         } else {
//           print('no download url');
//         }
//       } else {
//         print('try on web');
//       }
//     }
//     print('Uploaded ${imageUrls.length} images.');
//   }
// }
