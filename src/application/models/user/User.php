<?php
class User
{

    private $db;

    /**
     * Public consttructor for db connection
     * $db object is the global object that stores the database connection
     * and all the mothods and attributes from Database class
     * please check Database to know what the hell it's doing
     */
    public function __construct(){
        $this->db = $GLOBALS['db'];
    }
      /*HANDLERS */
          public function handleLogin()
      {
          /*We presume that everything it's valid */
          $arrayOfCheckers = SplFixedArray::fromArray(array(0,0));

          Session::set("login","render");
          if( isset($_POST['loginUsername']) &&
              isset($_POST['loginPassword']) &&
              $_POST['loginUsername'] !="" &&
              $_POST['loginPassword'] !="" )
          {
                  if (!$this->validClientUsername($_POST['loginUsername']))
                      $arrayOfCheckers[0] = 1;
                  if (!$this->validClientPassword($_POST['loginPassword']))
                      $arrayOfCheckers[1] = 1;
                  /*we susspect that everything it's ok*/
                  $error = 0;
                  /*we iiterate all of error is something get's wrong we handle it like MEN */
                  foreach ($arrayOfCheckers as $key => $value) {
                      switch ($key) {
                          case 0:
                              if ($value) {
                                  $error = 1;
                                  add_error("Invalid username/Username does not exist");
                              }
                              break;
                          case 1:
                              if ($value) {
                                  $error = 1;
                                  add_error("Invalid password");
                              }
                              break;
                      }//swith
                  }//foreach
                  if ($error == 0) {
                      // loginUser($post);
                      add_success("Logged!");
                      return true;
                  } else return false;
          }//if
          else {
              //you bastard :))*/
              add_error("Plase complete all the forms");
              return false;
          }
      }
      public function handleRegister()
      {
          /*we presume that everything it's valid */
          $arrayOfCheckers = SplFixedArray::fromArray(array(0,0,0,0,0));
          /*if the user completed all the forms */
          if( isset($_POST['registerUsername']) &&
              isset($_POST['email']) &&
              isset($_POST['registerPassword']) &&
              isset($_POST['repeatRegisterPassword']) &&
              isset($_POST['gender']) &&
              isset($_POST['birthday']) && (
                $_POST['registerUsername'] !="" &&
                $_POST['email'] !="" &&
                $_POST['registerPassword'] !="" &&
                $_POST['repeatRegisterPassword'] !="" &&
                $_POST['birthday'] !="" ))
          {
              if(!$this->validateUsername($_POST['registerUsername'])) //if it fails
                $arrayOfCheckers[0] = 1;
              if(!$this->validateEmail($_POST['email']))
                $arrayOfCheckers[1] = 1;
              if(!$this->validPassword($_POST['registerPassword']))
                $arrayOfCheckers[2] = 1;
              if(!$this->validRepeatPassword($_POST['repeatRegisterPassword']))
                  $arrayOfCheckers[3] = 1;
              if(!$this->validBirthday($_POST['birthday']))
                  $arrayOfCheckers[4] = 1;

              /*we suspect that everything is ok by default */
              $error = 0;
              /*we iiterate all of error is something get's wrong we handle it like MEN */
              foreach($arrayOfCheckers as $key => $value )
              {
                    switch($key)
                    {
                        case 0:
                            if($value) {
                                $error = 1;
                                add_error("Incorrect username or already registered");
                            }
                            break;
                        case 1:
                            if($value) {
                                $error = 1;
                                add_error("Invalid email or already registerd");
                            }
                            break;
                        case 2:
                            if($value) {
                                $error = 1;
                                add_error("Invalid password ");
                            }
                            break;
                        case 3:
                            if($value) {
                                $error = 1;
                                add_error("The password shold match");
                            }
                            break;
                        case 4:
                            if($value){
                                $error = 1;
                                add_error("Please enter a valid date");
                            }
                            break;
                    }
              }
              /*if everything it's ok*/
              if(!$error) {
                  // saveUserFromPost($post);
                  add_success("Registered !");
                  return true;
              }
              else return false;
          }
          else{
              /*you bastard :))*/
              add_error("Plase complete all the forms");
              return false;
          }
      }//method
    /*LOGIN*/
    public function validClientUsername($clientUsername)
    {

        if($clientUsername == 'test')
            return 1;
        else
            return 0;
    }
    public function validClientPassword($clientPassword)
    {
        if($clientPassword == 'test')
            return 1;
        else
            return 0;
    }
    /*REGISTER*/
    public function validateUsername($username)
    {
        if ($username == 'test')
            return 1;
        else
            return 0;
    }

    public function validateEmail($email)
    {
        if ($email == 'test@test.com')
            return 1;
        else
            return 0;
    }

    public function validPassword($password)
    {
        if($password === 'test')
            return 1;
        else
            return 0;
    }
    public function validRepeatPassword($repeatPassword)
    {
        if($repeatPassword === 'test')
            return 1;
        else
            return 0;
    }
    public function validBirthday($birthday)
    {
        if($birthday === 'test')
            return 1;
        else
            return 0;
    }
    public function saveUserFromPost($post)
    {
        // adaugam in baza de date
    }
    public function loginUserFromPost($post)
    {
        // logam userul , salvand o sesiune pana cand el se va deloga
    }


}