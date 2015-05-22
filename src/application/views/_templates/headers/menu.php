<!--navigation menu-->
<body class="<?php
global $current_page;
echo $current_page ; if(Auth::is_user_logged_in()) echo ' logged-in'; if(Auth::is_admin())echo ' admin'; ?>"><?php $this->renderFeedbackMessages(); ?>
<div class="navbar navbar-default navbar-fixed-top" data-spy="affix" data-offset-top="10"  role="navigation">
    <div class="container-fluid">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <!--logo -->
                <a class="navbar-brand" href="<?php echo URL ?>"><span
                        class="logo-effect">EDeC</span></a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li class="active">
                        <a href="<?php echo URL . 'index/' ?>">Home</a>
                    </li>
                    <li>
                        <a href="#" id="about">About</a>
                    </li>
                    <?php
                        if(Auth::is_user_logged_in()){
                    ?>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dashboard<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li class="dropdown-header">Client</li>
                            <li><a href="<?php echo URL . 'access' ?>">Access</a></li>
                            <li><a href="<?php echo URL . 'search' ?>">Search</a></li>
                            <li><a href="<?php echo URL . 'stats' ?>">Stats</a></li>
                            <li><a href="<?php echo URL . 'access/logout' ?>">Log Out</a></li>
                            <?php if(Auth::is_admin()){ ?>
                            <li class="dropdown-header">Administrator</li>
                            <li><a href="<?php echo URL . 'controlpannel' ?>">Control Pannel</a></li>
                                <li><a href="<?php echo URL . 'controlpannel/products' ?>">Products</a></li><li><a href="<?php echo URL . 'controlpannel/characteristics' ?>">Characteristici</a></li>

                            <?php } ?>
                        </ul>
                    </li><?php
}else {
                    ?>
                    <li><a href="<?php echo URL . 'access' ?>">Register/Login</a></li>
                    <?php } ?>
                    <li>
                        <a href="#contact" data-toggle="modal">Contact</a>
                    </li>
                </ul>
            </div>
            <!--navbar collapse-->
        </div>
        <!--small container for the navigation bar-->
    </div>
    <!--container to center all the pices together-->
</div>