#!/bin/sh

set -e

npm install

export PATH="node_modules/.bin:node_modules/hubot/node_modules/.bin:$PATH"
export HUBOT_SLACK_TOKEN=xoxb-293521588738-ONKJuCgTtclwtPEqnzFSimIK

exec node_modules/.bin/hubot --adapter slack
