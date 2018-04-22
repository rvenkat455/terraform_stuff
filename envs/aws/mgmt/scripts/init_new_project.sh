#!/bin/bash

# This script will configure the following:
# Copy the skeleton_project to new project name under development. 
# Create a terraform statefile in S3.
# Create the terraform statefile.tf in the new project directory.
# updating this to do specific skeletons such as vpc, ec2 with alb configs. - D
# I've decided to keep the script non modular for now.

# Lets get initial location 
SCRIPT_PATH=$(dirname $(realpath -s $0)); echo $SCRIPT_PATH
cd ${SCRIPT_PATH}

echo "This script will create a new skeleton terraform project with shared statefile."

while true; do
    read -p "Do you want to create a dev or sandbox project? (d/s)? x for exit.   " env_ans
    case $env_ans in
        [Dd]* ) ENV='dev'; break;;
        [Ss]* ) ENV='sandbox'; break;;
        [Xx]* ) exit;;
        * ) echo "Please answer D for dev or S for sandbox.";;
    esac
done


echo -e "What is your PROJECT 3 Letter ID and name? Alpha Numeric only (0-9a-zA-Z_-) [ENTER]:"

read project_name

echo "Project Name: ${project_name}"


if [[ ! ${project_name} || ${project_name} = *[^0-9a-zA-Z_-]* ]]; then
    echo "Error: '${project_name}' is not a valid name" >&2
    exit 1
fi
echo "PATH=`pwd`"
# Create skeleton directory for project.
# As we get more prototyp skeletons we can put them here.
while true; do
    read -p "What type of project is this: <v>vpc, <s>services,<3>s3,<l>lambda,<d>db? [v/s/3/l/d]? If its all then us s. x for exit.  " pj 
    case $pj in
        [Vv]* ) projtype='vpc';
                    echo "cp -r ../skeletons/skeleton_vpc ../../${ENV}/${projtype}/${project_name}"
                    cp -r ../skeletons/skeleton_vpc ../../${ENV}/${projtype}/${project_name}
                    RC=$?
                    if [ $RC -ne 0 ]
                    then
                        echo "Something is wrong with the project creation skeleton copy. Please check if the project name exists already..."
                        exit 1
                    fi
                break;;
        [Ss]* ) projtype='services';
                    echo "cp -r ../skeletons/skeleton_project ../../${ENV}/${projtype}/${project_name}"
                    cp -r ../skeletons/skeleton_project ../../${ENV}/${projtype}/${project_name}
                    RC=$?
                    if [ $RC -ne 0 ]
                    then
                        echo "Something is wrong with the project creation skeleton copy. Please check if the project name exists already..."
                        exit 1
                    fi
                break;;
        [3]*  ) projtype='s3';
                    echo "cp -r ../skeletons/skeleton_project ../../${ENV}/${projtype}/${project_name}"
                    cp -r ../skeletons/skeleton_project ../../${ENV}/${projtype}/${project_name}
                    RC=$?
                    if [ $RC -ne 0 ]
                    then
                        echo "Something is wrong with the project creation skeleton copy. Please check if the project name exists already..."
                        exit 1
                    fi
                break;;
        [Ll]* ) projtype='lambda';
                    echo "cp -r ../skeletons/skeleton_project ../../${ENV}/${projtype}/${project_name}"
                    cp -r ../skeletons/skeleton_project ../../${ENV}/${projtype}/${project_name}
                    RC=$?
                    if [ $RC -ne 0 ]
                    then
                        echo "Something is wrong with the project creation skeleton copy. Please check if the project name exists already..."
                        exit 1
                    fi
                break;;
        [Dd]* ) projtype='data-storage';
                    echo "cp -r ../skeletons/skeleton_project ../../${ENV}/${projtype}/${project_name}"
                    cp -r ../skeletons/skeleton_project ../../${ENV}/${projtype}/${project_name}
                    RC=$?
                    if [ $RC -ne 0 ]
                    then
                        echo "Something is wrong with the project creation skeleton copy. Please check if the project name exists already..."
                        exit 1
                    fi
                break;;
        [Xx]* ) exit;;
        * ) echo "Please answer <v>vpc, <s>service,<3>s3,<l>lambda,<d>db a single character.";;
    esac
done



# Moving the basic project info to new project directory name...
mv ../../${ENV}/${projtype}/${project_name}/My_Project ../../${ENV}/${projtype}/${project_name}/${projtype}/${project_name} 
RC=$?
if [ $RC -ne 0 ]
then
        echo "Something is wrong with the project My_project to project directory name."
        exit 1
fi

clear
echo "**********************************************************************************************************"
echo "Your project location is : ${SCRIPT_PATH}/../../${ENV}/${projtype}/${project_name}/"
echo "Your project working directory is: ${SCRIPT_PATH}/../../${ENV}/${projtype}/${project_name}/${projtype}/${project_name}"
echo "**********************************************************************************************************"

echo "Initializing your shared project Terraform statefile"
NOundercoresNAME=$(echo ${project_name}|sed 's/_/-/g')
perl -p -i.bak -e "s/CHANGEMYNAME/${NOundercoresNAME}/g" ../../${ENV}/${projtype}/${project_name}/${projtype}/${project_name}/main.tf
perl -p -i.bak -e "s/CHANGEMYNAME/${NOundercoresNAME}/g" ../../${ENV}/${projtype}/${project_name}/${projtype}/${project_name}/Readme.md
cd ../../${ENV}/${projtype}/${project_name}/s3/terraform_statefile_bucket/
./initialize_new_project_statefile.sh

cp artifacts/statefile.tf ../../${projtype}/${project_name}

cd ../../
echo "**********************************************************************************************************"
echo "The absolute path to your project directory is : `pwd`"
echo "**********************************************************************************************************"
