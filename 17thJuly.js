//Write JS code to validate a given string starts with special character or not
function startsWithSpecialCharacter(str) {
 
    const specialCharacterRegex = /^[!@#$%^&*(),.?":{}|<>]/;
 
    return specialCharacterRegex.test(str);
}

console.log(startsWithSpecialCharacter("Hello"));
if(true){
    console.log("String Started With Special Character");
}
else{
    console.log("String Not Started With Special Character");
}

