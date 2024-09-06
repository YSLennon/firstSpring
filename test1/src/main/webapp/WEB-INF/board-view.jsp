<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<jsp:include page="/layout/menu.jsp"></jsp:include>
	<title>첫번째 페이지</title>

	<!-- Quill CDN -->
    <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
    <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
</head>
<style>
#editor{
	height: 300px;
}
#title{
	height: 20px;
	width: 90%;
}
</style>
<body>

	<div id="app">
		
		<table>
			<tr>
				<th>제목</th>
				<td><div>{{title}}</div></td>
				<td><button type="button" @click="fnRemove()">삭제</button></td>
				<td>작성자: {{userId}}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>				
					<div>
						<div>contents</div>
					</div>
				</td>
			</tr>
		</table>
			
	</div>
					

</body>
</html>
<script>
	const app = Vue.createApp({
	      data() {
	          return {
				title : "",
				contents : "",
				userId:'',
				boardNo: '${boardNo}',
				mode: '1'
	          };
	      },
	      methods: {
			fnChange(){
				var self = this;
				self.mode ='2';
			}
			,
		  	fnGetView(){
	  			var self = this;
	  			var nparmap = {boardNo : self.boardNo};
	  			$.ajax({
	  				url:"/board/view.dox",
	  				dataType:"json",	
	  				type : "POST", 
	  				data : nparmap,
	  				success : function(data) {
	  					console.log(data); 
						self.title = data.board.title;
						self.contents = data.board.contents;
						self.userId = data.board.userId;
	  				}
	  			});
	  		},		  
			fnRemove(){
				var self = this;
  				if(confirm("삭제허실?")){
  				var self = this;
  				var nparmap = {boardNo : self.boardNo, userId : self.userId};
  				$.ajax({
  					url:"/board/remove.dox",
  					dataType:"json",	
  					type : "POST", 
  					data : nparmap,
  					success : function(data) {
  						alert(data.message); 
						if(data.result){
							location.href="/board/list.do";	
						}
  						
  					}
  				});
  					
  				}
  				
  			}
	   },
	      mounted() {
			var self = this;
			self.fnGetView()
			
	      }
	  });
	  app.mount('#app');
</script>