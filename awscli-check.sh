echo "=======aws cli Check============="

aws_cli_version=$(aws --version 2>&1 | cut -d " " -f1 | cut -d "/" -f2 | cut -d "." -f1)

if [[ "$aws_cli_version" == "2" ]]
then
    echo "aws cli  version is ok"
else
    echo "aws cli version is not 2.x version" 
    exit 1
fi
