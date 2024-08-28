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
			<input id="userId" placeholder="userId" v-model="userId" @change="existedId = false">
		</div>
		<div>
			<input id="pwd" type="password" placeholder="password" v-model="pwd">
		</div>
		<button type="button" @click="login">login<button>


	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
				userId: "",
				pwd: ""
            };
        },
        methods: {
			login(){
				var self = this;
				var nparmap = {
						userId: self.userId,
						pwd: self.pwd
					};
				$.ajax({
					url:"/user/login.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						alert(data.message);
						if(data.result){
							location.href="/student.do"
						}
					}
				});	
            }
        },
        mounted() {
            var self = this;
			document.querySelector('#pwd').addEventListener("keydown", (event) => {
					if(event.key === 'Enter'){
						self.login();
					}
			});
			
			
        }
    });
    app.mount('#app');
	
</script>