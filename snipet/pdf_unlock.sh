#!/bin/sh
qpdf --password=$1 --replace-input --decrypt $0
