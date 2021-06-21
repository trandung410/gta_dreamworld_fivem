// progressbar.js@1.0.0 version is used
// Docs: http://progressbarjs.readthedocs.org/en/1.0.0/
window.addEventListener('message', function(event) {
    if(event.data.type == 'open'){
        var bar = new ProgressBar.Circle(container, {
            strokeWidth: 6,
            color: '#FFEA82',
            trailColor: '#eee',
            trailWidth: 0.1,
            easing: 'easeInOut',
            duration: 1,
            svgStyle: null,
            text: {
            value: 'Oxygen',
            alignToBottom: false
            },
            from: {color: '#fc0324'},
            to: {color: '#03fc56'},
            // Set default step function for all animate calls
            step: (state, bar) => {
            bar.path.setAttribute('stroke', state.color);
            var value = Math.round(bar.value() * 100);
            if (value === 0) {
                bar.setText('0%');
                //
            } else {
                bar.setText(value+'%');
            }
        
            bar.text.style.color = state.color;
            }
        });
        bar.text.style.fontFamily = '"Raleway", Helvetica, sans-serif';
        bar.text.style.fontSize = '2rem';
        var percent = 1.0;
        bar.animate(percent);  // Number from 0.0 to 1.0
        var d = new Date();
        var n = d.getTime();
		window.addEventListener('message', function(event) {
			if(event.data.type == 'cancel'){
				bar.destroy();
		}});
        loopAGame = setInterval(function() {   
                        var z = new Date();
                    percent = percent - 0.001;
                    bar.animate(percent); 
                    //document.getElementById("text").innerHTML = z.getTime() - n;
                    if (percent <= 0.00001){
                        clearInterval(loopAGame);
                        bar.destroy();
                        $.post('http://lorraxs_percent/done', JSON.stringify({}));
                    }
                }, event.data.thoigian / 1000);
    }else if(event.data.type == 'openUp'){
        var bar = new ProgressBar.Circle(container, {
            strokeWidth: 6,
            color: '#FFEA82',
            trailColor: '#eee',
            trailWidth: 0.1,
            easing: 'easeInOut',
            duration: 1,
            svgStyle: null,
            text: {
            value: 'Oxygen',
            alignToBottom: false
            },
            from: {color: '#fc0324'},
            to: {color: '#03fc56'},
            // Set default step function for all animate calls
            step: (state, bar) => {
            bar.path.setAttribute('stroke', state.color);
            var value = Math.round(bar.value() * 100);
            if (value === 0) {
                bar.setText('0%');
                //
            } else {
                bar.setText(value+'%');
            }
        
            bar.text.style.color = state.color;
            }
        });
        bar.text.style.fontFamily = '"Raleway", Helvetica, sans-serif';
        bar.text.style.fontSize = '2rem';
        var percent = 0.0;
        bar.animate(percent);  // Number from 0.0 to 1.0
        var d = new Date();
        var n = d.getTime();
		window.addEventListener('message', function(event) {
			if(event.data.type == 'cancel'){
				bar.destroy();
		}});
        loopAGame = setInterval(function() {   
                        var z = new Date();
                    percent = percent + 0.001;
                    bar.animate(percent); 
                    //document.getElementById("text").innerHTML = z.getTime() - n;
                    if (percent >= 0.999){
                        clearInterval(loopAGame);
                        bar.destroy();
                        $.post('http://lorraxs_percent/done', JSON.stringify({}));
                    }
                }, event.data.thoigian / 1000);
    }
})