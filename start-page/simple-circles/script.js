function writeDate() {
    const date = new Date();
    const date_qs = document.querySelector('#not-seconds');
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    date_qs.innerHTML = date.getDate();
    date_qs.innerHTML = date_qs.innerHTML + ' ' + months[date.getMonth()];
    date_qs.innerHTML = date_qs.innerHTML + ' ' + date.getFullYear();
    date_qs.innerHTML = date_qs.innerHTML + ' ' + date.getHours();
    let minutes = date.getMinutes();
    if(minutes < 10) {
        minutes = '0' + minutes;
    };
    date_qs.innerHTML = date_qs.innerHTML + ':' + minutes;
    let seconds = date.getSeconds();
    if(seconds < 10) {
        seconds = '0' + seconds;
    };
    document.querySelector('#seconds').innerHTML = ':' + seconds;
}

setInterval(writeDate, 1000);
