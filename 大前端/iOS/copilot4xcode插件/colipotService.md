```sequence
title: copilotCommand
EditorExtension->ExtensionService: GetSuggestionsCommand(invocation)
ExtensionService->ExtensionService: AsyncXPCService.getSuggestedCode()
```