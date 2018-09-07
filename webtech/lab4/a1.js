function validateForm() {
   
    
    var c = document.getElementById('name_p');
    // alert(c);
    c.style.color = "red";
    c.innerHTML = "asdfsd"
    document.getElementById('name_p').innerHTML = document.getElementsByName("name")[0].value;
    document.getElementById('city_p').innerHTML = document.forms["myForm"]["city"].value;
    document.getElementById('gender_p').innerHTML = document.getElementsByTagName("input")[2].value;
    document.getElementById('comments_p').innerHTML = document.forms["myForm"]["comments"].value;
   
}
// alert('Hello')
// console.log(document.getElementById('name_p'));

console.log('Hello');