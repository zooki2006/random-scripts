grep https:// ~/all-subscriptions.opml | sed 's/<outline xmlUrl="//g' | awk {'print $1'} | grep https:// | sed 's/"//g'
