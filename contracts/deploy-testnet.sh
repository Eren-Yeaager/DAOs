#!/bin/bash

ACCOUNT_ID=mdao-owner.testnet
CONTRACT=v1.mdao-owner.testnet

near delete "$CONTRACT" "$ACCOUNT_ID" --force
near create-account "$CONTRACT" --masterAccount "$ACCOUNT_ID" --initialBalance 5

near deploy "$CONTRACT" ./res/mdao.wasm --initFunction new --initArgs '{}'

## -------- Data Seed --------
# Add DAO
 near call "$CONTRACT" add_dao '{"body": {"title":"First DAO", "handle":"first-dao", "description":"Some description...","logo_url":"logo", "banner_url":"banner","is_congress":false}, "owners":["'$ACCOUNT_ID'"], "category_list":[], "metrics":[], "metadata":{"website":"test website"}}' --accountId "$CONTRACT"
 near call "$CONTRACT" add_dao '{"body": {"title":"Second DAO", "handle":"second-dao", "description":"Some description 2...","logo_url":"logo2", "banner_url":"banner2","is_congress":false}, "owners":["'$ACCOUNT_ID'","owner.testnet"], "category_list":[], "metrics":[], "metadata":{"website":"test website"}}' --accountId "$CONTRACT"

# Add DAO Proposal
 near call "$CONTRACT" add_dao_post '{"dao_id":1, "body":{"title":"Proposal title #1", "description":"Proposal description 1...", "labels":[], "metrics":{}, "reports":[], "post_type": "Proposal", "proposal_version": "V1"}}' --accountId "$ACCOUNT_ID"
 near call "$CONTRACT" add_dao_post '{"dao_id":1, "body":{"title":"Report title #2", "description":"Report description 2...", "labels":["report-label", "gaming"], "metrics":{}, "proposal_id":1, "post_type": "Report", "report_version": "V1"}}' --accountId "$ACCOUNT_ID"
 near call "$CONTRACT" add_dao_post '{"dao_id":2, "body":{"title":"Proposal title #3", "description":"Proposal description 3...", "labels":[], "metrics":{}, "reports":[], "post_type": "Proposal", "proposal_version": "V1"}}' --accountId "$ACCOUNT_ID"

## Like Proposal/Report
# near call "$CONTRACT" post_like '{"id":1}' --accountId "$ACCOUNT_ID"
#
## Add Comment
# near call "$CONTRACT" add_comment '{"post_id":1, "description":"Some comment text"}' --accountId "$ACCOUNT_ID"
#
## Add Comment reply
# near call "$CONTRACT" add_comment '{"post_id":1, "description":"Reply comment text", "reply_id":1}' --accountId "$ACCOUNT_ID"
#
## Like comment
# near call "$CONTRACT" comment_like '{"id":1}' --accountId "$ACCOUNT_ID"
#
## Remove like from post
# near call "$CONTRACT" post_unlike '{"id":1}' --accountId "$ACCOUNT_ID"
