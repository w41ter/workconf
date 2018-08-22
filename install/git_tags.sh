#!/bin/bash

function update_tags() {
	git fetch --tags
	latest_tag=$(git describe --tags `git rev-list --tags --max-count=1`)
	git checkout $latest_tag
}

