<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page session="true" %>
<c:set var="loginId" value="${sessionScope.id}" />
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}" />
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'ID='+=loginId}" />
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>BoardView</title>
    <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/board.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div id="menu">
    <ul class="menu-container">
        <li id="logo">juwonKim</li>
        <li><a href="<c:url value='/'/>">Home</a></li>
        <li><a href="<c:url value='/board/list'/>">Board</a></li>
        <li><a href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
        <li><a href="<c:url value='/register/add'/>">Sign in</a></li>
        <li><a href=""><i class="fa fa-search"></i></a></li>
    </ul>
</div>
<script>
    let msg = "${msg}";
    if (msg == "WRT_ERR") alert("게시물 등록에 실패하였습니다. 다시 시도해 주세요.");
    if (msg == "MOD_ERR") alert("게시물 수정에 실패하였습니다. 다시 시도해 주세요.");
</script>
<div class="container">
    <h2 class="writing-header">게시판 ${mode=="new" ? "글쓰기" : "읽기"}</h2>
    <form id="form" class="frm" action="" method="post">
        <input type="hidden" name="bno" id="bno" value="${boardDto.bno}">

        <input name="title" type="text" value="<c:out value='${boardDto.title}'/>"
               placeholder="  제목을 입력해 주세요." ${mode=="new" ? "" : "readonly='readonly'" }><br>
        <textarea name="content" rows="20" placeholder=" 내용을 입력해 주세요." ${mode=="new" ? ""
                : "readonly='readonly'" }><c:out value="${boardDto.content}"/></textarea><br>

        <c:if test="${mode eq 'new'}">
            <button type="button" id="writeBtn" class="btn btn-write"><i class="fa fa-pencil"></i>
                등록</button>
        </c:if>
        <c:if test="${mode ne 'new'}">
            <button type="button" id="writeNewBtn" class="btn btn-write"><i class="fa fa-pencil"></i>
                글쓰기</button>
        </c:if>
        <c:if test="${boardDto.writer eq loginId}">
            <button type="button" id="modifyBtn" class="btn btn-modify"><i class="fa fa-edit"></i>
                수정</button>
            <button type="button" id="removeBtn" class="btn btn-remove"><i class="fa fa-trash"></i>
                삭제</button>
        </c:if>
        <button type="button" id="listBtn" class="btn btn-list"><i class="fa fa-bars"></i> 목록</button>
    </form>
</div>

<!-- 댓글 시작 -->
<div id="commentList" ${mode=="new" ? "style='display:none;'" : "style='display:block;'"}>
    <ul class="comment-container">
        <%--        <li class="comment-item" data-cno="${list.cno}" data-bno="${list.bno}">--%>
        <%--            <span class="comment-img"><i class="fa fa-user-circle" aria-hidden="true"></i></span>--%>
        <%--            <div class="comment-area">--%>
        <%--                <div class="commenter">${list.commenter}</div>--%>
        <%--                <div class="comment-content">${list.comment}</div>--%>
        <%--                <div class="comment-bottom">--%>
        <%--                    <c:choose>--%>
        <%--                        <c:when test="${list.reg_date.time >= startOfToday}">--%>
        <%--                            <span class="up_date"><fmt:formatDate value="${list.reg_date}" pattern="HH:mm" type="time"/></span>--%>
        <%--                        </c:when>--%>
        <%--                        <c:otherwise>--%>
        <%--                            <span class="up_date"><fmt:formatDate value="${list.reg_date}" pattern="yyyy-MM-dd" type="date"/></span>--%>
        <%--                        </c:otherwise>--%>
        <%--                    </c:choose>--%>
        <%--                    <button class="btn-write" data-cno="${list.cno}" data-bno="${list.bno}" data-pcno="${list.pcno}">답글쓰기</button>--%>
        <%--                    <button class="btn-modify" data-cno="${list.cno}" data-bno="${list.bno}" data-pcno="${list.pcno}">수정</button>--%>
        <%--                    <button class="btn-delete" data-cno="${list.cno}" data-bno="${list.bno}" data-pcno="${list.pcno}">삭제</button>--%>
        <%--                </div>--%>
        <%--            </div>--%>
        <%--        </li>--%>
    </ul>

    <div class="paging-container">
        <div class="paging">
            <c:if test="${boardDto.comment_cnt==null || boardDto.comment_cnt==0}">
                <div> 댓글이 없습니다. </div>
            </c:if>
        </div>
    </div>
    <div id="comment-writebox">
        <div class="commenter commenter-writebox">${id}</div>
        <div class="comment-writebox-content">
            <textarea name="comment" id="comment" cols="30" rows="3" placeholder="댓글을 남겨보세요"></textarea>
        </div>
        <div id="comment-writebox-bottom">
            <div class="register-box">
                <button class="comment-btn" id="btn-write-comment">등록</button>
            </div>
        </div>
    </div>
