//Write JS code to validate a given string starts with special character or not
function startsWithSpecialCharacter(str) {
 
    const specialCharacterRegex = /^[!@#$%^&*(),.?":{}|<>]/;
 
    return specialCharacterRegex.test(str);
}


function startsWithNumerical(str){
    const numericalRegex = /^[0-9]/;
    return numericalRegex.test(str);
}


const input = "!Hello World";
const result = startsWithSpecialCharacter(input);

console.log(result);

if(result){
    console.log("String Started With Special Character");
}
else{
    console.log("String Not Started With Special Character");
}

