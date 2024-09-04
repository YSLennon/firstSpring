<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<jsp:include page="/layout/menu.jsp"></jsp:include>
	<title>첫번째 페이지</title>

	<!--주소 API-->
	<% 
		//request.setCharacterEncoding("UTF-8");  //한글깨지면 주석제거
		//request.setCharacterEncoding("EUC-KR");  //해당시스템의 인코딩타입이 EUC-KR일경우에
		String inputYn = request.getParameter("inputYn"); 
		String roadFullAddr = request.getParameter("roadFullAddr"); 
		String roadAddrPart1 = request.getParameter("roadAddrPart1"); 
		String roadAddrPart2 = request.getParameter("roadAddrPart2"); 
		String engAddr = request.getParameter("engAddr"); 
		String jibunAddr = request.getParameter("jibunAddr"); 
		String zipNo = request.getParameter("zipNo"); 
		String addrDetail = request.getParameter("addrDetail"); 
		String admCd    = request.getParameter("admCd");
		String rnMgtSn = request.getParameter("rnMgtSn");
		String bdMgtSn  = request.getParameter("bdMgtSn");
		String detBdNmList  = request.getParameter("detBdNmList");	
		/** 2017년 2월 추가제공 **/
		String bdNm  = request.getParameter("bdNm");
		String bdKdcd  = request.getParameter("bdKdcd");
		String siNm  = request.getParameter("siNm");
		String sggNm  = request.getParameter("sggNm");
		String emdNm  = request.getParameter("emdNm");
		String liNm  = request.getParameter("liNm");
		String rn  = request.getParameter("rn");
		String udrtYn  = request.getParameter("udrtYn");
		String buldMnnm  = request.getParameter("buldMnnm");
		String buldSlno  = request.getParameter("buldSlno");
		String mtYn  = request.getParameter("mtYn");
		String lnbrMnnm  = request.getParameter("lnbrMnnm");
		String lnbrSlno  = request.getParameter("lnbrSlno");
		/** 2017년 3월 추가제공 **/
		String emdNo  = request.getParameter("emdNo");
	%>
	<!---->
</head>
<style>

</style>
<!--<body onload="init();">-->
<body>

	<div id="app">
		<select id="si" v-model="areaSi" @change="fnGetArea('gu', areaSi)">
			<option value = "">::선택::</option>
			<option v-for="item in si" :value="item.si">{{item.si}}</option>
		</select>
		<select id="gu" v-model="areaGu" @change="fnGetArea('dong', areaGu)">
			<option value = "">::선택::</option>
			<option v-for="item in gu" :value="item.gu">{{item.gu}}</option>
		</select>
		<select id="dong" v-model="areaDong">
			<option value = "">::선택::</option>
			<option v-for="item in dong" :value="item.dong">{{item.dong}}</option>
		</select>


		<input type="text" > <button onclick="fnPopup()">hello</button>

			<form id="form" name="form" method="post" target="popupName">
				<input type="hidden" id="confmKey" name="confmKey" value=""/>
				<input type="hidden" id="returnUrl" name="returnUrl" value=""/>
				<input type="hidden" id="resultType" name="resultType" value=""/>
