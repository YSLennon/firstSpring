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

		<table>
			<tr>
				<th>학번</th>
				<th>이름</th>
				<th>아이디</th>
				<th>학년</th>
				<th>주소</th>
			</tr>
			<tr v-for="item in schoolList">
				<td>{{item.stuNo}}</td>
				<td><a href="#" @click="goToDetailView(item.stuNo)">{{item.name}}</a></td>
				<td>{{item.id}}</td>
				<td>{{item.grade}}</td>
				<td>{{item.jumin}}</td>
			</tr>
		</table>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
				schoolList : [],
				
            };
        },
        methods: {
            fnGetList(){
				var self = this;
				var nparmap = {};
				$.ajax({
					url:"/school/list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						self.schoolList = data.list;

					}
				});
            },
			goToDetailView(stuNo){
				$.pageChange("../school/detail.do", {stuNo : stuNo});

            }
        },
        mounted() {
            var self = this;
			self.fnGetList();
        }
    });
    app.mount('#app');
	
</script>