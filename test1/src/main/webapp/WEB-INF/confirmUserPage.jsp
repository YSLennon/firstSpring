<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<jsp:include page="/layout/menu.jsp"></jsp:include>
	<title>view 기본 세팅 파일</title>
</head>
<style>
</style>
<body>
	<div id="app">
		<div v-if="confirmNumb === null">
			<input placeholder="핸드폰 번호를 입력해주세요(01012341234형태)" v-model="userPhone">
			<button @click='makeConfirmNumbAndSendMessage'>문자인증</button>
		</div>
		<div v-if="confirmNumb != null">
			<div>인증만료시간: {{timer}}</div>
			<input placeholder="인증번호를 입력해주세요" v-model="userInputNumb">
			<button @click='confirmInputNumb'>인증하기</button>
		</div>
	</div>
</body>
</html>
<script>
	var timeCheck;
    const app = Vue.createApp({
        data() {
            return {
				userPhone : null,
				confirmNumb : null,
				userInputNumb : null,
				timer:180
            };
        },
        methods: {
			makeConfirmNumbAndSendMessage(){
				var self = this;
				var nparmap = {userPhone : self.userPhone}
				$.ajax({
					url:"/user/confirm.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data.confirmNumb);
						alert("인증번호가 발신되었습니다. 핸드폰을 확인해주세요")
						self.confirmNumb = data.confirmNumb;
						
						timeCheck = setInterval(() => {
							if(self.timer === 0){
								alert("시간이 만료되었습니다")
								clearInterval(timeCheck);
								location.href="/user/confirm.do"
							}else {
								self.timer -= 1;	
							}
						}, 1000);
						
					}
				});
			},
			confirmInputNumb(){
				if(self.confirmNumb === self.userInputNumb){
					alert("인증되었습니다!");
				}else{
					alert("아닌디요?")
				}
				
			}
			
        },
        mounted() {
			
        }
    });
    app.mount('#app');
	
</script>