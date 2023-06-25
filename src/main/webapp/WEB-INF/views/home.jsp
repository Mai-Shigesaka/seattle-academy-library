<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page contentType="text/html; charset=utf8"%>
<%@ page import="java.util.*"%>
<html>
<head>
<title>ホーム｜シアトルライブラリ｜シアトルコンサルティング株式会社</title>
<link href="<c:url value="/resources/css/reset.css" />" rel="stylesheet"
	type="text/css">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+JP"
	rel="stylesheet">
<link href="<c:url value="/resources/css/default.css" />"
	rel="stylesheet" type="text/css">
<link href="https://use.fontawesome.com/releases/v5.6.1/css/all.css"
	rel="stylesheet">
<link href="<c:url value="/resources/css/home.css" />" rel="stylesheet"
	type="text/css">
<meta content="text/html; charset=shift_jis" http-equiv="Content-Type" />
</head>
<body class="wrapper">
<div class="overlay"></div>
  <nav class="nav">
    <div class="toggle">
      <span id="deleteconpo" class="toggler"></span>
    </div>
    <div class="logo">
      <a href="#">MENU</a>
    </div>
    <ul class="linkList">
      <li><a href="<%=request.getContextPath()%>/home" class="menu">🏠Home</a></li>
      <li><a href="<%=request.getContextPath()%>/favBook">❤️Favorite</a></li>
      <li><a href="<%=request.getContextPath()%>/loginBookShelf"
					>📚BookShelf</a></li>
      <li><a href="#">🔗Contact</a></li>
      <li><button type="button" class="logout">🚪LogOut</button></li>
      </div>
		<div id="modal" class="modal">
			<div class="modal-content">
				<p>ログアウトしますか？</p>
				<div class="modal--btn__block">
					<a id="cancel">いいえ</a> <a href="<%=request.getContextPath()%>/"
						id="ok">はい</a>
				</div>
			</div>
		</div>
    </ul>
  </nav>
<script>

//ドロワー機能
const toggler = document.querySelector(".toggle");

window.addEventListener("click", event => {
  if(event.target.className == "toggle" || event.target.className == "toggle") {
    document.body.classList.toggle("show-nav");
    document.getElementById("deleteconpo").classList.toggle("deleteclass")
  } else if (event.target.className == "overlay") {
    document.body.classList.remove("show-nav");
document.getElementById("deleteconpo").classList.toggle("deleteclass")
  }

});

//ドロワーのメニューをクリックしたら非表示
const hrefLink = document.querySelectorAll('.linkList li a');
for (i = 0; i < hrefLink.length; i++) {
hrefLink[i].addEventListener("click", () => {
document.body.classList.remove("show-nav");
document.getElementById("deleteconpo").classList.toggle("deleteclass")
});
}
 
//本棚に追加
function shelf(){
    console.log("10");
    const arr = [];
    let aaa=0;
    const chk1 = document.getElementsByName("bookShelf");
       console.log(chk1);
    for (let i = 0; i < chk1.length; i++) {
      if (chk1[i].checked) {
       console.log(chk1[i].value+" "+i);
           arr.push(chk1[i].value); 
      }
    }
  
         var status = new XMLHttpRequest();
      
             status.open('POST',"http://localhost:8080/SeattleLibrary/addShelf?bookId="+arr+"");
             status.send();  
    
}

//ラジオボタン
window.onload = function radio_func(check,id) {
    var status = new XMLHttpRequest();
      status.open('POST',"http://localhost:8080/SeattleLibrary/readStatus?value="+check+"&bookId="+id+"");
       status.send();
}




//ラジオボタンへのid付与
window.onload = function(){
	let unread = document.getElementsByClassName('unread');
	let label_unread = document.getElementsByClassName('label_unread');
	for(let i =0;i<unread.length;i++){
		var val = 'unread'+(i+1);
		unread[i].setAttribute("id",val);
		label_unread[i].setAttribute("for",val);
	}

	let read = document.getElementsByClassName('read');
	let label_read = document.getElementsByClassName('label_read');
	for(let i =0;i<read.length;i++){
		var val = 'read'+(i+1);
		read[i].setAttribute("id",val);
		label_read[i].setAttribute("for",val);
	}

	let reading = document.getElementsByClassName('reading');
	let label_reading = document.getElementsByClassName('label_reading');
	for(let i =0;i<reading.length;i++){
		var val = 'reading'+(i+1);
		reading[i].setAttribute("id",val);
		label_reading[i].setAttribute("for",val);
	}
};

