<app-main>
  <canvas id="area" onclick={setPoint}></canvas>
  <div class="controls">
    <button onclick={nextData}>Next</button>
    <a href="">Download</a>
  </div>

  <style scoped>
    :scope{
      display: block;
    }
    #area{
      position: absolute;
      top: 0;
      left: 0;
      background: url(./assets/img/bg.png) no-repeat 50% 0;
      background-size: 50%;
      width: 100%;
    }
    .controls{
      position: relative;
      width: 200px;
      height: 60px;
    }
  </style>

  var canvas, stage;
  var data = {};
  data[0] = [];
  var n = 0;

  this.on('mount', function(){
    var world = require('../controller/timer.js');

    window.addEventListener('load', setup, false);

    function setup(){
      canvas = document.getElementById('area');
      setSize();

      TouchPoint.color = 'black';
      TouchPoint.size = 6;
      TouchPoint.scale = 3;
      TouchPoint.init(canvas);
    }
    function setSize(){
      canvas.width = window.innerWidth;
      canvas.height = 500;
    }

  });

  setPoint(e){
    console.log(e.pageX + ':' + e.pageY);
    data[n].push({x: e.pageX, y: e.pageY});
  }
  nextData(){
    n++;
    data[n] = [];
    console.log(data);
  }
</app-main>