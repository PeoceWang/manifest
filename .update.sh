#!/bin/bash

#
# coron-4.2 is master, other branches are slaves.
#


function usage()
{
    echo ".update --merge    Merge from ${MASTER}"
    echo ".update --upload   Upload all commits"
}


MASTER=coron-4.2
BRANCHES=(coron-4.0 coron-4.1 coron-mtk-4.0 coron-mtk-4.2)
function merge()
{
	for branch in ${BRANCHES[*]} ; do

		git checkout ${branch}
		git fetch --all
		git rebase origin/${branch}

		git merge origin/${MASTER}
	done
    git checkout ${MASTER}
}

function upload()
{
	for branch in ${BRANCHES[*]} ; do
		git push -u origin ${branch}
	done
}


[ $# -lt 1 ] &&  usage && exit 1

if [ "$1" == "--merge" ]; then
	merge
elif [ "$1" == "--upload" ]; then
	upload
fi
