window.onload=function(){
	console.log("loaded")
	var start_buttons = document.getElementsByClassName('start-timer');
	var stop_buttons = document.getElementsByClassName('stop-timer');
	for (var i =0; i < start_buttons.length; i++){
		console.log(i);
		var btn = start_buttons[i];
		btn.addEventListener("click", function(e){
			time_task_entry(btn);
		})
	}
	for (var i =0; i < stop_buttons.length; i++){
		console.log(i);
		var btn = stop_buttons[i];
		btn.addEventListener("click", function(e){
			time_task_entry(btn);
		})
	}
}
function time_task_entry(btn){
	var task_id = btn.getAttribute("te_id");
	fetch("/task_entries/"+task_id, {
		method: "PATCH", 
  		headers: {
   		'Content-Type': 'application/json',
    		'X-CSRF-Token': Rails.csrfToken()
  		}})
		.then(data => {
		console.log(data);
		if (btn.classList.contains("start-timer")){
			btn.classList.remove("start-timer");
			btn.classList.add("stop-timer");
			btn.textContent="Stop";
		}else{
			btn.classList.remove("stop-timer");
			btn.classList.add("start-timer");
			btn.textContent="Start";
			location.reload(true);
		}
		})
}
