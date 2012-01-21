// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


// Open Links with `rel="external"` in a new window
function externalLinks() {
  var anchors = document.getElementsByTagName("a"),
      i;

  if (!document.getElementsByTagName){
    return;
  }
  for (i = 0; i<anchors.length; i++) {
    var anchor = anchors[i];
    if (anchor.getAttribute("href") && anchor.getAttribute("rel") === "external"){
      anchor.target = "_blank";
    }
  }
}
window.onload = externalLinks;