<!--				 해당시스템의 인코딩타입이 EUC-KR일경우에만 추가 START
				 
				<input type="hidden" id="encodingType" name="encodingType" value="EUC-KR"/>
				 
				 해당시스템의 인코딩타입이 EUC-KR일경우에만 추가 END-->
				 

				 <div id="list"></div>
				 <div id="callBackDiv">
				 	<table>
				 		<tr><td>도로명주소 전체(포멧)</td><td><input type="text"  style="width:500px;" id="roadFullAddr"  name="roadFullAddr" /></td></tr>
				 		<tr><td>도로명주소           </td><td><input type="text"  style="width:500px;" id="roadAddrPart1"  name="roadAddrPart1" /></td></tr>
				 		<tr><td>고객입력 상세주소    </td><td><input type="text"  style="width:500px;" id="addrDetail"  name="addrDetail" /></td></tr>
				 		<tr><td>참고주소             </td><td><input type="text"  style="width:500px;" id="roadAddrPart2"  name="roadAddrPart2" /></td></tr>
				 		<tr><td>영문 도로명주소      </td><td><input type="text"  style="width:500px;" id="engAddr"  name="engAddr" /></td></tr>
				 		<tr><td>지번                 </td><td><input type="text"  style="width:500px;" id="jibunAddr"  name="jibunAddr" /></td></tr>
				 		<tr><td>우편번호             </td><td><input type="text"  style="width:500px;" id="zipNo"  name="zipNo" /></td></tr>
				 		<tr><td>행정구역코드        </td><td><input type="text"  style="width:500px;" id="admCd"  name="admCd" /></td></tr>
				 		<tr><td>도로명코드          </td><td><input type="text"  style="width:500px;" id="rnMgtSn"  name="rnMgtSn" /></td></tr>
				 		<tr><td>건물관리번호        </td><td><input type="text"  style="width:500px;" id="bdMgtSn"  name="bdMgtSn" /></td></tr>
				 		<tr><td>상세번물명        	</td><td><input type="text"  style="width:500px;" id="detBdNmList"  name="detBdNmList" /></td></tr>
				 		<tr><td>건물명        		</td><td><input type="text"  style="width:500px;" id="bdNm"  name="bdNm" /></td></tr>
				 		<tr><td>공동주택여부       </td><td><input type="text"  style="width:500px;" id="bdKdcd"  name="bdKdcd" /></td></tr>
				 		<tr><td>시도명        		</td><td><input type="text"  style="width:500px;" id="siNm"  name="siNm" /></td></tr>
				 		<tr><td>시군구명        	</td><td><input type="text"  style="width:500px;" id="sggNm"  name="sggNm" /></td></tr>
				 		<tr><td>읍면동명        	</td><td><input type="text"  style="width:500px;" id="emdNm"  name="emdNm" /></td></tr>
				 		<tr><td>법정리명        	</td><td><input type="text"  style="width:500px;" id="liNm"  name="liNm" /></td></tr>
				 		<tr><td>도로명        		</td><td><input type="text"  style="width:500px;" id="rn"  name="rn" /></td></tr>
				 		<tr><td>지하여부        	</td><td><input type="text"  style="width:500px;" id="udrtYn"  name="udrtYn" /></td></tr>
				 		<tr><td>건물본번        	</td><td><input type="text"  style="width:500px;" id="buldMnnm"  name="buldMnnm" /></td></tr>
				 		<tr><td>건물부번        	</td><td><input type="text"  style="width:500px;" id="buldSlno"  name="buldSlno" /></td></tr>
				 		<tr><td>산여부        		</td><td><input type="text"  style="width:500px;" id="mtYn"  name="mtYn" /></td></tr>
				 		<tr><td>지번본번(번지)     </td><td><input type="text"  style="width:500px;" id="lnbrMnnm"  name="lnbrMnnm" /></td></tr>
				 		<tr><td>지번부번(호)       </td><td><input type="text"  style="width:500px;" id="lnbrSlno"  name="lnbrSlno" /></td></tr>
				 		<tr><td>읍면동일련번호       </td><td><input type="text"  style="width:500px;" id="emdNo"  name="emdNo" /></td></tr>
				 	</table>
				 </div>

			</form>
			
		
	</div>
