<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<jsp:include page="/layout/menu.jsp"></jsp:include>
	<title>첫번째 페이지</title>
</head>
<style>
	table, tr, td, th{
		border-collapse: collapse;
		border: 1px solid black;
		padding: 5px 10px;
		margin: 100px auto;
	}
</style>
<body>

	<div id="app">
		<ul style="margin: 0px 500px;">
			<li><a href="#" @click="changeBoardCat('')">전체</a></li>
			<li><a href="#" @click="changeBoardCat('1')">공지사항</a></li>
			<li><a href="#" @click="changeBoardCat('2')">자유게시판</a></li>
			<li><a href="#" @click="changeBoardCat('3')">질문게시판</a></li>
		</ul>
		<div style="margin: 0px 500px;">
			<select v-model="category">
				<option value="all">전체</option>	
				<option value="org">작성자</option>	
				<option value="tit">제목</option>	
			</select>
			<input id="searchBox" v-model="keyword">
			<button @click="fnGetList">검색</button>	
		</div>
		<table>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>작성일</th>
				<th>삭제</th>
			</tr>
			<tr v-for="item in boardList">
				<td>{{item.boardNo}}</td>
				<td>{{item.title}}</td>
				<td>{{item.userId}}</td>
				<td>{{item.hit}}</td>
				<td>{{item.cDatetime}}</td>
				<td><button type="button" @click="fnRemove(item.boardNo)">삭제</button></td>
			</tr>
		</table>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
				boardList : [],
				keyword: "",
				category: "all",
				boardCat: ""
            };
        },
        methods: {
            fnGetList(){
				var self = this;
//				var nparmap = {keyword: self.keyword === "")?'%':'%'+self.keyword+'%'};
				var nparmap = {
								keyword: self.keyword,
								category: self.category,
								boardCat: self.boardCat
							  };
				$.ajax({
					url:"/board/list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						self.boardList = data.list;
					}
				});
            },
			fnRemove(removedNo){
				if(confirm("삭제허실?")){
				var self = this;
				var nparmap = {boardNo : removedNo};
				$.ajax({
					url:"/board/remove.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						alert(data.message); 
						if(data.result){
							self.fnGetList();	
						} 
					}
				});
					
				}
				
			},
			changeBoardCat(p1){
				var self = this;
				self.boardCat = p1;
				self.fnGetList();
			}
        },
        mounted() {
            var self = this;
			self.fnGetList();
			document.querySelector('#searchBox').addEventListener("keydown", (event) => {
					if(event.key === 'Enter'){
						self.fnGetList();
					}
				});
        }
    });
    app.mount('#app');
	
</script>