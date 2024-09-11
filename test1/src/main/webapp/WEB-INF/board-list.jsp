<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<jsp:include page="/layout/menu.jsp"></jsp:include>
	<link rel="stylesheet" href="http://localhost:8080/css/style.css">

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
			<select v-model="pageSize" @change="fnGetList(1)">
				<option value="5">5개씩</option>	
				<option value="10">10개씩</option>	
				<option value="20">20개씩</option>	
			</select>
			<input id="searchBox" v-model="keyword">
			<button @click="fnGetList(1)">검색</button>	
			<a href='/board/insert.do'>글쓰기</a>
		</div>
		<table>
			<tr>
				<th>몰</th>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>작성일</th>
				<th>삭제</th>
			</tr>
			<tr v-for="item in boardList">
				<td><input type="checkbox" :value="item.boardNo" v-model="checkBox"></td>
				<td>{{item.boardNo}}</td>
				<td><a href="#" @click="fnBoardView(item.boardNo)">{{item.title}} {{item.cnt}}</a></td>
				<td>{{item.userId}}</td>
				<td>{{item.hit}}</td>
				<td>{{item.resDate}}</td>
				<td><button type="button" @click="fnRemove(item.boardNo, item.userId)">삭제</button></td>
			</tr>
			<td><button type="button" @click="fnCheckRemove()">선택 삭제</button></td>
			{{checkBox}}
		</table>
		
		<div class="pagination">
		    <button v-if="currentPage > 1" @click="fnGetList(currentPage - 1)">이전</button>
		    <button v-for="page in totalPages" :class="{active: page == currentPage}" @click="fnGetList(page)">
		        {{ page }}
		    </button>
		    <button v-if="currentPage < totalPages" @click="fnGetList(currentPage + 1)">다음</button>
		</div>
		
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
				boardList : [],
				checkBox: [],
				keyword: "",
				category: "all",
				boardCat: "",
				sessionId: '${userId}',
				currentPage: 1,      
				pageSize: 5,        
				totalPages: 1
            };
        },
        methods: {
            fnGetList(currentPage){
				var self = this;
//				var nparmap = {keyword: self.keyword === "")?'%':'%'+self.keyword+'%'};
				var nparmap = {
								keyword: self.keyword,
								category: self.category,
								boardCat: self.boardCat,
								currentPage: (currentPage-1)*self.pageSize,
								pageSize: self.pageSize
							  };
				$.ajax({
					url:"/board/list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						self.totalPages = data.cntBoard; 
						self.boardList = data.list;
						self.currentPage = currentPage;
					}
				});
            },
			fnRemove(removedNo, userId){
				if(confirm("삭제허실?")){
				var self = this;
				var nparmap = {boardNo : removedNo, userId : userId};
				$.ajax({
					url:"/board/remove.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						alert(data.message); 
						if(data.result){
							self.fnGetList(self.currentPage);	
						} 
					}
				});
					
				}
				
			},
			changeBoardCat(p1){
				var self = this;
				self.boardCat = p1;
				self.fnGetList(self.currentPage);
			},
			fnBoardView(boardNo){
				// key : boardNo, value : 내가 누른 게시글의 boardNo(pk)
				$.pageChange("../board/view.do", {boardNo : boardNo});
			},
			fnCheckRemove(){
				var self = this;
				var nparmap = {
						checkBox: JSON.stringify(self.checkBox),
						testKey : "testValue"
					};

				$.ajax({
					url:"/board/fnCheckRemove.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						alert("지워졌어용");
						self.fnGetList(1);
					}
				});
			}
        },
        mounted() {
            var self = this;
			self.fnGetList(self.currentPage);
			document.querySelector('#searchBox').addEventListener("keydown", (event) => {
					if(event.key === 'Enter'){
						self.fnGetList(self.currentPage);
					}
				});
        }
    });
    app.mount('#app');
	
</script>