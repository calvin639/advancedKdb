#!/bin/bash

q sub.q -p 5090 &
q html.q &
cd html
python3 -m http.server 1234 &
