var Timer = function(){
  this.init();
}
Timer.prototype = {
  init: function(){
  	var me = this;
    me.observer = [];
  	// 1時間を30秒で処理
  	me.rate = (1000*30)/(1000*60*60);
  	me.h = 1000*60;
  	me.time = 0;

  	setInterval(function(){
  	  // 経過時間を取得
  	  me.time += me.h/2*me.rate;
  	  if(me.time >= me.h*me.rate*24){
  	  	me.time = 0;
  	  }
      me.check(me.time);
  	}, me.h/2*me.rate);
  },
  observe: function(obj){
  	this.observer.push(obj);
  },
  check: function(t){
  	var me = this;
    for(var i = 0, cnt = me.observer.length; i < cnt; i++){
      me.observer[i].check(t);
    }
  }
}

module.exports = new Timer();