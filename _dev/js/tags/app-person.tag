<app-person>
  <canvas id="person"></canvas>

  <style scoped>
    :scope{
      display: block;
    }
    #person{
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
    }
  </style>

  var canvas, stage, person, head;

  this.on('mount', function(){
    var world = require('../controller/timer.js');

    window.addEventListener('load', setup, false);

    function setup(){
      canvas = document.getElementById('person');
      setSize();
      stage = new createjs.Stage('person');
      person = new Person(world, {position: 'Creator', color: '#f00'}, {time: 9.5, d: 2000, x: 415, y: 287}, {time: 18.5, d: 2000, x: 100, y: 200});

      createjs.Ticker.addEventListener("tick", handleTick);
    }
    function setSize(){
      canvas.width = window.innerWidth;
      canvas.height = window.innerHeight;
    }
	function handleTick(){
      stage.update();
    }

    function Person(world, job, position, ini){
      this.color = job.color;
      this.job = job.position;
      this.state = 0;
      this.position = {time: world.rate*world.h*position.time, d: position.d, x: position.x, y: position.y};
      this.ini = {time: world.rate*world.h*ini.time, d: ini.d, x: ini.x, y: ini.y};
      this.routes = [{d: 400, x: 150, y: 150}, {d: 400, x: 200, y: 200}];
      this.init();
    };
    Person.prototype = {
      init: function(){
        head = new createjs.Shape();
        head.graphics.beginFill(this.color);
        head.graphics.drawCircle(0, 0, 3);
        head.x = this.ini.x;
        head.y = this.ini.y;
        stage.addChild(head);
        stage.update();

        world.observe(this);
      },
      check: function(t){
        var me = this;
        console.log((me.position.time - me.position.d) + ':' + (me.ini.time - me.ini.d) + ':' + t + ':' + me.state);
        if(me.state === 0 && me.position.time - me.position.d === t){
          me.state = 1;
          me.go();
        }
        if(me.state === 0 && me.ini.time - me.ini.d === t){
          me.state = 1;
          me.out();
        }
      },
      go: function(){
        var me = this;
        //createjs.Tween.get(head).to({x: me.position.x, y: me.position.y}, me.position.d).call(function(){me.state = 0});
        createjs.Tween.get(head).to({x: me.routes[0].x, y: me.routes[0].y}, me.routes[0].d)
                                .to({x: me.routes[1].x, y: me.routes[1].y}, me.routes[1].d)
                                .to({x: me.position.x, y: me.position.y}, me.position.d - (me.routes[0].d + me.routes[1].d))
                                .call(function(){me.state = 0});
      },
      work: function(){

      },
      meeting: function(){

      },
      out: function(){
        var me = this;
        //createjs.Tween.get(head).to({x: me.ini.x, y: me.ini.y}, me.ini.d).call(function(){me.state = 0});
        createjs.Tween.get(head).to({x: me.routes[1].x, y: me.routes[1].y}, me.routes[1].d)
                                .to({x: me.routes[0].x, y: me.routes[0].y}, me.routes[0].d)
                                .to({x: me.ini.x, y: me.ini.y}, me.ini.d - (me.routes[0].d + me.routes[1].d))
                                .call(function(){me.state = 0});
      }
    }

  });
</app-person>