</div>
<div id="reply-writebox">
    <div class="commenter commenter-writebox">${id}</div>
    <div class="reply-writebox-content">
        <textarea name="comment" id="replyComment" cols="30" rows="3" placeholder="댓글을 남겨보세요"></textarea>
    </div>
    <div id="reply-writebox-bottom">
        <div class="register-box">
            <button class="comment-btn" id="btn-write-reply">등록</button>
            <button class="comment-btn" id="btn-cancel-reply">취소</button>
        </div>
    </div>
</div>
<div id="modalWin" class="modal">
    <!-- Modal content -->
    <div class="modal-content">
        <span class="close">&times;</span>
        <p>
        <h2> | 댓글 수정</h2>
        <div id="modify-writebox">
            <div class="commenter commenter-writebox"></div>
            <div class="modify-writebox-content">
                <textarea name="comment" id="modComment" cols="30" rows="5" placeholder="댓글을 남겨보세요"></textarea>
            </div>
            <div id="modify-writebox-bottom">
                <div class="register-box">
                    <button class="comment-btn" id="btn-write-modify">등록</button>
                </div>
            </div>
        </div>
        </p>
    </div>
</div>

<script>

    if($("#bno").val() != null) {
        var bno = $("#bno").val();
    }

    let showList = function(bno) {
        $.ajax({
            type:'GET',       // 요청 메서드
            url: '/juwon/comments?bno='+bno,  // 요청 URI
            success : function(result){
                let commentContainer = $(".comment-container");
                commentContainer.empty();

                $.each(result, function (index, comment) {
                    let commentItem = $("<li>").addClass("comment-item")
                        .attr("data-cno", comment.cno)
                        .attr("data-bno", comment.bno);

                    let commentImg = $("<span>").addClass("comment-img");
                    let iClass = $("<i>").addClass("fa fa-user-circle").attr("aria-hidden", true);

                    let commentArea = $("<div>").addClass("comment-area");
                    let commenterArea = $("<div>").addClass("commenter").text(comment.commenter);
                    let contentArea = $("<div>").addClass("comment-content").text(comment.comment);
                    let commentBottom = $("<div>").addClass("comment-bottom");
                    let commentRegDate = $("<span>").addClass("up_date").text(comment.reg_date);

                    // let replyArea = $("<span>").text("&emsp;");

                    if(comment.cno!=comment.pcno) {
                        $(commentItem).css("padding-left", "45px");
                    }

                    let writeBtn = $("<a>").addClass("btnC btn-reply")
                        .attr("data-cno", comment.cno)
                        .attr("data-bno", comment.bno)
                        .attr("data-pcno", comment.pcno)
                        .text("답글");
                    let modBtn = $("<a>").addClass("btnC btn-modify")
                        .attr("data-cno", comment.cno)
                        .attr("data-bno", comment.bno)
                        .attr("data-pcno", comment.pcno)
                        .text("수정");
                    let delBtn = $("<a>").addClass("btnC btn-delete")
                        .attr("data-cno", comment.cno)
                        .attr("data-bno", comment.bno)
                        .attr("data-pcno", comment.pcno)
                        .text("삭제");

                    commentContainer.append(commentItem);

                    // if(comment.cno!=comment.pcno) {commentItem.append(replyArea, commentImg, commentArea);}
                    // else{}
                    commentItem.append(commentImg, commentArea);

                    commentArea.append(commenterArea, contentArea, commentBottom);
                    commentImg.append(iClass);

                    commentBottom.append(commentRegDate, writeBtn, modBtn, delBtn);
                });
            },
            error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
        }); // $.ajax()
    }


    $(document).ready(function () {
        showList(bno);

        let formCheck = function () {
            let form = document.getElementById("form");
            if (form.title.value == "") {
                alert("제목을 입력해 주세요.");
                form.title.focus();
                return false;
            }

            if (form.content.value == "") {
                alert("내용을 입력해 주세요.");
                form.content.focus();
                return false;
            }
            return true;
        }

        $("#writeNewBtn").on("click", function () {
            location.href = "<c:url value='/board/write'/>";
        });

        $("#writeBtn").on("click", function () {
            let form = $("#form");
            form.attr("action", "<c:url value='/board/write'/>");
            form.attr("method", "post");

            if (formCheck())
                form.submit();
        });

        $("#modifyBtn").on("click", function () {
            let form = $("#form");
            let isReadonly = $("input[name=title]").attr('readonly');

            // 1. 읽기 상태이면, 수정 상태로 변경
            if (isReadonly == 'readonly') {
                $(".writing-header").html("게시판 수정");
                $("input[name=title]").attr('readonly', false);
                $("textarea").attr('readonly', false);
                $("#modifyBtn").html("<i class='fa fa-pencil'></i> 등록");
                $("#commentList").hide(); // 댓글 섹션 숨기기

                return;
            }

            // 2. 수정 상태이면, 수정된 내용을 서버로 전송
            form.attr("action", "<c:url value='/board/modify${searchCondition.queryString}'/>");
            form.attr("method", "post");
            if (formCheck())
                form.submit();
        });

        $("#removeBtn").on("click", function () {
            if (!confirm("정말로 삭제하시겠습니까?")) return;

            let form = $("#form");
            form.attr("action", "<c:url value='/board/remove${searchCondition.queryString}'/>");
            form.attr("method", "post");
            form.submit();
        });

        $("#listBtn").on("click", function () {
            location.href = "<c:url value='/board/list${searchCondition.queryString}'/>";
        });



        // 댓글

        $("#btn-write-comment").click(function(){
            let comment = $("#comment").val();

            if(comment.trim()=='') {
                $("#comment").css("placeholder","댓글을 입력해주세요.");
                $("#comment").focus();
                return;
            }

            $.ajax({
                type:'POST',       // 요청 메서드
                url: '/juwon/comments?bno='+bno,  // 요청 URI
                headers : { "content-type": "application/json"}, // 요청 헤더
                data : JSON.stringify({bno:bno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
                success : function(result){
                    console.log(result);
                    showList(bno);
                    // $("#comment").val("");
                    location.reload();
                },
                error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
            }); // $.ajax()
        });


        $(".modal-content").on("click", "#btn-write-modify", function() {
            let cno = $(this).attr("data-cno");
            let comment = $("#modComment").val();

            if(comment.trim()=='') {
                $("#comment").css("placeholder", "댓글을 입력해주세요.");
                $("#comment").focus();
                return;
            }

            $.ajax({
                type:'PATCH',       // 요청 메서드
                url: '/juwon/comments/'+cno,  // 요청 URI
                headers : { "content-type": "application/json"}, // 요청 헤더
                data : JSON.stringify({cno:cno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
                success : function(result){
                    console.log(result);
                    showList(bno);
                },
                error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
            }); // $.ajax()
        });

        $(".comment-container").on("click", "#btn-write-reply", function() {
            // $("#btn-write-reply").click(function(){
            let comment = $("#replyComment").val();
            let pcno = $("#reply-writebox").attr("data-pcno");

            if(comment.trim()=='') {
                $("#comment").css("placeholder", "댓글을 입력해주세요.");
                $("#replyComment").focus();
                return;
            }

            $.ajax({
                type:'POST',       // 요청 메서드
                url: '/juwon/comments?bno='+bno,  // 요청 URI
                headers : { "content-type": "application/json"}, // 요청 헤더
                data : JSON.stringify({pcno:pcno, bno:bno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
                success : function(result){
                    console.log(result);
                    console.log("pcno="+pcno);
                    showList(bno);
                },
                error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
            }); // $.ajax()

            $("#reply-writebox").css("display", "none");
            $("#replyComment").val('');
            $("#reply-writebox").appendTo("body");
        });

        // $(".comment-container").on("click", ".btn-modify", function() {
        //     let cno = $(this).closest(".comment-item").attr("data-cno");
        //     let comment = $("div.comment-content", $(this).parent()).text();
        //
        //     $("#comment").val(comment);
        //     $(".btn-modify").attr("data-cno", cno);
        // });

        $(".comment-container").on("click", ".btn-delete",  function(){
            let cno = $(this).closest(".comment-item").attr("data-cno");
            let bno = $(this).closest(".comment-item").attr("data-bno");
            console.log(cno, bno);

            $.ajax({
                type:'DELETE',       // 요청 메서드
                url: '/juwon/comments/'+cno+'?bno='+bno,  // 요청 URI
                dataType : "json",
                success : function(result){
                    alert(result);
                    showList(bno);
                },
                error   : function(){
                    console.log("error");
                    showList(bno);
                } // 에러가 발생했을 때, 호출될 함수
            }); // $.ajax()
        });

        // $(".comment-container").on("click", ".replyBtn", function(){
        //     $("#replyForm").appendTo($(this).parent());
        //
        //     $("#replyForm").css("display", "block");
        // });




        $(".comment-container").on("click", ".btn-reply", function(e) {
            // $("a.btn-write").click(function(e){
            let target = e.target;
            let cno = target.getAttribute("data-cno")
            let bno = target.getAttribute("data-bno")
            let pcno = target.getAttribute("data-pcno")

            let repForm = $("#reply-writebox");
            repForm.appendTo($("li[data-cno="+cno+"]"));
            repForm.css("display", "block");
            repForm.attr("data-pcno", pcno);
            repForm.attr("data-bno",  bno);
        });

        $("#btn-cancel-reply").click(function(e){
            $("#reply-writebox").css("display", "none");
        });

        $(".comment-container").on("click", ".btn-modify", function(e) {
            // $("a.btn-modify").click(function(e){
            let target = e.target;
            let cno = target.getAttribute("data-cno");
            let bno = target.getAttribute("data-bno");
            let pcno = target.getAttribute("data-pcno");
            let li = $("li[data-cno="+cno+"]");
            let commenter = $(".commenter", li).first().text();
            let comment = $(".comment-content", li).first().text();

            console.log(li)

            $("#modalWin .commenter").text(commenter);
            $("#modalWin textarea").text(comment);
            $("#btn-write-modify").attr("data-cno", cno);
            $("#btn-write-modify").attr("data-pcno", pcno);
            $("#btn-write-modify").attr("data-bno", bno);

            // 팝업창을 열고 내용을 보여준다.
            $("#modalWin").css("display","block");
            showList(bno);
        });

        $("a.btn-delete").click(function(e){
            alert("delete");
        });

        $("#btn-write-modify").click(function(){
            // 1. 변경된 내용을 서버로 전송
            // 2. 모달 창을 닫는다.
            $(".close").trigger("click");
        });

        $(".close").click(function(){
            $("#modalWin").css("display","none");
        });


    });



</script>

</body>

</html>