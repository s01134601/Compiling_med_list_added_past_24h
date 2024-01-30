#!/bin/bash

#!/bin/bash

if [[ $# != 2 ]]
then
  echo "target_directory_name destination_directory_name"
  exit
fi

if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory path provided"
  exit
fi

targetDirectory=$1
destinationDirectory=$2


echo "extracting csv from $targetDirectory into file in $destinationDirectory"

currentDT=$(date '+%Y-%m-%d')
#yesterdayDT=$(date -v -1d -j -f "%Y-%m-%d" "$currentDT" +%Y-%m-%d)
cd $targetDirectory
origAbsPath=$(pwd)

cd $destinationDirectory
destDirAbsPath=$(pwd)

cd $origAbsPath

for csv in $(find $targetDirectory -type f -name "*.csv" -ctime -1); do
  if [[ $csv == *medications* ]]; then
    echo $csv
    cat $csv >> "meds-$currentDT.csv"
  fi
  if [[ $csv == *encounters* ]]; then
    echo $csv
    cat $csv >> "encts-$currentDT.csv"
  fi
done

mv  "meds-$currentDT.csv" $destDirAbsPath
mv "encts-$currentDT.csv" $destDirAbsPath