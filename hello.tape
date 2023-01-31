Output hello.gif

Require cowsay

Set Theme "OneHalfDark"
Set FontSize 40
Set FontFamily "monospace"
Set Width 2100
Set Height 1500
# https://github.com/charmbracelet/vhs/issues/88
Set Framerate 20

Type echo "starting welcome script..."
Sleep 500ms
Enter

Type "./greet-visitor.sh"
Sleep 500ms
Enter

Sleep 20s