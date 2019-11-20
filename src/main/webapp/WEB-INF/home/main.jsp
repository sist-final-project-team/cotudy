<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
  <meta charset="utf-8">
  <title>COTUDY</title>
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <meta content="" name="keywords">
  <meta content="" name="description">



</head>

<body>

 <div class="click-closed"></div>


<jsp:include page="header.jsp"></jsp:include>

<%--   / Carousel Star /--%>
 <div class="intro intro-carousel">
   <div id="carousel" class="owl-carousel owl-theme">
     <div class="carousel-item-a intro-item bg-image" style="background-image: url(../resources/../resources/img/slide-1.jpg)">
       <div class="overlay overlay-a"></div>
       <div class="intro-content display-table">
         <div class="table-cell">
           <div class="container">
             <div class="row">
               <div class="col-lg-8">
                 <div class="intro-body">
                   <h1 class="intro-title mb-4">
                     	아직도 <span class="color-b" style="text-shadow: 3px 3px 15px black;">혼자</span>
                     <br> 공부하시나요?</h1>
                   <p class="intro-subtitle intro-price">
                     <a href="/studyList"><span class="price-a">같이 공부 시작하기</span></a>
                   </p>
                 </div>
               </div>
             </div>
           </div>
         </div>
       </div>
     </div>
     <div class="carousel-item-a intro-item bg-image" style="background-image: url(../resources/img/slide-2.jpg)">
       <div class="overlay overlay-a"></div>
       <div class="intro-content display-table">
         <div class="table-cell">
           <div class="container">
             <div class="row">
               <div class="col-lg-8">
                 <div class="intro-body">
<%--                   <p class="intro-title-top">Doral, Florida--%>
<%--                     <br> 78345</p>--%>
                   <h1 class="intro-title mb-4">
                                          	아직도 <span class="color-b" style="text-shadow: 3px 3px 15px black;">혼자</span>
                                          <br> 공부하시나요?</h1>
                   <p class="intro-subtitle intro-price">
                     <a href="/studyList"><span class="price-a">같이 공부 시작하기</span></a>
                   </p>
                 </div>
               </div>
             </div>
           </div>
         </div>
       </div>
     </div>
     <div class="carousel-item-a intro-item bg-image" style="background-image: url(../resources/img/slide-3.jpg)">
       <div class="overlay overlay-a"></div>
       <div class="intro-content display-table">
         <div class="table-cell">
           <div class="container">
             <div class="row">
               <div class="col-lg-8">
                 <div class="intro-body">
<%--                   <p class="intro-title-top">Doral, Florida--%>
<%--                     <br> 78345</p>--%>
                   <h1 class="intro-title mb-4">
                     <span class="color-b" style="text-shadow: 3px 3px 15px black;">코딩</span>
                     <br> 이젠 어렵지 않아요</h1>
                   <p class="intro-subtitle intro-price">
                     <a href="/studyList"><span class="price-a">같이 공부 시작하기</span></a>
                   </p>
                 </div>
               </div>
             </div>
           </div>
         </div>
       </div>
     </div>
   </div>
 </div>
 <!--/ Carousel end /--> 

  <!--/ Services Star /-->
  <section class="section-services section-t8">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="title-wrap d-flex justify-content-between">
            <div class="title-box">
              <h2 class="title-a">사이트 소개</h2>
            </div>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-md-4">
          <div class="card-box-c foo">
            <div class="card-header-c d-flex">
              <div class="card-box-ico">
                <span class="fa fa-gamepad"></span>
              </div>
              <div class="card-title-c align-self-center">
                <h2 class="title-c">Lifestyle</h2>
              </div>
            </div>
            <div class="card-body-c">
              <p class="content-c">
                Sed porttitor lectus nibh. Cras ultricies ligula sed magna dictum porta. Praesent sapien massa,
                convallis a pellentesque
                nec, egestas non nisi.
              </p>
            </div>
            <div class="card-footer-c">
              <a href="#" class="link-c link-icon">Read more
                <span class="ion-ios-arrow-forward"></span>
              </a>
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card-box-c foo">
            <div class="card-header-c d-flex">
              <div class="card-box-ico">
                <span class="fa fa-usd"></span>
              </div>
              <div class="card-title-c align-self-center">
                <h2 class="title-c">Loans</h2>
              </div>
            </div>
            <div class="card-body-c">
              <p class="content-c">
                Nulla porttitor accumsan tincidunt. Curabitur aliquet quam id dui posuere blandit. Mauris blandit
                aliquet elit, eget tincidunt
                nibh pulvinar a.
              </p>
            </div>
            <div class="card-footer-c">
              <a href="#" class="link-c link-icon">Read more
                <span class="ion-ios-arrow-forward"></span>
              </a>
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card-box-c foo">
            <div class="card-header-c d-flex">
              <div class="card-box-ico">
                <span class="fa fa-home"></span>
              </div>
              <div class="card-title-c align-self-center">
                <h2 class="title-c">Sell</h2>
              </div>
            </div>
            <div class="card-body-c">
              <p class="content-c">
                Sed porttitor lectus nibh. Cras ultricies ligula sed magna dictum porta. Praesent sapien massa,
                convallis a pellentesque
                nec, egestas non nisi.
              </p>
            </div>
            <div class="card-footer-c">
              <a href="#" class="link-c link-icon">Read more
                <span class="ion-ios-arrow-forward"></span>
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section> <br><br><br><br><br>
  <!--/ Services End /-->

  </section> 
  <!--/ footer Star /-->
 <jsp:include page="footer.jsp"></jsp:include>

  <a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>
  <div id="preloader"></div>

  <!-- JavaScript Libraries -->
  <script src="../resources/lib/jquery/jquery.min.js"></script>
  <script src="../resources/lib/jquery/jquery-migrate.min.js"></script>
  <script src="../resources/lib/popper/popper.min.js"></script>
  <script src="../resources/lib/bootstrap/js/bootstrap.min.js"></script>
  <script src="../resources/lib/easing/easing.min.js"></script>
  <script src="../resources/lib/owlcarousel/owl.carousel.min.js"></script>
  <script src="../resources/lib/scrollreveal/scrollreveal.min.js"></script>
  <!-- Contact Form JavaScript File -->
  <script src="../resources/contactform/contactform.js"></script>

  <!-- Template Main Javascript File -->
  <script src="../resources/js/main.js"></script>

</body>
</html>
