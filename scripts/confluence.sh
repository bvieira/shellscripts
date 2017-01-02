#/bin/bash

confluenceUploadImage() {
	local imagepath=$1
	echo "uploading image $imagepath"
	local comment=`echo $imagepath | sed 's/.png//'`
	curl -k -u $confluence -X POST -H "X-Atlassian-Token: no-check" -F "file=@$imagepath" -F "comment=$comment" "$confluence_url$confluence_page_id$confluence_upload_uri"
	echo " "
}

confluenceUpdateImage() {
	local imagepath=$1
	echo "update image $imagepath"

	local imageid=`confluenceImageId "$imagepath"`
	if [ -z $imageid ]; then
		echo "could not find image $imagepath on confluence"
	else
		echo "found image id:[$imageid]"
		curl -k -u $confluence -X POST -H "X-Atlassian-Token: no-check" -F "file=@$imagepath" "$confluence_url$confluence_page_id$confluence_upload_uri/$imageid/data"
	fi
	echo " "
}

confluenceImageId() {
	local imagename=$1
	curl -s -k -u $confluence -X GET -H "X-Atlassian-Token: no-check" "$confluence_url$confluence_page_id$confluence_upload_uri" | jq -r ".results[] | select(.title == \"$imagename\") | .id "
}