</body>
</html>
<script>


	// opener관련 오류가 발생하는 경우 아래 주석을 해지하고, 사용자의 도메인정보를 입력합니다. ("주소입력화면 소스"도 동일하게 적용시켜야 합니다.)
	//document.domain = "abc.go.kr";

	/*
			모의 해킹 테스트 시 팝업API를 호출하시면 IP가 차단 될 수 있습니다. 
			주소팝업API를 제외하시고 테스트 하시기 바랍니다.
	*/
	function init(){
		  	var url = location.href;
		  	var confmKey = "devU01TX0FVVEgyMDI0MDkwNDEwMjk0NzExNTA1NzE=";
		  	var resultType = "4"; // 도로명주소 검색결과 화면 출력내용, 1 : 도로명, 2 : 도로명+지번+상세보기(관련지번, 관할주민센터), 3 : 도로명+상세보기(상세건물명), 4 : 도로명+지번+상세보기(관련지번, 관할주민센터, 상세건물명)
		  	var inputYn= "<%=inputYn%>";
		  	if(inputYn != "Y"){
		  		document.form.confmKey.value = confmKey;
		  		document.form.returnUrl.value = url;
		  		document.form.resultType.value = resultType;
		  		document.form.action="https://business.juso.go.kr/addrlink/addrLinkUrl.do"; //인터넷망
		  		//document.form.action="https://business.juso.go.kr/addrlink/addrMobileLinkUrl.do"; //모바일 웹인 경우, 인터넷망
		  		document.form.submit();
		  	}else{
		  		opener.jusoCallBack("<%=roadFullAddr%>","<%=roadAddrPart1%>","<%=addrDetail%>","<%=roadAddrPart2%>","<%=engAddr%>","<%=jibunAddr%>","<%=zipNo%>", "<%=admCd%>", "<%=rnMgtSn%>", "<%=bdMgtSn%>", "<%=detBdNmList%>", "<%=bdNm%>", "<%=bdKdcd%>", "<%=siNm%>", "<%=sggNm%>", "<%=emdNm%>", "<%=liNm%>", "<%=rn%>", "<%=udrtYn%>", "<%=buldMnnm%>", "<%=buldSlno%>", "<%=mtYn%>", "<%=lnbrMnnm%>", "<%=lnbrSlno%>", "<%=emdNo%>");
		  		window.close();
		  		}
		  }

	
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
			fnGetArea(category, area){
				var self = this;
				if (self.areaSi ==""){
					self.gu = [];
					self.areaGu = "";
					self.dong = [];
					self.areaDong= "";
				}
				if (self.areaGu ==""){
					self.dong = [];
					self.areaDong= "";
				}
				var nparmap = {
					category : category,
					area : area,
					areaSi : self.areaSi,
					areaGu: self.areaGu,
					areaDong: self.areaDong
				};
				$.ajax({
					url:"/area.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						if(self.areaSi === ''){
							self.si = data.list;
						} else if(self.areaGu === ''){
							self.gu = data.list;
						} else if(self.areaDong === ''){
							self.dong = data.list;
						}
						console.log(si);
					}
				});
	       }
	   },
	      mounted() {
			var self = this;
			self.fnGetArea('si','');
	      }
	  });
	  app.mount('#app');
	  
	  //인정. 내가 졌다...

	  function fnPopup(){
		var win = window.open('', "popupName" , 'height =300 width = 300')
		win.document.open();
		win.document.write("<html><body><p>팝업이 열렸습니다.</p><script> if (window.opener && typeof window.opener.init === 'function')  { window.opener.init(); } <\/script><\/body><\/html>");
		win.document.close();
	  }
	  
	  function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
	  	  		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
	  			alert("hi");
	  			console.log(roadFullAddr);
	  	  		document.form.roadFullAddr.value = roadFullAddr;
	  	  		document.form.roadAddrPart1.value = roadAddrPart1;
	  	  		document.form.roadAddrPart2.value = roadAddrPart2;
	  	  		document.form.addrDetail.value = addrDetail;
	  	  		document.form.engAddr.value = engAddr;
	  	  		document.form.jibunAddr.value = jibunAddr;
	  	  		document.form.zipNo.value = zipNo;
	  	  		document.form.admCd.value = admCd;
	  	  		document.form.rnMgtSn.value = rnMgtSn;
	  	  		document.form.bdMgtSn.value = bdMgtSn;
	  	  		document.form.detBdNmList.value = detBdNmList;
	  	  		/** 2017년 2월 추가제공 **/
	  	  		document.form.bdNm.value = bdNm;
	  	  		document.form.bdKdcd.value = bdKdcd;
	  	  		document.form.siNm.value = siNm;
	  	  		document.form.sggNm.value = sggNm;
	  	  		document.form.emdNm.value = emdNm;
	  	  		document.form.liNm.value = liNm;
	  	  		document.form.rn.value = rn;
	  	  		document.form.udrtYn.value = udrtYn;
	  	  		document.form.buldMnnm.value = buldMnnm;
	  	  		document.form.buldSlno.value = buldSlno;
	  	  		document.form.mtYn.value = mtYn;
	  	  		document.form.lnbrMnnm.value = lnbrMnnm;
	  	  		document.form.lnbrSlno.value = lnbrSlno;
	  	  		/** 2017년 3월 추가제공 **/
	  	  		document.form.emdNo.value = emdNo;
	  	  		
	  	  }
	  
</script>