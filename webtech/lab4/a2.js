var i = 0
var images = document.getElementsByClassName('img');

function init(){
	console.log('init');
	button();
	images[i].style.display="block";
	document.getElementById('click').style.display="none";

}



function button(){
	console.log('Inside button');
	console.log(i);
	if(i==0){
	document.getElementById('prev').style.display="none";
	}
	else{
	document.getElementById('prev').style.display="block";
	}
	if(i==images.length-1){
	document.getElementById('next').style.display="none";
	}
	else{
	document.getElementById('next').style.display="block";
	}
}

function previous(){
	images[i].style.display="none";	
	if(i!=0){
		i = i - 1;
	}
	console.log(i);
	button();
	console.log('Inside previous');
	
	images[i].style.display="block";
}

function next(){
	images[i].style.display="none";
	if(i!=images.length-1){
		i = i + 1;
	}
	button();
	console.log(i);
	
	console.log('Inside next');

	console.log(images[i]);
	images[i].style.display="block";
}

