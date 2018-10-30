/*//on window load get elts with class time
window.onload=function(){var time = document.getElementsByClassName('time');
console.log("tf loaded");
//add keyup listener to all elts w/ class time
for (var i = 0; i < time.length; i++) {
    time[i].addEventListener('keyup', function (e) {
        //remove non digit characters 
        this.value = this.value.replace(/\D/g,"");
        //insert colons
        if (this.value.length >= 5){
		this.value = this.value.substring(0,this.value.length-4) + ':' + this.value.substring(this.value.length-4,this.value.length-2) 
		+ ':' + this.value.substring(this.value.length-2,this.value.length);
        }else if (this.value.length > 2){
		this.value = this.value.substring(0,this.value.length-2) + ':' + this.value.substring(this.value.length-2,this.value.length);
	}
    });
};}*/
