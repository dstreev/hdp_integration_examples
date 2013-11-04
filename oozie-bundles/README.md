#This is an example Oozie bundle.

This bundle specifies two coordinators under it: coord-one, coord-two
Both coordinators run the sample-subworkflow workflow with custom paths passed in via the job.properties and further
customized with the bundle.xml.

To run:
>oozie job -config oozie-bundles/control.properties/bundle-one/job.properties -Duser=$USER -Ddtg=`date "+%Y-%m-%dT%H:%MZ"` -run
