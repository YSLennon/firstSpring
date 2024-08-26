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
			<input type="text" placeholder="제목" v-model="list.title">
		</div>
		<div>
			<textarea type="text" placeholder="내용" v-model="list.contents"></textarea>
		</div>
		<button @click="fnSave">저장</button>

</body>
</html>
<script>
	const app = Vue.createApp({
	      data() {
	          return {
				list : {
					title : "",
					contents : ""
				}
	          };
	      },
	      methods: {
			fnSave(){
				var self = this;
				var nparmap = {
					title : self.list.title,
					contents : self.list.contents
				};
				$.ajax({
					url:"/board/insert.dox",
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
	   },
	      mounted() {
			var self = this;
	      }
	  });
	  app.mount('#app');
</script>