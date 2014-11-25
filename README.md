# tpscript

Scripts for TargetProcess

## Cumulative flow

Extracts from TargetProcess the cumulative flow for a specific team, and prints it in CSV format.

From the repository main directory, run:

    ./cumulative_flow -t <a TP team> -b <TP base url> -u <TP username> -p <TP password> 

The team must be provided as the abbreviation assigned to it in TargetProcess.

*Example:*

    ./cumulative_flow -t XYZ -b https://mytpurl -u bob -p agqywq865q 

It is possible to include only specific states in the result, and to define a specific order for them. 
To do this, add the `--states` option with the names of the states you want, separated by commas.

    ./cumulative_flow -t XYZ -b https://mytpurl -u bob -p agqywq865q \
            --states 'State one,State two,State three'
