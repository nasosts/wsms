<?php

require_once 'Controller.php';
require_once 'Models/UserModel.php';
require_once 'Models/RoleModel.php';
require_once 'Models/entities/User.php';
/**
 * Controller for users
 */
 class UsersController extends Controller
 {
 	public function __construct()
 	{
 		parent::__construct();
 	}

 	public function login($username='', $password='')
 	{
 		require_once 'PageController.php';
		$page = new PageController;

 		if (empty($username) && empty($password)) {
 			$page->redirect(HOME);
 		}

 		$user = UsersController::viewByUsername($username);

 		if (!is_null($user))
 		{
 			if ($user->password == $password)
 			{
 				$_SESSION['success_logged_in'] = true;
 				$_SESSION['username'] = $user->username;
 				$_SESSION['role'] = $user->role;
		 		$page->redirect(HOME);
 			}
 		}
		$page->redirect(HOME);
 	}

 	public function logout($username='')
 	{
 		$_SESSION['role'] = null;
 		$_SESSION['username'] = null;
 		$_SESSION['success_logged_in'] = null;

 		require_once 'PageController.php';
 		$page = new PageController;
 		$page->redirect(HOME);
 	}

 	public function index()
 	{
 		if (isset($_SESSION['role'])) {
 			if( $_SESSION['role'] == 'MANAGER') {
				try 
				{
					$this->view->render('users', 'index', UserModel::getUsers()); 
				}
 				catch(Exception $ex)
			 	{
	 				require_once 'PageController.php';
					$page = new PageController;
					$page->errordb($ex->getMessage());
 				}
			}
			else {
 				require_once 'PageController.php';
				$page = new PageController;
				$page->error_accdenied();
			}
 		}
 	}

 	public function adduser()
 	{
 		if (isset($_SESSION['role'])) {
 			if( $_SESSION['role'] == 'MANAGER') {
				try
				{
					$this->view->render('users', 'adduser', UserModel::getUsers()); 
				}
 				catch(Exception $ex)
			 	{
	 				require_once 'PageController.php';
					$page = new PageController;
					$page->errordb($ex->getMessage());
 				}
			}
			else {
 				require_once 'PageController.php';
				$page = new PageController;
				$page->error_accdenied();
			}
 		}
 	}

 	public function edituser()
 	{
 		if (isset($_SESSION['role'])) {
 			if( $_SESSION['role'] == 'MANAGER') {
				try 
				{
					$this->view->render('users', 'edituser', UserModel::getUserById($_GET['id'])); 
				}
 				catch(Exception $ex)
			 	{
	 				require_once 'PageController.php';
					$page = new PageController;
					$page->errordb($ex->getMessage());
 				}
			}
			else {
 				require_once 'PageController.php';
				$page = new PageController;
				$page->error_accdenied();
			}
 		}
 	}

 	public function deleteuser()
 	{
 		if (isset($_SESSION['role'])) {
 			if( $_SESSION['role'] == 'MANAGER') {
				try 
				{
					$this->view->render('users', 'deleteuser', UserModel::getUserById($_GET['id'])); 
				}
 				catch(Exception $ex)
			 	{
	 				require_once 'PageController.php';
					$page = new PageController;
					$page->errordb($ex->getMessage());
 				}
			}
			else {
 				require_once 'PageController.php';
				$page = new PageController;
				$page->error_accdenied();
			}	
		}
 	}

 	public function create()
 	{
	 	if (isset($_SESSION['role'])) {
 			if( $_SESSION['role'] == 'MANAGER') {
 				try
 				{
 					$user = new User($_POST['username'], $_POST['password'], $_POST['email'], $_POST['role'], null);
 					UserModel::create($user);
 					UsersController::index();
 				}
 				catch(Exception $ex)
			 	{
	 				require_once 'PageController.php';
					$page = new PageController;
					$page->errordb($ex->getMessage());
 				}
 			}
 			else {
 				require_once 'PageController.php';
				$page = new PageController;
				$page->error_accdenied(); 			
			}
 		}
 	}

 	public function update()
 	{
 		if (isset($_SESSION['role'])) {
 			if( $_SESSION['role'] == 'MANAGER') {
 				try 
 				{
 					$user = new User($_POST['username'], $_POST['password'], $_POST['email'], null, $_POST['idUser']);
 					UserModel::update($user);
 					UsersController::index();
 				}
 				catch(Exception $ex)
 				{
	 				require_once 'PageController.php';
					$page = new PageController;
					$page->errordb($ex->getMessage());
 				}
 			}
 			else {
 				require_once 'PageController.php';
				$page = new PageController;
				$page->error_accdenied(); 			 			
 			}
 		}
 	}

 	public function delete()
 	{
 		if (isset($_SESSION['role'])) {
 			if( $_SESSION['role'] == 'MANAGER') {
 				try
 				{
 					UserModel::delete($_POST['idUser']);
 					UsersController::index();
 				}
 				catch(Exception $ex)
 				{
	 				require_once 'PageController.php';
					$page = new PageController;
					$page->errordb($ex->getMessage());
 				}
 			}
 			else {
 				require_once 'PageController.php';
				$page = new PageController;
				$page->error_accdenied(); 			 			
 			}
 		}
 	}

 	public function viewById($idUser='')
 	{
 		$users = UserModel::getUsers();

 		if (is_array($users)) 
 		{
 			foreach ($users as &$value) 
 			{
 				if ($value->idUser == $idUser)
 				{
 					$this->view->render('users', '', $value);
 				}
 			}
 		}
 		return null;
 	}

 	public static function viewByUsername($username='')
 	{
 		$users = UserModel::getUsers();

 		if (is_array($users)) 
 		{
 			foreach ($users as &$value) 
 			{
 				if ($value->username == $username)
 				{
 					return $value;
 				}
 			}
 		}
 		return null;
 	} 	
 }
