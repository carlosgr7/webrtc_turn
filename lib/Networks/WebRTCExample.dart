import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class WebRTCExample extends StatefulWidget {
  @override
  _WebRTCExampleState createState() => _WebRTCExampleState();
}

class _WebRTCExampleState extends State<WebRTCExample> {
  RTCPeerConnection? peerConnection;
  RTCDataChannel? dataChannel;

  // Configuración del servidor TURN
  final List<Map<String, dynamic>> iceServers = [
    {
      'urls': 'turn:your_server_ip_or_domain:3478', // Dirección de tu servidor TURN
      'username': 'your_username',  // Nombre de usuario
      'credential': 'your_credential',  // Credenciales del servidor TURN
    },
  ];

  @override
  void initState() {
    super.initState();
    initializeConnection();
  }

  // Inicializar la conexión WebRTC
  Future<void> initializeConnection() async {
    peerConnection = await createPeerConnection(
      {
        'iceServers': iceServers,
      },
    );

    // Configurar el manejo de ICE candidates
    peerConnection?.onIceCandidate = (candidate) {
      if (candidate != null) {
        print("Nuevo ICE Candidate: ${candidate.candidate}");
        // Aquí deberías enviar este candidate al otro par para que lo agregue
      }
    };

    // Otras configuraciones del peerConnection, como agregar pistas de video o audio
  }

  // Crear una oferta (SDP)
  Future<void> createOffer() async {
    if (peerConnection == null) return;

    try {
      // Crear una oferta SDP
      RTCSessionDescription offer = await peerConnection!.createOffer();

      // Establecer la oferta como la descripción local
      await peerConnection!.setLocalDescription(offer);
      print("Oferta SDP creada: ${offer.sdp}");

      // Aquí deberías enviar la oferta a través de tu servidor de señalización (como Firebase, WebSockets, etc.)
    } catch (e) {
      print("Error al crear la oferta: $e");
    }
  }

  // Establecer la descripción remota (cuando el otro dispositivo responde con su SDP)
  Future<void> setRemoteDescription(RTCSessionDescription offer) async {
    if (peerConnection == null) return;

    try {
      // Establecer la oferta recibida como descripción remota
      await peerConnection!.setRemoteDescription(offer);
      print("Descripción remota configurada.");
    } catch (e) {
      print("Error al configurar la descripción remota: $e");
    }
  }

  // Agregar ICE candidate al peerConnection
  Future<void> addIceCandidate(RTCIceCandidate candidate) async {
    if (peerConnection == null) return;

    try {
      await peerConnection?.addCandidate(candidate);

      print("ICE Candidate agregado: ${candidate.candidate}");
    } catch (e) {
      print("Error al agregar el ICE Candidate: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebRTC Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: createOffer,
          child: Text('Crear Oferta SDP'),
        ),
      ),
    );
  }
}
