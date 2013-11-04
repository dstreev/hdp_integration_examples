#Sample Oozie sub-workflow

This example demonstrates launching a sub-workflow from another workflow.  It is important to understand that when
either the sub-workflow or parent workflow reach the 'end,' the entire job is finished. Therefore, you cannot chain
sub-workflows.

In this example, you provide a decision to the parent workflow to act on.  The parent will use the variable
'whichWorkflow' to determine which sub-workflow to run.  The sub-workflows will create directories in HDFS.

Example:

>oozie job -config oozie-workflows/control.properties/workflows/sample-subworkflow/job.properties -Duser=$USER -DwhichWorkflow=two -run

This will cause the parent workflow to run sub-workflow 'sub-two' which will create directory: /user/$USER/base/two