//ロードが完了したらイベント開始
window.addEventListener('load', (event) => {
// モーダルやボタンの定義
const modal = document.getElementById('modal');
const okButton = document.getElementById('ok');
const cancelButton = document.getElementById('cancel');
const links = document.querySelectorAll('.logout');
let targetHref;

// モーダル表示の関数定義
function showModal(event) {
  // イベントに対するデフォルトの動作を止める
  event.preventDefault();
  targetHref = event.currentTarget.href;
  // モーダルをblockに変えて表示
  modal.style.display = 'block';
  }

// モーダル非表示の関数定義
function hideModal() {
  modal.style.display = 'none';
  }

// OKボタンがクリックされたら
okButton.addEventListener('click', () => {
  window.location.href = targetHref;
});

// キャンセルボタンがクリックされたら
cancelButton.addEventListener('click', hideModal);
  modal.addEventListener('click', (event) => {
    if (event.target === modal) {
    hideModal();
    }
  });

  links.forEach(link => {
    link.addEventListener('click', showModal);
});
});

//タグの名前を取得し、重複を除いた配列を作成
window.onload = function() {
	var select = document.getElementsByClassName('book_tag');

	const setList = new Set();
	
	for(let i =0;i<select.length;i++){
		setList.add(select[i].textContent.substr(3));
		}	
	
	//Tag名が格納された配列をまわす
	for(let set of setList){
		let element = document.getElementById('tagName');

		element.insertAdjacentHTML('beforeend', '<option>'+set+'</option>');

	}

} 

	//選択されたタグをコントローラーに送る
function selection(){ 
	
	let obj = document.getElementById("tagName");
	let idx = obj.selectedIndex;
	var getText = obj.options[idx].text;
	console.log(getText);  

	var form = document.createElement('form');
	form.action = 'http://localhost:8080/SeattleLibrary/selectTag';
    form.method = 'POST';

    var q = document.createElement('input');
    q.value = getText;
    q.name = 'getText';

    form.appendChild(q);
    document.body.appendChild(form);

    form.submit();

} 

