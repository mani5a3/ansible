#Get iam roles in all the account who is having admin access

#!/bin/bash

# List of AWS account numbers
AWS_ACCOUNTS=("331147279893" "331147279893" "447391880994" "565212748888" "952369627991" "145474922795" "500189091696" "691147402122" "245303502954" "528622664986" "308305820387" "112312943437" "292734900874" "573678217237" "509704156812" "633759717959" "148656707384" "408088146858" "416029571919" "768545751310" "997184583240" "664353777389" "266446420302" "171749804602" "657681547968" "452460757919" "149918973571" "867907917890" "943175875100" "532781312430" "562557054605" "485312260899" "044647457783" "511118448992" "304851017013" "404738986417" "744028557743" "939660078260" "062155287677" "470061707647" "160513558103" "225704776140" "263975693283" "037189988778" "116300961321" "591212346577" "688162211510" "721615699755" "215088829050" "793338487117" "023061712707" "176309687584" "948452720140" "804596621126" "781300432669" "288276583063" "288053755200" "041436144223" "819398422556" "099188235737" "237840073416" "295494579406" "395392661826" "608568517019" "027512332805" "863095730804" "121028549860" "170895530469" "898321658754" "335450336797" "312308075865" "261390753486" "391767297048" "112977169560" "630034004811" "846016091089" "089622505299" "134284705459" "655091057032" "134378379242" "575672604269" "284929069175" "574828499418" "128396351922" "661664821915" "230999311295" "432062541160" "404067826977" "980758408536" "584677525125" "848557332205" "301465073021" "216191278443" "407796944905" "741547339323" "975746488271" "566618788984" "501633652046" "669223117140" "191622701417" "869562651934" "307762127893" "172022008291" "928734777579" "050258167832" "594504648029" "520345425786" "246782364422" "373275528530" "369556419013" "394420708252" "381188050020" "744382122683" "883080883690" "666717213534" "259987506714" "422691248530" "445516054113" "819330636272" "104837470211" "458970401082" "214656360355" "231687720157" "897561502983" "192837112824" "220632944928" "498830398962" "632294257753" "838678933722" "367276040723" "658350099502" "255432612548" "814185912447" "447378552641" "554938577517" "173770525499" "464726560072" "049320967203" "470555705457" "285375591873" "138762898312" "381203884180" "427490246842" "313884976513" "586301939372" "357953929409" "289525433309" "154697014847" "108342218276" "757700153223" "480931186706" "132664132107" "096644897442" "736745110121" "972326929235" "683966224336" "560969459578" "979148846069" "756759416234" "016980259655" "879528468877" "097423772229" "403252530299" "672719040090" "545701820261" "549185180287" "199571279995" "281189948908" "614626420141" "671735518696" "658713976729" "532019304276" "000699977340" "148514820401" "266686110879" "413443458857" "562797857440" "483840214396" "164144265376" "262870277119" "593533515596" "069561708933" "630651582241" "491494443252" "721831898127" "845157413587" "230534509768" "408001552541" "111258924615" "211403323780" "822529079839" "556846961598" "877107872133" "818451915023" "994741436755" "809153966361" "373170838662" "385145319859" "642910307493" "943962962571" "869700871223" "759807043775" "962641467087" "916446241417" "251487393988" "763772356654" "384635778208" "033964657120" "915762777694" "593374787003" "576266738862" "398438148275" "729029490000" "963826774118" "176831564014" "375390762828" "640630851204"  "083186580066")

# Specify the AWS profile to use
AWS_PROFILE="your_common_profile"

# Iterate through each AWS account
for account in "${AWS_ACCOUNTS[@]}"; do
    echo "Checking roles in AWS account: $account"
    
    # Set the AWS CLI profile to the specific account
    #aws configure set profile.$account.role_arn arn:aws:iam::$account:role/your-assumed-role-name
    #aws configure set profile.$account.source_profile $AWS_PROFILE

    # Get a list of all IAM roles in the account
    roles=$(aws iam list-roles --query 'Roles[*].RoleName' --output text --profile $account)

for role in $roles; do
        # Check if the role has the AdministratorAccess policy attached
        policies=$(aws iam list-attached-role-policies --role-name $role --query 'AttachedPolicies[*].PolicyName' --output text --profile $account 2>/dev/null)

        if echo "$policies" | grep -q 'AdministratorAccess'; then
            echo "RoleName: $role, Account: $account" >> awsiamroleslist.txt
        fi
    done
    echo "Finished checking roles in AWS account: $account"
    echo "========================================"
done