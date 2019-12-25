// ==UserScript==
// @name        netflix-plus.user.js
// @namespace   UserScripts
// @author		phyck
// @description netflix-plus.user.js provides an improvement to netflix.com
// @description The script will bypass the annoying Netflix profile selection page that pops up everytime I open netflix (multi user account)! It will select/click the profile on n-th position (profileId) in the Netflix profile list.
// @description	Set "profileId" to the position of the desired netflix profile in the list of profiles.
// @description More features coming soon!
// @license		MIT
// @version     1.0.0
// @include 	https://netflix.com/*
// @icon		https://raw.githubusercontent.com/phyck/Scripts/images/netflix.png
// @require		https://openuserjs.org/src/libs/sizzle/GM_config.js
// @run-at 		document-end
// @downloadURL	https://github.com/phyck/Scripts/raw/master/src/netflix-plus.user.js
// @homepageURL	https://github.com/phyck/Scripts/UserScripts
// @grant		GM_getValue
// @grant		GM_setValue
// @released	2019-12-12
// @updated		2019-12-12
// @compatible	firefox
// @compatible	Tampermonkey
// @compatible	Chrome
// ==/UserScript==
/* 
// @resource	profileId	2 
*/

window.addEventListener('DOMContentLoaded', () => {
	var id = GM_getValue("profileId");  // Get configured value of "profileId" resource from UserScript metadata
    var ProfileSelection = document.querySelector("#appMountPoint > div > div > div:nth-child(1) > div.bd.dark-background > div.profiles-gate-container > div > div > ul > li:nth-child(2) > div > a") !== null;
	if (ProfileSelection) {
		console.log("Profile gate detected!");
		document.querySelector("#appMountPoint > div > div > div:nth-child(1) > div.bd.dark-background > div.profiles-gate-container > div > div > ul > li:nth-child(2) > div > a").click();
	} else {
		console.log("No profile gate detected, no action required!");
	}
});
