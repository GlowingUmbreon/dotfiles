// ==UserScript==
// @name          invidious MPV
// @match         https://yewtu.be/*
// @run-at        document-end
// @version       1.0
// ==/UserScript==

let videos = document.getElementsByClassName("pure-u-md-1-4");

for (let e of videos) {
  e = e.children[0];
  let id = e.children[0].href.split("=")[1];
  console.log(id);

  let icon = document.createElement("i");
  icon.className = "icon ion-ios-play-circle";
  let btn = document.createElement("a");
  btn.href = "mpv://http://youtu.be/" + id;
  //btn.href = "mpv://ytdl://"+id
  btn.appendChild(icon);

  e.getElementsByClassName("icon-buttons")[0].appendChild(btn);
}