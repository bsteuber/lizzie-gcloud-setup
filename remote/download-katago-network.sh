#!/bin/bash
curl -L https://github.com/lightvector/KataGo/releases/download/v1.1/g104-b20c256-s447913472-d241840887.zip -o katago-network.zip
unzip katago-network.zip
gunzip g104-b20c256-s447913472-d241840887/model.txt.gz
cp g104-b20c256-s447913472-d241840887/model.txt .
