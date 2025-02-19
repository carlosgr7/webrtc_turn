import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignalingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RTCPeerConnection? _peerConnection;

  Future<void> initConnection(String roomId) async {
    var config = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
        {'urls': 'turn:34.118.78.214:3478', 'username': 'user', 'credential': 'e5308562c7480b9c4e6f5cc5294c06125900b5d60eb5889210895bb14e1caa9d'}
      ]
    };

    _peerConnection = await createPeerConnection(config);

    _peerConnection!.onIceCandidate = (RTCIceCandidate candidate) {
      _firestore.collection('rooms').doc(roomId).update({
        'candidates': FieldValue.arrayUnion([candidate.toMap()])
      });
    };

    RTCSessionDescription offer = await _peerConnection!.createOffer();
    await _peerConnection!.setLocalDescription(offer);

    _firestore.collection('rooms').doc(roomId).set({
      'offer': offer.toMap(),
    });
  }
}