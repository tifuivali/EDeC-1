<body>

    <div class="container main-wrapper-product-content box">
        <div class="row">
            <div class="col-md-4">
                <div class="box-image-wrapper box">
                   <img src="<?php echo URL ?>/html/img/backgrounds/oreo.jpg" alt="oreo" class="img-responsive img-rounded">
                </div>

                <div class="like-menu-nav box">
                    <a href="#" class="pull-right">
                        <span class="glyphicon glyphicon-thumbs-up">25</span>
                    </a>

                    <a href="#" class="pull-right">
                     <span class="glyphicon glyphicon-thumbs-down">25</span>
                    </a>

                    <a href="#" class="pull-right">
                        <span class="glyphicon glyphicon-comment">10</span>
                    </a>
                </div>

            </div><!--col-md-4-->

            <div class="col-md-8">
                <div class="jumbotron-wrapper">
                    <h1>Biscuits Oreo</h1>
                    <div class="jumbotron product-jumbotron">
                        <p>Oreo is a sandwich cookie consisting of two chocolate wafers with a sweet creme filling inbetween, and (as of 1974) are marketed as
                        "Chocolate Sandwich Cookies" on the package they are held in. The version currently sold in the United States is made by the Nabisco division
                        of Mondelez International. Oreo has become the best selling cookie in the
                        United States since its introduction in</p>
                    </div>
                </div><!--jumbotron wrapper-->
                <a href="#" class="pull-right missing-ingredient"> Report missing ingredient</a>
            </div><!--col-md-8-->
        </div><!--row-->
    </div><!--container-->
    <div class="container similar-box-wrapper">
            <div class="row">
                <div class="col-md-12">
                            <h1>Similar products</h1>
                                <div class="left-arrow pull-left box ">
                                    <a href="">
                                        <span class="glyphicon glyphicon-arrow-left"></span>
                                    </a>
                                </div>

                                <div class="similar-products box"></div>

                                <div class="right-arrow pull-right box">
                                    <a href="">
                                        <span class="glyphicon glyphicon-arrow-right"></span>
                                    </a>
                                </div>
                </div>
            </div>
        </div>


    <!--pop UP-->
    <!-- Loading animation svg -->
    <svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid"
         class="util-pie">
        <rect x="0" y="0" width="100" height="100" fill="none" class="bk"></rect>
        <path d="M0 50A50 50 0 0 1 50 0L50 50L0 50" fill="#0073eb" opacity="0.5">
            <animateTransform attributeName="transform" type="rotate" from="0 50 50" to="360 50 50" dur="0.8s"
                              repeatCount="indefinite"></animateTransform>
        </path>
        <path d="M50 0A50 50 0 0 1 100 50L50 50L50 0" fill="#00ff27" opacity="0.5">
            <animateTransform attributeName="transform" type="rotate" from="0 50 50" to="360 50 50" dur="1.6s"
                              repeatCount="indefinite"></animateTransform>
        </path>
        <path d="M100 50A50 50 0 0 1 50 100L50 50L100 50" fill="#ff9400" opacity="0.5">
            <animateTransform attributeName="transform" type="rotate" from="0 50 50" to="360 50 50" dur="2.4s"
                              repeatCount="indefinite"></animateTransform>
        </path>
        <path d="M50 100A50 50 0 0 1 0 50L50 50L50 100" fill="#ff3c00" opacity="0.5">
            <animateTransform attributeName="transform" type="rotate" from="0 50 50" to="360 50 50" dur="3.2s"
                              repeatCount="indefinite"></animateTransform>
        </path>
    </svg>