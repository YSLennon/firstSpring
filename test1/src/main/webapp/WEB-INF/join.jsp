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
			{{existedId}}
			<input id="userId" placeholder="userId" v-model="userId" @change="existedId = false">
			<button @click="duplicateExamination">중복확인</button>	
		</div>
		<div>
			<input type="password" placeholder="password" v-model="pwd">
		</div>
		<div>
			<input type="confirm password" placeholder="password" v-model="confirmPwd">
		</div>
		<div>
			<input placeholder="name" v-model="userName">
		</div>
		<div>
			<input placeholder="email" v-model="email">
		</div>
		<div>
			<input placeholder="phone" v-model="phone">
		</div>
		<div>
			<input placeholder="gender" v-model="gender">
		</div>
		<button type="button" @click="join">JoinIn<button>


	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
				userId: "",
				pwd: "",
				userName: "",
				email: "",
				phone: "",
				gender: "",
				confirmPwd: "",
				existedId: false
            };
        },
        methods: {
			duplicateExamination(){
				var self = this;
				var nparmap = {
						userId: self.userId
					};
				$.ajax({
					url:"/user/dupEx.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						if(data.result){
							alert("사용 가능한 ID입니다");
							self.existedId = true;
						}else {
							alert("이미 존재하는 ID입니다");
						}
						
					}
				});
            }
			,join(){
				var self = this;
				if(self.confirmPwd != self.pwd){
					alert("비밀번호가 일치하지 않습니다")
					return;
				}
				if(!self.existedId){
					alert("아이디 중복체크가 필요합니다")
					return;
				}
				var nparmap = {
						userId: self.suerId,
						pwd: self.pwd,
						userName: self.userName,
						email: self.email,
						phone: self.phone,
						gender: self.gender
					};
				$.ajax({
					url:"/user/join.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
							alert(data.message);
						if(data.result){
							location.href="/user.login.do"
						}
					}
				});	
            }
        },
        mounted() {
            var self = this;
			document.querySelector('#userId').addEventListener("keydown", (event) => {
					if(event.key === 'Enter'){
						self.duplicateExamination();
					}
			});
			
			
        }
    });
    app.mount('#app');
	
</script>