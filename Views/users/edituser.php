<?php
  //$which = 'users'; //which navbar button is active
  require_once 'Views/navbars/navbar.php';
?>

<div class="container">   
<h2>
  	Επεξεργασία χρήστη
</h2>

<form class="form-horizontal" onsubmit="return validate()" action="<?php echo USERS . "/update"; ?>" method="post">
  <div class="control-group">
    <label class="control-label" for="username">Username</label>
    <div class="controls">
      <input type="text" name="username" placeholder="username" value="<?php echo $data->username; ?>">
    </div>
  </div>
  <div class="control-group">
    <label class="control-label" for="email">Email</label>
    <div class="controls">
      <input type="text" name="email" placeholder="email" value="<?php echo $data->email; ?>">
    </div>
  </div>

  <div class="control-group">
    <label class="control-label" for="role">Ρόλος</label>
    <div class="controls">
	<select name="role">
		<option <?php if($data->role == "MANAGER") echo "selected" ?> value="MANAGER">MANAGER</option>
		<option <?php if($data->role == "SCHEDULER") echo "selected" ?> value="SCHEDULER">SCHEDULER</option>
		<option <?php if($data->role == "SELLER") echo "selected" ?> value="SELLER">SELLER</option>
		<option <?php if($data->role == "STOREKEEPER") echo "selected" ?> value="STOREKEEPER">STOREKEEPER</option>
	</select>
    </div>
  </div>

  <div class="control-group">
    <label class="control-label" for="password">Password</label>
    <div class="controls">
      <input type="password" id="password" name="password" placeholder="password" oninput="passwordStrength()" value="<?php echo $data->password; ?>">
    </div>
  </div>
  <div class="control-group">
    <label class="control-label" for="retypepassword">Επιβεβαίωση Password</label>
    <div class="controls">
      <input type="password" id="retypepassword" name="retypepassword" placeholder="password" value="<?php echo $data->password; ?>">
    </div>
  </div>
  
  <input type="hidden" name="idUser" value="<?php echo $data->idUser; ?>">
  

  <div class="alert" id="alertstrength">
    Password strength
  </div>

  <div class="control-group">
    <div class="controls">
      <button type="submit" class="btn btn-primary">Ανανέωση</button>
    </div>
  </div>
</form>
</div>

<script type="text/javascript">
  jQuery(document).ready(function($) {
      jQuery('#alertstrength').hide();
  });

	function validate() {
		if(document.getElementById("password").value != document.getElementById("retypepassword").value) 
		{
			alert("Τα passwords που δόθηκαν δεν ταιριάζουν");
			return false;
		}
		return true;
	}

	function passwordStrength()
	{
    jQuery('#alertstrength').show();

    var msg = new Array();
    msg[0] = "Μη αποδεκτό - Απαιτούνται τουλάχιστον 6 χαρακτήρες";
    msg[1] = "Αδύναμο";
    msg[2] = "Αδύναμο+";
    msg[3] = "Μέτριο";
    msg[4] = "Μέτριο+";
    msg[5] = "Καλό";
    msg[6] = "Καλό+";
    msg[7] = "Δυνατό";
    msg[8] = "Δυνατό+";
    msg[9] = "Πολύ δυνατό";
    msg[10] = "Πολύ δυνατό+";

    var password = jQuery('#password').val();

    var strength = 0;

    if (password.length < 6)
      strength = 0;

    if (password.length >= 6) 
      strength = 1;

    if (password.length >= 10) 
      strength = 3;

    if (password.length >= 12) 
      strength = 5;

    if (password.length >= 15) 
      strength = 7;

    if (password.length >= 20) 
      strength = 9;

    if ( password.match(/.[!,@,#,$,%,^,&,*,?,_,~,-,(,)]/) ) 
      strength++;

      jQuery('#alertstrength').text(msg[strength]);
}
</script>