</script>
	<header>
		<div class="left">
			<img class="mark" src="resources/img/logo.png" />
			<div class="logo">Seattle Library</div>
		</div>
	</header>
	<main>
		<h1>Home</h1>
		<form action="search" class="search-form-008">
			<label> <input type="text" name="search"
				placeholder="タイトル名かタグ名を入力">
			</label>
			<button type="submit" aria-label="検索" class="search-form-008 button"></button>
		</form>
		<div>
			<div>
				<a href="<%=request.getContextPath()%>/addBook" class="btn_add_book">書籍の追加</a>
			</div>
			<div class="btn_shelf">
			 <input type="button" form="form1"
					class="btn_addShelf_book" value="本棚に追加" onclick="shelf()">
			</div>
		</div>
		<select id="tagName" onchange="selection()">
			<option value="">タグを選択</option>
		</select>
		<div class="content_body">
			<c:if test="${!empty resultMessage}">
				<div class="error_msg">${resultMessage}</div>
			</c:if>
			<div>
				<div class="booklist">
					<c:forEach var="bookInfo" items="${bookList}">
						<div class="books">
							<div>
								<form method="post" name="form1" id="form1" class="shelfCheck"
									action="addShelf">
									<input type="checkbox" name="bookShelf"
										value="${bookInfo.bookId}" id="shelfBtn">📚
								</form>
							</div>
							<li class="book_title">${bookInfo.title}</li>
							<form method="get" class="book_thumnail" action="editBook">
								<a href="javascript:void(0)" onclick="this.parentNode.submit();">
									<c:if test="${empty bookInfo.thumbnail}">
										<img class="book_noimg" src="resources/img/noImg.png">
									</c:if> <c:if test="${!empty bookInfo.thumbnail}">
										<img class="book_noimg" src="${bookInfo.thumbnail}">
									</c:if>
								</a> <input type="hidden" name="bookId" value="${bookInfo.bookId}">
							</form>
							<ul>
								<li class="book_author">${bookInfo.author}(著)</li>
								<li class="book_publisher">出版社：${bookInfo.publisher}</li>
								<li class="book_publish_date">出版日：${bookInfo.publishDate}</li>
								<li class="book_tag">タグ：${bookInfo.tag}</li>
							</ul>
							<div class="likeBtn">
								<c:if test="${!(bookInfo.favorite.equals('like'))}">
									<form method="GET" action="favorite" name="favorite">
										<button class="button-064">お気に入り</button>
										<input type="hidden" name="bookId" value="${bookInfo.bookId}">
									</form>
								</c:if>
								<c:if test="${bookInfo.favorite.equals('like')}">
									<form method="GET" action="unlike" name="nonFavorite">
										<button class="button-064">お気に入り解除</button>
										<input type="hidden" name="bookId" value="${bookInfo.bookId}">
									</form>
								</c:if>
							</div>
								<c:if test="${bookInfo.status == NULL}">
									<div style="display: grid; gap: 20px; padding-top: 8px;">
										<div>
											<input class="radio_btn unread" type="radio"
												name="site${bookInfo.bookId}" value="1"
												onchange="radio_func(this.value,${bookInfo.bookId})" checked>
											<label class="label_unread"></label>
											<p class="status">未読</p>
										</div>
										<div>
											<input class="radio_btn reading" type="radio"
												name="site${bookInfo.bookId}" value="2"
												onchange="radio_func(this.value,${bookInfo.bookId})">
											<label class="label_reading"></label>
											<p class="status">読書中</p>
										</div>
										<div>
											<input class="radio_btn read" id="read" type="radio"
												name="site${bookInfo.bookId}" value="3"
												onchange="radio_func(this.value,${bookInfo.bookId})">
											<label class="label_read"></label>
											<p class="status">読了</p>
										</div>
									</div>
								</c:if>
								<c:if test="${bookInfo.status.equals('1')}">
									<div style="display: grid; gap: 20px; padding-top: 8px;">
										<div>
											<input class="radio_btn unread" type="radio"
												name="site${bookInfo.bookId}" value="1"
												onchange="radio_func(this.value,${bookInfo.bookId})" checked>
											<label class="label_unread"></label>
											<p class="status">未読</p>
										</div>
										<div>
											<input class="radio_btn reading" type="radio"
												name="site${bookInfo.bookId}" value="2"
												onchange="radio_func(this.value,${bookInfo.bookId})">
											<label class="label_reading"></label>
											<p class="status">読書中</p>
										</div>
										<div>
											<input class="radio_btn read" type="radio"
												name="site${bookInfo.bookId}" value="3"
												onchange="radio_func(this.value,${bookInfo.bookId})">
											<label class="label_read"></label>
											<p class="status">読了</p>
										</div>
									</div>
								</c:if>
							<c:if test="${bookInfo.status.equals('2')}">
								<div style="display: grid; gap: 20px; padding-top: 8px;">
									<div>
										<input class="radio_btn unread" type="radio"
											name="site${bookInfo.bookId}" value="1"
											onchange="radio_func(this.value,${bookInfo.bookId})">
										<label class="label_unread"></label>
										<p class="status">未読</p>
									</div>
									<div>
										<input class="radio_btn reading" type="radio"
											name="site${bookInfo.bookId}" value="2"
											onchange="radio_func(this.value,${bookInfo.bookId})" checked>
										<label class="label_reading"></label>
										<p class="status">読書中</p>
									</div>
									<div>
										<input class="radio_btn read" type="radio"
											name="site${bookInfo.bookId}" value="3"
											onchange="radio_func(this.value,${bookInfo.bookId})">
										<label class="label_read"></label>
										<p class="status">読了</p>
									</div>
								</div>
							</c:if>
							<c:if test="${bookInfo.status.equals('3')}">
								<div style="display: grid; gap: 20px; padding-top: 8px;">
									<div>
										<input class="radio_btn unread" type="radio"
											name="site${bookInfo.bookId}" value="1"
											onchange="radio_func(this.value,${bookInfo.bookId})">
										<label class="label_unread"></label>
										<p class="status">未読</p>
									</div>
									<div>
										<input class="radio_btn reading" type="radio"
											name="site${bookInfo.bookId}" value="2"
											onchange="radio_func(this.value,${bookInfo.bookId})">
										<label class="label_reading"></label>
										<p class="status">読書中</p>
									</div>
									<div>
										<input class="radio_btn read" type="radio"
											name="site${bookInfo.bookId}" value="3"
											onchange="radio_func(this.value,${bookInfo.bookId})" checked>
										<label class="label_read"></label>
										<p class="status">読了</p>
									</div>
								</div>
							</c:if>
							<input type="button" onclick="location.href='https://www.amazon.co.jp/s?k=${bookInfo.title}&ref=nb_sb_noss'" value="Amazonで見る">
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</main>
</body>
</html>
