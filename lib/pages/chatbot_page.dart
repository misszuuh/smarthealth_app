import 'package:flutter/material.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage userMessage = ChatMessage(
      text: text,
      isUser: true,
    );
    
    setState(() {
      _messages.insert(0, userMessage);
    });
    
    // Simulate doctor's response after a short delay
    Future.delayed(const Duration(seconds: 1), () {
      ChatMessage botMessage = ChatMessage(
        text: _getDoctorResponse(text),
        isUser: false,
      );
      setState(() {
        _messages.insert(0, botMessage);
      });
    });
  }

  String _getDoctorResponse(String userInput) {
    userInput = userInput.toLowerCase();
    if (userInput.contains('hello') || userInput.contains('hi')) {
      return 'Hello! I\'m Dr. Smith. How can I help you today?';
    } else if (userInput.contains('pain')) {
      return 'I\'m sorry to hear you\'re experiencing pain. Can you tell me more about where and when you feel it?';
    } else if (userInput.contains('fever')) {
      return 'How long have you had the fever? Have you taken your temperature?';
    } else if (userInput.contains('thank')) {
      return 'You\'re welcome! Is there anything else you\'d like to discuss?';
    } else {
      return 'I understand. Can you provide more details about your symptoms?';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with Doctor'),
        backgroundColor: const Color(0xFFE75480),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (_, index) => _messages[index],
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Type your message here...'),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({
    super.key,
    required this.text,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: isUser 
                  ? const Color(0xFFE75480)
                  : Colors.blue,
              child: Icon(
                isUser ? Icons.person : Icons.medical_services,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isUser ? 'You' : 'Dr. Smith',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}