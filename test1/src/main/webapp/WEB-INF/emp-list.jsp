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
	table, tr, td, th {
		border-collapse: collapse;
		border: 1px solid black;
		padding: 10px 20px;
	}
</style>
<body>
	<div id="app">
		
		<input type="checkbox" value ="10" v-model="deptList" @change="fnGetList()">ACCOUNTING
		<input type="checkbox" value ="20" v-model="deptList" @change="fnGetList()">RESEARCH
		<input type="checkbox" value ="30" v-model="deptList" @change="fnGetList()">SALES
		<input type="checkbox" value ="40" v-model="deptList" @change="fnGetList()">OPERATIONS

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
				list : {},
				deptList : []
            };
        },
        methods: {
            fnGetList(){
				var self = this;
				var nparmap = {deptList: JSON.stringify(self.deptList)};
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