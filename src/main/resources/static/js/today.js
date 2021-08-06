/*!取得今天的日期，使用變數td*/

let today = new Date();
let year = today.getFullYear();
let month = 0;
let date = 0;
if (today.getMonth() + 1 < 10) { month = "0" + (today.getMonth() + 1); }
else { month = today.getMonth() + 1; }
if (today.getDate() < 10) {
	date = "0" + today.getDate();
}
else { date = today.getDate(); }

let td = "";
td += year + "-" + month + "-" + date;