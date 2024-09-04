<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<jsp:include page="/layout/menu.jsp"></jsp:include>
	<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
	<title>view 기본 세팅 파일</title>
</head>
<style>
</style>
<body>
	<div id="app">
		<input type="text" v-model="price">
		<button @click="fnPayment()">결제</button>
	</div>
</body>
</html>
<script>
	const rand = Math.random();
	const userCode = "imp03418626"; 
	IMP.init(userCode);
    const app = Vue.createApp({
        data() {
            return {
				price : null,
				merchantUid : rand
            };
        },
        methods: {
			fnPayment(){
				var self = this;		
				console.log("함수");		
				IMP.request_pay({
				    pg: "kakaopay.TC0ONETIME",
				    pay_method: "card",
				    merchant_uid: "test1",
				    name: "테스트 결제",
				    amount: self.price,
				    buyer_tel: "010-0000-0000",
				  }	, function (rsp) { // callback
			   	      if (rsp.success) {
			   	        // 결제 성공 시
						alert("성공");
						console.log(rsp);
						
			   	      } else {
						console.log(rsp);
						if(rsp.error_code === "F1002"){
							self.merchantUid = 1;
							self.fnPayment();
						}
			   	        // 결제 실패 시
						alert("실패");
			   	      }
		   	  	});
			}
        },
        mounted() {
			
        }
    });
    app.mount('#app');
</script>