<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<jsp:include page="/layout/menu.jsp"></jsp:include>
	<title>첫번째 페이지</title>

	<!-- Quill CDN -->
    <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
    <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
</head>
<style>
#editor{
	height: 300px;
}
#title{
	height: 20px;
	width: 90%;
}
</style>
<body>

	<div id="app">
		
		<table>
			<tr>
				<th>제목</th>
				<td><input id="title" v-model="title"><td>
			</tr>
			<tr>
				<th>내용</th>
				<td>				
					<div>
						<div id="editor"></div>
					</div>
				<td>
			</tr>
		</table>
		<button @click="fnSave">저장</button>
		<!--<div v-html="contents"></div>-->
			
		<input type="file" @change="fnFileChange"/>
	</div>
					

</body>
</html>
<script>
	const app = Vue.createApp({
	      data() {
	          return {
				title : "",
				contents : "",
				file : null
	          };
	      },
	      methods: {
			fnFileChange(event) {
				this.file = event.target.files[0];
			},
			fnSave(){
				var self = this;

				var nparmap = {
					title : self.title,
					contents : self.contents
				};
				$.ajax({
					url:"/board/insert.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						alert(data.message);
						if(data.result){
							var idx = data.idx;
							console.log("idx : " + idx);
							if (self.file) {
							  const formData = new FormData();
							  formData.append('file1', self.file);
							  formData.append('idx', idx);

							  $.ajax({
								url: '/board/fileUpload.dox',
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
					}
				});
       		}
	   },
	      mounted() {
			var self = this;
			// Quill 에디터 초기화
	        var quill = new Quill('#editor', {
	            theme: 'snow',
	            modules: {
	                toolbar: [
	                    [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
	                    ['bold', 'italic', 'underline'],
	                    [{ 'list': 'ordered'}, { 'list': 'bullet' }],
	                    ['link', 'image'],
	                    ['clean']
	                ]
	            }
	        });

	        // 에디터 내용이 변경될 때마다 Vue 데이터를 업데이트
	        quill.on('text-change', function() {
	            self.contents = quill.root.innerHTML;
	        });
	      }
	  });
	  app.mount('#app');
</script>