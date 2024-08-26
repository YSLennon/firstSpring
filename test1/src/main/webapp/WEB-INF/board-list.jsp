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
</style>
<body>

	<div id="app">
		<div>
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
				<td>{{item.Hit}}</td>
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
				keyword: ""
            };
        },
        methods: {
            fnGetList(){
				var self = this;
//				var nparmap = {keyword: self.keyword === "")?'%':'%'+self.keyword+'%'};
				var nparmap = {keyword: self.keyword};
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