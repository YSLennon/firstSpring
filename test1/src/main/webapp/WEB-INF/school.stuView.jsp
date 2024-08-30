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
				<th>학부</th>
				<th>학과</th>
				<th>담당교수</th>
			</tr>
			<tr>
				<td>{{stuNo}}</td>
				<td>{{name}}</td>
				<td>{{dept1}}</td>
				<td>{{dept2}}</td>
				<td>{{prof}}</td>
			</tr>
		</table>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
				schoolList : {},
				stuNo : '${stuNo}',
				name: '',
				dept1: '',
				dept2: '',
				prof: ''
            };
        },
        methods: {
            fnGetList(){
				var self = this;
				var nparmap = {stuNo : self.stuNo};
				$.ajax({
					url:"/school/view.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						self.name = data.list.name;
						self.dept1= data.list.dept1;
						self.dept2 = data.list.dept2;
						self.prof = data.list.prof;

					}
				});
            }
        },
        mounted() {
            var self = this;
			self.fnGetList();
        }
    });
    app.mount('#app');
	
</script>