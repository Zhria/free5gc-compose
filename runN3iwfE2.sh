#!/bin/bash

PARAM_AVVIO=""

for arg in "$@"; do
    case "$arg" in
        -e)
            echo "Voglio solo E2 Node"
            PARAM_AVVIO="free5gc-e2node"
            ;;
        -n)
            echo "Voglio solo N3IWF"
            PARAM_AVVIO="free5gc-n3iwf"
            ;;
        -ne)
            echo "Voglio N3IWF e E2 Node"
            PARAM_AVVIO="free5gc-e2node free5gc-n3iwf"
            ;;
        *)
            echo "Argomento sconosciuto: $arg"
            ;;
    esac
done

if [ -z "$PARAM_AVVIO" ]; then
    echo "Nessun argomento passato: uso default (tutti i servizi)"
    PARAM_AVVIO=""
fi

sudo docker pull zhria/n3iwfcustom:latest
sudo docker pull zhria/amfcustom:latest
sudo docker pull zhria/smfcustom:latest
sudo docker pull zhria/e2node:latest

sudo docker compose -f docker-compose-build.yaml up $PARAM_AVVIO
