This file is a work in progress. Please help to refine approach if you have better ideas.

Goal:
To let open interpreter run code in an iOS native app which can automate tasks.

Approach:
1. Use the Shortcuts app ecosystem to automate tasks of IOS and of third party apps. Deeplinks are currently the only way to access these shortcuts. However, Apple could open the Shortcuts app to third party apps like they have done with Siri Shortcuts.  shortcuts: //???

Users will need to lauch an Action from the Shortcuts App to allow the OI native app to import all the shortcut a user has.


2. Use the clipboard to copy text from any app and allow Open Interpreter native iOS app to take action on that piece of text.
The clipboard can work with all texts.  Limits...?

3. Use the Document Provider API (Apple) to work with documents which third party apps make available or that from the built-in Files app.
The files list can be retrieved via API. Only files exported using Document Provider from third party apps are available.

4. Use the iOS built-in speech-to-text API to convert voice input to text prompts.

Other Projects used:
1. Python for iOS.
2. Run python code in the native app. 
3. 


Disclamer: I’m not an LLM expert. My expertise is in mobile development. 