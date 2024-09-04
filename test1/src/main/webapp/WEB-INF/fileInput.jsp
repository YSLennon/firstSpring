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
<!--<body onload="init();">-->
<body>

	<div id="app">
		<input type="file" @change="fnFileChange"/>

	</div>
</body>
</html>
<script>

	
	const app = Vue.createApp({
	      data() {
	          return {
				areaSi : "",
				areaGu: "",
				areaDong: "",
				si : [],
				gu : [],
				dong : []
	          };
	      },
	      methods: {
			fnFileChange(event) {
				this.file = event.target.files[0];
			},
			fnSave (){
				var self = this;
				var nparam = {
					title : self.title, 
					contents : self.contents,
					userId : self.sessionId
					
				};
				$.ajax({
					url:"board-add.dox",
					dataType:"json",	
					type : "POST", 
					data : nparam,
					success : function(data) { 
						var idx = data.idx;
						console.log(idx);
						if (self.file) {
						  const formData = new FormData();
						  formData.append('file1', self.file);
						  formData.append('idx', idx);

						  $.ajax({
							url: '/fileUpload.dox',
							type: 'POST',
							data: formData,
							processData: false,  
							contentType: false,  
							success: function() {
							  console.log('업로드 성공!');
							},
							error: function(jqXHR, textStatus, errorThrown) {
							  console.error('업로드 실패!', textStatus, errorThrown);
							}
						  });
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
	  
	  //인정. 내가 졌다...

	
	  
</script>