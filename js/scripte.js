var card = document.getElementById('card');
function showPage() {
    card.style.display = "block";
}
function slimMenuGo() {
    document.getElementById('nav-left').style.display = "block";
    document.getElementById('go').style.display = "none";
    document.getElementById('back').style.display = "block";
}
function slimMenuBack() {
    document.getElementById('nav-left').style.display = "none";
    document.getElementById('go').style.display = "block";
    document.getElementById('back').style.display = "none";
}

var ignoreClickOnMeElement = document.getElementById('card');
if (ignoreClickOnMeElement !== null){
    document.addEventListener('click', function (event) {
        var isClickInsideElement = ignoreClickOnMeElement.contains(event.target);
        if (!isClickInsideElement) {
            card.style.display = "none";
        }
    });
}



var pass = document.getElementById("pass");
var pass2 = document.getElementById("pass2");
var form = document.forms["user"];
function comparePass() {
    document.getElementById("user").addEventListener('submit', function (e) {

        if (pass.value != pass2.value) {
            e.preventDefault();
            var validationPass = document.getElementById("passSpan");
            validationPass.innerHTML = "�ifreniz E�le�medi"
            validationPass.style.color = "red";
            validationPass.style.fontSize = "12px"
        }
    });
}

// Form Validation
function validForm() {
    var isNotOk = false;
    var form = document.forms["user"];
    console.log("Girdim")
    
    if (isValid(form["Name"].value)) {
        document.getElementById("NameValid").innerHTML = "�sminiz bo� ge�ilemez ve �zel karakter icermemelidir.";
        isNotOk = true;
    }else{
        document.getElementById("NameValid").innerHTML = ""
    }
    if (isValid(form["Surname"].value)) {
        document.getElementById("SurnameValid").innerHTML = "Soyad�n�z bo� ge�ilemez ve �zel karakter icermemelidir.";
        isNotOk = true;
    }
    else{
        document.getElementById("SurnameValid").innerHTML = ""
    }
    if (isValid(form["pass"].value,true)) {
        document.getElementById("passSpan").innerHTML = "( . )  ( , ) ( @ ) Hari� �zel Karakter ��ermemeli";
        isNotOk = true;
    }
    else{
        document.getElementById("passSpan").innerHTML = ""
    }
    if (isValid(form["Email"].value,true)) {
        document.getElementById("EmailValid").innerHTML = "Ge�erli Bir Mail Adresi Giriniz";
        isNotOk = true;
    }
    else{
        document.getElementById("EmailValid").innerHTML = ""
    }
    if(form["Birthday"].value == ""){
        document.getElementById("BDValid").innerHTML = "Do�um tarihiniz bug�n ki tarihten b�y�k olamaz veya bo� ge�ilemez"
        isNotOk = true;
    }else{
        document.getElementById("BDValid").innerHTML = ""
    }

    if (isNotOk) {
        return false;
    }
}


function isValid(str,pass) {
    var char = ["!", "'", "^", "+", "%", "&", "/", "(", ")", "=", "*", "-", "_", "?", "}", "]", "[", "{", "$", "#", "�", ">", "<", '"'];
    var passChar = [",", ".", "@"]
    if (str == "") {
        return true;
    } else {
        
        for (let i = 0; i < char.length; i++) {
            if (str.includes(char[i])) {
                return true;
            }
        }
        if(!pass){
            for (let i = 0; i < passChar.length; i++) {
                if (str.includes(passChar[i])) {
                    return true;
                }
            }
            for (let i = 0; i < 10; i++) {
                if (str.includes(i)) {
                    return true;
                }
            }
        }
    }
}



