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
		<table>
		<tr v-for="item in list">
			<td>{{item.empNo}}</td>	
			<td>{{item.eName}}</td>	
			<td>{{item.job}}</td>	
			<td>{{item.mgr}}</td>	
			<td>{{item.hiredate}}</td>	
			<td>{{item.sal}}</td>	
			<td>{{item.comm}}</td>	
			<td>{{item.deptNo}}</td>	
		</tr>	
		</table>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                name : "",
				list : {}
            };
        },
        methods: {
            fnGetList(){
				var self = this;
				var nparmap = {};
				$.ajax({
					url:"empList.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						self.list = data;
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
​