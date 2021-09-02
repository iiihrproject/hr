//檢查表單

$("#postdate").blur(function() {
	let postdateValue = document.getElementById("postdate").value;
	let div2 = document.getElementById('result2c');
	if (postdateValue < td) {
		setErrorFor(div2, "刊登日期已過");
	} else {
		div2.innerHTML = "";
	}
})
$("#exp").blur(function() {
	let postdateValue = document.getElementById("postdate").value;
	let expValue = document.getElementById("exp").value;
	let div3 = document.getElementById('result3c');
	if (expValue < postdateValue) {
		setErrorFor(div3, "有效日期不可小於刊登日期");
	} else {
		div3.innerHTML = "";
	}
})
$("#enddate").blur(function() {
	let enddateValue = document.getElementById("enddate").value;
	let postdateValue = document.getElementById("postdate").value;
	let expValue = document.getElementById("exp").value;
	let div5 = document.getElementById('result5c');
	if (enddateValue < postdateValue) {
        setErrorFor(div5, "報名截止日期不可小於貼文刊登日期");
    } else if (enddateValue > expValue) {
        setErrorFor(div5, "報名截止日期不可大於貼文下架日期");
    } else {
    div5.innerHTML = "";
    }
})

//預覽載入
//let checkinsert = document.getElementById("checkinsert");
//checkinsert.onclick = function() {
	function checkinsertbutton (type){
	console.log(type);
	let titleValue = document.getElementById("title").value;
	let descriptionValue = $(".ck-content").html();
	let destextValue = $(".ck-content").text();
	let file1Value = document.getElementById("file1").value;
	let quotaValue = $("[name='quotatype']:checked").val();
	let quotanValue = "";
	let enddateValue = "";
	if(quotaValue!=null){
	quotanValue = document.getElementById("quotanid").value;
	
	enddateValue = document.getElementById("enddate").value;
	}
	let postdateValue = document.getElementById("postdate").value;
	let expValue = document.getElementById("exp").value;
	let file = $('#file1')[0].files[0];

	//預覽前驗證資料
	let div0 = document.getElementById('result0c');
	let div1 = document.getElementById('result1c');
	let div2 = document.getElementById('result2c');
	let div3 = document.getElementById('result3c');
	let div4 = document.getElementById('result4c');
	let div5 = document.getElementById('result5c');
	if (!titleValue) {
		setErrorFor(div0, "請輸入主旨");
	} else {
		div0.innerHTML = "";
	}
	if (!destextValue) {
		setErrorFor(div1, "請輸入內容");
	} else {
		div1.innerHTML = "";
	}
	if (!postdateValue) {
		setErrorFor(div2, "請輸入刊登日期");
	} else if (postdateValue < td) {
		setErrorFor(div2, "刊登日期已過");
	} else {
		div2.innerHTML = "";
	}
	if (!expValue) {
		setErrorFor(div3, "請輸入刊登日期");
	} else if (expValue < postdateValue) {
		setErrorFor(div3, "有效日期不可小於刊登日期");
	} else {
		div3.innerHTML = "";
	}
	console.log(type);
	if (type=='公告') {
	} else {
	
	if (quotaValue == "限制" && quotanValue == 0) {
		setErrorFor(div4, "請輸入可報名額");
	} else if (quotaValue==""||quotaValue==null){
	}
	else {
		div4.innerHTML = "";
	}
	
	
	if (!enddateValue){
    	setErrorFor(div5, "請輸入報名截止日期");  
    } else if (enddateValue<postdateValue) {
        setErrorFor(div5, "報名截止日期不可小於貼文刊登日期");
    } else if (enddateValue>expValue) {
        setErrorFor(div5, "報名截止日期不可大於貼文下架日期");
    } else {
    div5.innerHTML = "";
    }
    }


	//預覽資料載入
	document.getElementById("chtitle").innerHTML = titleValue;
	document.getElementById("chdescrib").innerHTML = descriptionValue;

	console.log(document.getElementById('file1').files);

	if (file1Value == "") {
		document.getElementById("tdfile").innerHTML = "";
	} else {
		selectImgFile2(document.getElementById('file1').files)
	}
	if (type =='公告'){
		document.getElementById("tdqu").innerHTML = "";
		document.getElementById("trenddate").innerHTML = "";
		console.log('公告');
		console.log(type);
	} else {
		if (quotaValue == "不限"||quotaValue == '') {
			document.getElementById("tdqu").innerHTML = "";
		}
		else {
			document.getElementById("tdqu").innerHTML = "<td>已報名人數：&nbsp&nbsp／&nbsp可報名人數：" + quotanValue + "</td>";
		}
	document.getElementById("ched").innerHTML = enddateValue;
	console.log('不是公告');
	}
	document.getElementById("chpd").innerHTML = postdateValue;
	console.log("titleValue主旨:" + titleValue);
	console.log("descriptionValue內容:" + descriptionValue);
	console.log("destextValue內容:" + destextValue);
	console.log("file1Value檔案名:" + file1Value);
	console.log("quotaValue名額:" + quotaValue);
	console.log("quotanValue名額數:" + quotanValue);
	console.log("postdateValue刊登日:" + postdateValue);
	console.log("expValue有效日:" + expValue);
	console.log("file檔案內容:" + file);

}


//錯誤訊息顯示
function setErrorFor(input, message) {
	input.innerHTML = "<font color='red' size='-2'>" + message + "</font>";
	hasError = true;
}



//載入圖片(預覽)
function selectImgFile2(files) {
	if (!files.length) {
		return false;
	}
	console.log("載入圖片");
	let file = files[0];
	let reader = new FileReader();
	reader.onload = function() {
		document.getElementById('showImg').src = this.result;
		document.getElementById('showImg2').src = this.result;
	};

	reader.readAsDataURL(file);
}


//ckeditor
ClassicEditor
	.create(document.querySelector('.editor'), {

		toolbar: {
			items: [

				'bold',
				'italic',
				'bulletedList',
				'numberedList',
				'alignment',
				'|',
				'fontFamily',
				'fontColor',
				'fontSize',
				'fontBackgroundColor',
				'|',
				'outdent',
				'indent',
				'|',
				'insertTable',
				'|',
				'undo',
				'redo'
			]
		},
		language: 'zh',
		licenseKey: '',



	})
	.then(editor => {
		window.editor = editor;




	})
	.catch(error => {
		console.error('Oops, something went wrong!');
		console.error('Please, report the following error on https://github.com/ckeditor/ckeditor5/issues with the build id and the error stack trace:');
		console.warn('Build id: uxohsv80y3i-k42ot45c5h7d');
		console.error(error);
	});
    
