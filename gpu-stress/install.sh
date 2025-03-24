#!/bin/bash

#install gpu-burn script
DIR="/home/$USER/baro"
user=$USER

if [ -d "$DIR" ]; then
    echo "디렉토리가 이미 존재합니다: $DIR"
else
    mkdir -p "$DIR"
    echo "디렉토리를 생성했습니다: $DIR"
fi

if [ -f "./stress-tool.sh" ]; then
    sed -i "s/^USER=.*/USER=\"$USER\"/" ./stress-tool.sh
    # sed -i "s/^EXEC_USER=.*/EXEC_USER=\"$TARGET_USER\"/" "$STRESS_SCRIPT"
else
    echo "ERROR: stress-tool.sh file does not exist"
    exit 1
fi

cp ./stress-tool.sh "$DIR"
mkdir "$DIR"/icon
cp ./images/BAROAS-64.png "$DIR"/icon

cd "$DIR"
git clone https://github.com/wilicc/gpu-burn.git
cd "./gpu-burn"
make

sudo ln -s /home/$USER/baro/stress-tool.sh /usr/bin
sudo chmod 755 /usr/bin/stress-tool.sh
echo -e "[Desktop Entry]\nName=Poseidon Diagnosis\nComment=Poseidon Diagnosis\nExec=stress-tool.sh\nIcon=/home/$USER/baro/icon/BAROAS-64.png\nTerminal=true\nType=Application\nCategories=Development;AS;BARO;" | sudo tee /usr/share/applications/BARO-AS.desktop > /dev/null
sudo chmod 777 /usr/share/applications/BARO-AS.desktop
sudo chmod +x /usr/share/applications/BARO-AS.desktop



