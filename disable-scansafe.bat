c:
cd "C:\Program Files (x86)\Cisco\Cisco AnyConnect Secure Mobility Client"
taskkill /f /IM acwebsecagent.exe
echo " " >acwebsecagent.txt
ren acwebsecagent.exe acwebsecagent1.exe
ren acwebsecagent.txt acwebsecagent.exe
