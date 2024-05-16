import 'package:flutter/material.dart';
class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final TextEditingController _textController = TextEditingController();
  Widget _buildChatComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 12,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration.collapsed(
                hintText: 'Type a message',
              ),
              // Add this to handle submission when user presses done
              onSubmitted: null,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            // Add this to handle submission when user presses the send icon
            onPressed: null,
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
          ),
        ),
        title: const Text(
          'WeCare - AI CHAT BOT',
          style: TextStyle(
              fontSize: 20,
              color: Colors.deepPurple,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w900,
              fontFamily: 'Lato'
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Stack(
            children: [
              Center(child: Text('Yet to Integrate with OpenAI API\'s',style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Lato'
              ),)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
        ),
        child: _buildChatComposer(),
      ),
    );
  }
}
