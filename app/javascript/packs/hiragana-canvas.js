var canvas = document.getElementById("hiragana-canvas");

if (canvas !== null) {
  var hiraCTX = canvas.getContext("2d");

  hiraCTX.beginPath();
    hiraCTX.arc(50, 50, 20, 0, Math.PI*2, false);
    hiraCTX.fillStyle = "#ffc0cb";
    hiraCTX.fill();
  hiraCTX.closePath();
}