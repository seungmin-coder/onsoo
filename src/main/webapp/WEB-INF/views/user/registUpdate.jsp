<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>onsoo 회원가입</title>

<!--다음 api 주소 같이 있어야 사용가능   -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
function sample6_execDaumPostcode() {
   new daum.Postcode({
       oncomplete: function(data) {
           // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

           // 각 주소의 노출 규칙에 따라 주소를 조합한다.
           // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
           var addr = ''; // 주소 변수
           var extraAddr = ''; // 참고항목 변수

           //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
           if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
               addr = data.roadAddress;
           } else { // 사용자가 지번 주소를 선택했을 경우(J)
               addr = data.jibunAddress;
           }

           // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
           if(data.userSelectedType === 'R'){
               // 법정동명이 있을 경우 추가한다. (법정리는 제외)
               // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
               if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                   extraAddr += data.bname;
               }
               // 건물명이 있고, 공동주택일 경우 추가한다.
               if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
               }
               // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
               if(extraAddr !== ''){
                   extraAddr = ' (' + extraAddr + ')';
               }
               // 조합된 참고항목을 해당 필드에 넣는다.
              
           }
           // 우편번호와 주소 정보를 해당 필드에 넣는다.
           document.getElementById('sample6_postcode').value = data.zonecode;
           document.getElementById("sample6_address").value = addr;
           // 커서를 상세주소 필드로 이동한다.
           document.getElementById("sample6_detailAddress").focus();
       }
   }).open();
}
	
</script>	
<!-- <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="resources/js/registForm.js">
</script> -->
</head>
<link href="${pageContext.request.contextPath}/resources/css/registform.css" rel="stylesheet" >
<body>
<!-- header -->
	<header id="header">
		<%@ include file="/WEB-INF/views/header.jsp"%>
	</header>

<section id="content">


	<fieldset id="registform">
		<legend><h3>OnSoo: 개인정보 수정 페이지</h3></legend>
		<c:url value="/user/registUpdate.do" var="addUserUrl" />
		<form:form action="${addUserUrl}" method="POST">
			<table>
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" name="member_id" id="memberid"  readonly="readonly"  value="${dto.member_id }"  >
					</td>
				</tr>
				</br>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" id="password1" name="member_pw" placeholder="비밀번호 입력해주세요"  required="required"  maxlength="15"></td>
						<br>					
				</tr>
				<tr>
					<th>비밀번호확인</th>
					<td>
					<input type="password" id="password2" placeholder="비밀번호 확인해주세요" maxlength="15"  required="required" name="password3" >
						<br>					
					</td>
					<td>
						<span id="s_result" style="color:red">비밀번호가 일치하지 않습니다.</span>	
					<td>	
				</tr>
				<tr>
					<th>이름</th>
					<td>
					<input type="text" name="member_name"  required="required" readonly="readonly" value="${dto.member_name}" >
					<br>
					</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td>
					<input type="date" name="member_birth"  required="required"  value="${dto.member_birth }" id="member_birth" >
						<br>
					</td>
				</tr>
				<tr>
					<th>핸드폰번호</th>
					<td>
					<input type="text"  name="member_phone" maxlength="13" value="${dto.member_phone }" style="text-align:center;" required="required" />
					</td>
					
				</tr>
					<br>
				<tr>
					<th>이메일</th>
					<td>
					<input type="text" name="member_email" id="memberemail" value="${dto.member_email}"  required="required" >
					<input type="button" id="email" onclick="" value="중복확인" >
						<br>
					</td>
				</tr>
				<tr>		
					<th class="text-center">주소</th>
						<td>
						<input type="text" id="sample6_postcode" class="addr1" name="member_addr" value="${addr }" placeholder="우편번호" readonly="readonly">
						<input class="btn btn-secondary btn-sm" type="button" onclick="sample6_execDaumPostcode();"    id="daumaddr" value="우편번호 찾기" >
						<br>
						<input type="text" id="sample6_address"  value="${addr1}" class="addr1" name="member_addr" placeholder="주소" readonly="readonly"><br>
						<input type="text" id="sample6_detailAddress"  value="${addr2 }" class="addr1" name="member_addr" placeholder="상세주소" required="required">
						</td>
				</tr>
				<tr>
					<td><button type="submit" id="submit" >회원정보수정</button></td>
					<td><a href="<c:url value="/main.do" />">취소</a></td>
				</tr>
			</table>			
		</form:form>
	</fieldset>

</section>


		<!-- footer -->
	<footer id="footerarea" class="area">
		<%@ include file="/WEB-INF/views/footer.jsp"%>
	</footer>
		
	
	

</body>
</html>