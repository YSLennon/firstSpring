<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<jsp:include page="/layout/menu.jsp"></jsp:include>
	<link rel="stylesheet" href="http://localhost:8080/css/style.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
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
		<select v-model="pageSize" @change="fnGetList(1)">
			<option value="5">5개씩</option>	
			<option value="10">10개씩</option>	
			<option value="20">20개씩</option>	
		</select>
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
		<div class="pagination">

		    <button v-if="currentPage > 1" @click="fnGetList(currentPage - 1)">이전</button>
		    <button v-for="page in totalPages" :class="{active: page == currentPage}" @click="fnGetList(page)">
		        {{ page }}
		    </button>
		    <button v-if="currentPage < totalPages" @click="fnGetList(currentPage + 1)">다음</button>
			<i class="fa-brands fa-tiktok"></i>
			<span class="material-symbols-outlined">
			toggle_on
			</span>

		</div>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
				schoolList : [],
				currentPage: 1,
				totalPages: 1,
				pageSize: 5
				
            };
        },
        methods: {
            fnGetList(currentPage){
				var self = this;
				var nparmap = {currentPage: currentPage, pageSize: self.pageSize};
				$.ajax({
					url:"/school/list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						self.currentPage = currentPage;
						self.totalPages = data.cntSchool;
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
			self.fnGetList(self.currentPage);
        }
    });
    app.mount('#app');
	
</script>