var riot = require('riot');

require('./tags/app-main.tag');
require('./tags/app-person.tag');

var main = riot.mount('app-main');
var person = riot.mount('app-person');