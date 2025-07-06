//This JavaScript Bangle.JS 2.0 code for the SmartStepper connects via Bluetooth to two embedded seeed boards. It receives step information and adds them to a file with today's date. The code displays a menu, with options for a graph (displaying the week's step information), and a game (with reward functionality for more steps and better step ratios than the previous day!)!

var gt = null;
var graphInt;
let menuDisplayed = true;
//****************************TIME & BATTERY DISPLAY CODE****************************//
// Function to display the current time and battery information
function displayInfo() {
  var now = new Date();
  var hours = now.getHours().toString().padStart(2, '0');
  var minutes = now.getMinutes().toString().padStart(2, '0');
  var timeString = hours + ':' + minutes;
  var batteryLevel = E.getBattery();
  var batteryString = 'Battery: ' + Math.round(batteryLevel) + '%';
  g.setFontAlign(1, 0);
  g.setFont("4x6");
  g.drawString(timeString, g.getWidth() - 5, 3);
  g.drawString(batteryString, g.getWidth() - 30, 3);
}


//****************************FOOT & BAR CLASSES*************************************//
//for use in both the game and the graph
//foot class keeps track of good steps, bad steps, totals, front/behind colors, and x, y positionings
class Foot {
  constructor(good, bad, x){
      //assign step tallies
      this.good = good;
      this.bad = bad;
      this.total = this.good + this.bad;
      this.bottom_steps = ( this.bad > this.good ) ? this.good : this.bad;
      this.top_steps = (this.bad > this.good ) ? this.bad : this.good;
      //assign bar colors--the "top" bar represents the larger type of step (good[green]/bad[red])
      this.bottom_color = ( this.bad > this.good ) ? COLORS.GREEN : COLORS.RED;
      this.top_color = (this.bad > this.good ) ? COLORS.RED : COLORS.GREEN;
      //assign bar positions
      this.x_start = x;
      this.x_finish = x + BAR_WIDTH;
      this.y_bottom_start = STARTING_Y;
      this.y_top_start = 0;
      this.y_bottom_finish = 0;
      this.y_top_finish = 0;
    }
  
  set_y_bottom_finish(y){
    this.y_top_start = y;
    this.y_bottom_finish = y;
  }
  set_y_top_finish(y){
    this.y_top_finish = y;
  }
  
  update(good, bad){
      //assign step tallies
      this.good += good;
      this.bad += bad;
      this.total = this.good + this.bad;
      this.bottom_steps = ( this.bad > this.good ) ? this.good : this.bad;
      this.top_steps = (this.bad > this.good ) ? this.bad : this.good;
      //assign bar colors--the "top" bar represents the larger type of step (good[green]/bad[red])
      this.bottom_color = ( this.bad > this.good ) ? COLORS.GREEN : COLORS.RED;
      this.top_color = (this.bad > this.good ) ? COLORS.RED : COLORS.GREEN;
  }
}

//Bar class accepts a date to associate with a bar and "num" which is the number of the day in relation to today (today = 0, yesterday = 1, etc.)
class Bar {
  constructor(day, date, num){
    this.day = day;
    this.date = date;
    this.day_relation = num;
    //read the file contents into a string
    this.file_contents = require("Storage").read(this.date);
    if (this.file_contents){    //if the file exists and is not empty, then parse it into left & right foot info
      this.parse_file(this.file_contents);
    } else {                      //otherwise, assign 0's to all the left & right foot steps
      this.left = new Foot(0, 0, (num * (BAR_SPACING + (BAR_WIDTH * 2) ) ));
      this.right = new Foot(0, 0, this.left.x_finish);
    }
    this.highest_total = (this.left.total > this.right.total) ? this.left.total : this.right.total;
    this.total = (this.left.total + this.right.total);
    this.ratio = (this.right.good + this.left.good)/(this.right.bad + this.left.bad);
  }
  
  
  parse_file(contents){
    let lines = contents.split("\n");
    let leftValues = lines[0].split(" ");
    let rightValues = lines[1].split(" ");
    this.left = new Foot( parseInt(leftValues[0], 10), parseInt(leftValues[1], 10), this.day_relation * (BAR_SPACING + (BAR_WIDTH * 2)));
    this.right = new Foot( parseInt(rightValues[0], 10), parseInt(rightValues[1], 10), this.left.x_finish);
  }
  
  update(){
    let temp = require("Storage").read(this.date);
    //if (temp != this.file_contents){
      //console.log(temp);
      //console.log(this.file_contents);
      let newData = `${this.left.good} ${this.left.bad}\n${this.right.good} ${this.right.bad}`;
      require("Storage").write(this.date, newData);
      this.file_contents = require("Storage").read(this.date);
      this.highest_total = (this.left.total > this.right.total) ? this.left.total : this.right.total;
    //}
  }
}

//***************************BUTTON FUNCTIONS******************************//
function setButton() {
  var watchButton = setWatch(function () {
    clearInterval(gt);       //get rid of the game interval refresh
    gameStop();              // Stop the game
    clearWatch(watchButton); //get rid of the button watch
    menuDisplayed = true;    //make sure the menuDisplayed variable is set
    displayMenu();           // Display the menu
    displayInfo();           // Display time & battery information
  }, BTN);
}

function setButton2() {
    var watchButton = setWatch(function () {
    clearWatch(watchButton);
    clearInterval(graphInt);
    menuDisplayed = true;   //set the menuDisplayed variable for future game play
    displayMenu();          // Display the menu
    displayInfo();          //Display time & battery information
  }, BTN);
}


//****************************MENU CODE***********************************//

// Define the menu options
var menuOptions = {
  "" : { title : "SmartStepper" }, // Menu title
  "Play Game" : function() {
    E.showMenu();
    menuDisplayed = false;
    playGame(); 
  }, 
  "View Graph" : function() {
    E.showMenu();
    menuDisplayed = false;
    viewGraph();
  } 
};

// Function to handle graph selection from menu
function viewGraph() {
  console.log('Viewing Graph');
  setButton2();      //ensure the button will get us back to the menu
  graphTime();       //creates an interval for graph drawing and refresh
}

// Function to display the menu
function displayMenu() {
  g.clear();
  menuDisplayed = true;
  displayInfo();
  E.showMenu(menuOptions); // Display the menu using E.showMenu
}

// Call displayMenu to start
displayMenu();

// Call displayInfo to initially display the time and battery info
var lastMinute = '';


//*****************************GRAPH CODE************************************//

// Constants
const COLORS = {
  GREEN: "#00FF00",
  RED: "#FF0000",
  BLACK: "#000000"
};
  
const BAR_SPACING = 3;                                    //space between left & right is always 3 pixels
const BAR_WIDTH = 9;                                      //width of bar is always 7 pixels
const STARTING_X = 10;                                    //initial X position is always 10 pixels
const STARTING_DAY = 7;                                   //Today is the seventh day on the graph
const STARTING_Y = 150;                                   //initial Y position is always 150 pixels
const DAYS_OF_WEEK = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]; //Sun = 0, Sat = 6
const NUM_LABELS = 5;

var LEFT_FOOT_NAME = "LSmartStepper";
var RIGHT_FOOT_NAME = "RSmartStepper";
 

//create an array of the relevant dates
//start by getting today's date, & putting it into a string.
let todays_date = new Date();
let year = todays_date.getFullYear();
let month = todays_date.getMonth() + 1;             //returns 0-based, must add 1
let day_of_month = todays_date.getDate();
let day = todays_date.getDay();

var date_string = day_of_month + '-' + month + '-' + year;

// Calculate the date strings for the six previous days & get all date strings into an array together
var DateStrings = [];
DateStrings.push(date_string);

//create array to hold all 7 days of bars
let bars = [];
bars[7] = new Bar(DAYS_OF_WEEK[day], date_string, 7);
let j = 6;
for (let i = 1; i < 7; i++) {              //this loop creates the rest of the date strings AND the bars!
    previousDate = new Date();
    previousDate.setDate(day_of_month - i);
    new_day = previousDate.getDay();
    new_day = DAYS_OF_WEEK[new_day];      //gets the string of the actual day of the week and puts it into new_day
    new_day_of_month = previousDate.getDate();
    new_month = previousDate.getMonth() + 1;
    new_year = previousDate.getFullYear();
    new_date_string = new_day_of_month + '-' + new_month + '-' + year;
    DateStrings.push(new_date_string);
    bars[j] = new Bar(new_day, new_date_string, j);
    j--;
}

//the format of file names will be D-M-Y, as in the DateStrings array.


// Draw the graph
function drawGraph() {
  
  //figure out the max steps, & with that, the pixels per step for this graph
  let max_steps = 0;
  bars.forEach(function(bar) {
    if (bar.highest_total > max_steps) {
      max_steps = bar.highest_total;
    if (max_steps < 10){
        max_steps = 10;
      }
    }
  });

  let pix_per_step = (STARTING_Y / max_steps);

  bars.forEach(function(bar) {
    bar.left.set_y_bottom_finish( bar.left.y_bottom_start - (bar.left.bottom_steps * pix_per_step) );
    bar.left.set_y_top_finish( bar.left.y_top_start - (bar.left.top_steps * pix_per_step) );
    bar.right.set_y_bottom_finish(bar.right.y_bottom_start - (bar.right.bottom_steps * pix_per_step) );
    bar.right.set_y_top_finish(bar.right.y_top_start - (bar.right.top_steps * pix_per_step) );
  });
    // Set up the Bangle.JS LCD screen
  g.clear();
  g.setFont("6x8");
  bars.forEach(function(bar){
    //draw both left bars
    if (bar.highest_total > 0){
      g.setColor(bar.left.bottom_color);
      g.fillRect(bar.left.x_start, bar.left.y_bottom_start, bar.left.x_finish, bar.left.y_bottom_finish);
      g.setColor(bar.left.top_color);
      g.fillRect(bar.left.x_start, bar.left.y_top_start, bar.left.x_finish, bar.left.y_top_finish);

      //draw both right bars
      g.setColor(bar.right.bottom_color);
      g.fillRect(bar.right.x_start, bar.right.y_bottom_start, bar.right.x_finish, bar.right.y_bottom_finish);
      g.setColor(bar.right.top_color);
      g.fillRect(bar.right.x_start, bar.right.y_top_start, bar.right.x_finish, bar.right.y_top_finish);
    }
    //draw the L label
    g.setColor(COLORS.BLACK);
    g.setFont("4x6");
    g.drawString("L", bar.left.x_start, bar.left.y_bottom_start + 3);
    //draw the R label
    g.drawString("R", bar.right.x_start, bar.right.y_bottom_start + 3);
    //draw the day label beneath day's steps on X axis
    g.setColor(COLORS.BLACK);
    g.setFont("4x6");
    g.drawString(bar.day, bar.left.x_start, STARTING_Y + 10);
  });
  g.setFont("6x8");
  // Add Y-axis labels
  const y_increment = max_steps / NUM_LABELS;
  let j = NUM_LABELS;
  for (let i = 0; i <= NUM_LABELS; i++) {
      const label_value = Math.round(i * y_increment);
      const y_position = (STARTING_Y/NUM_LABELS) * j;
      j--;
      g.setColor(COLORS.BLACK);
      g.drawString(label_value.toString(), 0, y_position);
  }
  g.flip();
}

function graphTime() {
  graphInt = setInterval(() => {
      updateBars();
      drawGraph();
  }, 100); // 60000 milliseconds = 1 minute

  var  on = false;
  return;
}

function updateBars(){
  bars[7].update();

  //get current date string to compare to most recent bar date
  let temp_date = new Date();
  let temp_year = todays_date.getFullYear();
  let temp_month = todays_date.getMonth() + 1;             //returns 0-based, must add 1
  let temp_day_of_month = todays_date.getDate();
  let temp_day = todays_date.getDay();
  var temp_date_string = day_of_month + '-' + month + '-' + year;
  //if it's a new day, need to move all bars & dates down one in their arrays, and create a new bar for today's date, add it to the bar array, and add new date to the date array
  if (temp_date_string != bars[7].date){ 
    for (i = 0; i < 7; i++){
      bars[i] = bars[i + 1];
      Date_Strings[i] = Date_Strings[i + 1];
    }
    Date_Strings[7].push(temp_date_string);
    bars[7] = new Bar(temp_day, temp_date_string, 7);
  }
}

//****************************GAME PLAY***********************************//
//the lives class needs to keep track of the amount of steps taken today and yesterday.
//with 0 steps, the day starts with 0 lives.
//if today's ratio is better than yesterday's, an extra 3 lives is added.
//For every 1000 steps taken, another 3 lives is added.
let LIVES = 100;        //variable to keep track of current number of lives
let PREV_STEPS = 0;
let STEP_THRESHOLD = 250;
let init_bool = 0;
let ratio_bool = 0;
let step_count_bool = 0;

function calc_lives(){
  bars[7].update();
  //get current date string to compare to most recent bar date
  let temp_date = new Date();
  let temp_year = todays_date.getFullYear();
  let temp_month = todays_date.getMonth() + 1;             //returns 0-based, must add 1
  let temp_day_of_month = todays_date.getDate();
  let temp_day = todays_date.getDay();
  var temp_date_string = day_of_month + '-' + month + '-' + year;
  //if it's a new day, need to move all bars & dates down one in their arrays, and create a new bar for today's date, add it to the bar array, and add new date to the date array
  if (temp_date_string != bars[7].date) {
    ratio_bool = 0;
    step_count_bool = 0;
    LIVES = 100;                                              //<<<<<<<<<<<<should be changed back to LIVES = 3 to start the game out with 3 lives
    updateBars();
  }

  let current_steps = bars[7].total;
  if (current_steps > 2000 && step_count_bool == 0){          //if the user takes more than 2000 steps in a day, they get 3 lives (just once for the day, hence the bool)
    LIVES += 3;
    step_count_bool = 1;
  }
    
  if ( (current_steps > 250) && (bars[7].ratio > bars[6].ratio) && (ratio_bool == 0)){      //if today's ratio is better than yesterday's, 3 lives awarded (just once for the day, hence the bool)
    LIVES += 3;
    ratio_bool = 1;
  }
  if (step_count_bool == 1){                                  //once the 2000 number is hit, an extra life for every 250 steps is awarded
    let steps_difference = current_steps - PREV_STEPS;
    if (steps_difference >= 250){
        let lives_increase = (steps_difference / STEP_THRESHOLD) | 0; // Integer division, will provide one life per extra 250 steps, and 0 for less
        LIVES += lives_increase;
        PREV_STEPS = current_steps;        //move the current calculated steps into the PREV for next call of function... but only if they've been awarded the lives. Otherwise, let them keep their last number until they get to the next 250 increment
    }
  }
  return;
}

var Y;
var BIRDIMG = E.toArrayBuffer(atob("EQyI/v7+/v7+/gAAAAAAAP7+/v7+/v7+/gYG0tLS0gDXAP7+/v7+/v4A0tLS0tIA19fXAP7+/v4AAAAA0tLS0gDX1wDXAP7+ANfX19cA0tLSANfXANcA/v4A19fX19cA0tLSANfX1wD+/gDS19fX0gDS0tLSAAAAAAD+/gDS0tIA0tLS0gDAwMDAwAD+/gAAAM3Nzc0AwAAAAAAA/v7+/v4Azc3Nzc0AwMDAwAD+/v7+/v4AAM3Nzc0AAAAAAP7+/v7+/v7+AAAAAP7+/v7+/g=="));
var FLOORIMG = require("heatshrink").decompress(atob("iEKxH+kklABuLAAlgAAwNFB34OLmAAO0YAO5wAOA"));
var birdy, birdvy;
var floorpos = 0;
var running = false;
var barriers;
var score;

if (process.env.HWVERSION==2) {
                      // we have offscreen graphics, so just go direct
  b = g;
  Y = 24;             // widgets
} else {
  b = Graphics.createArrayBuffer(120,120,8);
  var gimg = {
      width:120,
      height:104,
      bpp:8,
      buffer:b.buffer
    };
  b.flip = function() {
    g.drawImage(gimg,0,24,{scale:2});
  };
  Y = 0;               // we offset for widgets anyway
}

function newBarrier(x) {
  barriers.push({
    x1 : x-7,
    x2 : x+7,
    y : Y+20+Math.random()*38,
    gap : 12+Math.random()*15
  });
}

function gameStart() {
  calc_lives();
  if (LIVES > 0){
    running = true;
    b = g;
    Y = 24; // widgets
    birdy = Y + 48/2;
    birdvy = 0;
    barriers = [];
    for (var i=38;i<g.getWidth();i+=38)
      newBarrier(i);
    score = 0;
  }
  else {
    gameStop();
  }
}

function gameStop() {
  running = false;
}

function draw() {
  "ram";
  var H = b.getHeight() - 24;
  b.clear();                   // Clear the screen before drawing

  // Draw lives
  b.setFont("6x8").setColor("#000000").drawString("Lives: " + LIVES, g.getWidth() / 2, 5);

  // Draw the rest of the game elements
  b.setColor("#71c6cf").fillRect(0, Y, b.getWidth(), H - 1);
  floorpos++;
  for (var x = -(floorpos & 15); x < b.getWidth(); x += 16)
    b.drawImage(FLOORIMG, x, H);

  if (!running) {
    if (!gameOverHandled) {     // Check if game over event has already been handled
      gameOverHandled = true;   // Set flag to indicate game over event has been handled
      if (LIVES > 0) {
        LIVES -= 1;             // Subtract lives only if there are lives remaining
        calc_lives();           // Calculate lives if the game is not running
      }
    }
    var x = b.getWidth() / 2;
    b.setColor("#000000");
    b.setFontAlign(0, 0);
    if (LIVES <= 0) {
      b.setFont("4x6", 2).drawString("You have no lives!", x, 20 + Y);
      b.drawString("Take steps to play", x, 40 + Y);
      b.drawString("Press button for menu", x, 76 + Y);
      b.flip();
      return;
    } else {
      b.setFont("4x6", 2).drawString("GAME OVER!", x, 20 + Y);
      b.setFont("6x8", 2).drawString("Score", x, 40 + Y).drawString(score, x, 56 + Y);
      b.setFont("4x6", 1).drawString("Tap screen to", x, 76 + Y).drawString("restart and flap", x, 84 + Y).drawString("Press button for menu", x, 92 + Y);
      b.flip();
    }
    return;
  }

  // Reset the game over handled flag when the game is running
  gameOverHandled = false;

  score++;
  birdvy += 0.4;
  birdvy *= 0.9;
  birdy += birdvy;
  if (birdy > H)
    gameStop();
  // draw bird
  b.drawImage(BIRDIMG, 6, birdy, { rotate: Math.atan2(birdvy, 15) });
  // draw barriers
  barriers.forEach(function (r) {
    r.x1--;
    r.x2--;
    var btop = r.y - r.gap;
    var bbot = r.y + r.gap;
    b.setColor("#73bf2f").fillRect(r.x1 + 4, Y, r.x2 - 4, btop - 1).fillRect(r.x1 + 4, bbot, r.x2 - 4, H - 1); // middle
    b.setColor("#c0f181").fillRect(r.x1 + 1, Y, r.x1 + 3, btop - 1).fillRect(r.x1 + 1, bbot, r.x1 + 3, H - 1); // left
    b.setColor("#538917").fillRect(r.x2 - 3, Y, r.x2 - 1, btop - 1).fillRect(r.x2 - 3, bbot, r.x2 - 1, H - 1); // right
    b.setColor("#808080").drawRect(r.x1, btop - 5, r.x2, btop).drawLine(r.x1 + 1, Y, r.x1 + 1, btop - 6).drawLine(r.x2 - 2, Y, r.x2 - 2, btop - 6); // top
    b.drawRect(r.x1, bbot, r.x2, bbot + 5).drawLine(r.x1 + 1, bbot + 6, r.x1 + 1, H - 1).drawLine(r.x2 - 1, bbot + 6, r.x2 - 1, H - 1); // bottom
    if (r.x1 < 6 && (birdy - 3 < btop || birdy + 3 > bbot))
      gameStop();
  });
  while (barriers.length && barriers[0].x2 <= 0) {
    barriers.shift();
    newBarrier(g.getWidth());
  }

  b.flip();
}


Bangle.on('touch', function(button) {
  if (running) {
    // Handle touch event during game play
    birdvy -= 4; // Example action during game play (flapping)
  } else if (!menuDisplayed && LIVES > 0) {
    // Game is not running and menu is not displayed
    gameStart(); // Start the game
  }
  // No action needed if menu is displayed
});


// Function to handle playing the game
function playGame() {
  console.log('Playing Game');
  barriers = [];
  score = 0;
  Bangle.loadWidgets();
  g.clear();
  Bangle.drawWidgets();
  b.setBgColor("#e3db9d");
  gameStart();
  clearInterval(gt);
  gt = setInterval(draw, 100);

  setButton(); // Set up the button to stop the game and display the menu
}


//******************************************BLUETOOTH CODE***********************************************//

function delayms(ms)
{
  return new Promise(resolve => setTimeout(resolve, ms));
}

var leftGoodStepsSinceConnect = 0;
var leftBadStepsSinceConnect = 0;
var rightGoodStepsSinceConnect = 0;
var rightBadStepsSinceConnect = 0;

function updateLeftGoodSteps(steps)
{
  console.log("left good steps " + steps);
  // add good steps to left foot
  bars[7].left.update(steps - leftGoodStepsSinceConnect, 0);
  leftGoodStepsSinceConnect = steps;
}

function updateRightGoodSteps(steps)
{
  console.log("right good steps " + steps);
  // add good steps to right foot
  bars[7].right.update(steps - rightGoodStepsSinceConnect, 0);
  rightGoodStepsSinceConnect = steps;
}

function updateLeftBadSteps(steps)
{
  console.log("left bad steps " + steps);
  // add bad steps to left foot
  bars[7].left.update(0, steps - leftBadStepsSinceConnect);
  leftBadStepsSinceConnect = steps;
}

function updateRightBadSteps(steps)
{
  console.log("right bad steps " + steps);
  // add bad steps to right foot
  bars[7].right.update(0, steps - rightBadStepsSinceConnect);
  rightBadStepsSinceConnect = steps;
}

function updateGoodSteps(steps, footName)
{
  if (footName === LEFT_FOOT_NAME)
  {
    updateLeftGoodSteps(steps);
  }
  else
  {
    updateRightGoodSteps(steps);
  }
}

function updateBadSteps(steps, footName)
{
  if (footName === LEFT_FOOT_NAME)
  {
    updateLeftBadSteps(steps);
  }
  else
  {
    updateRightBadSteps(steps);
  }
}

// randomly generated uuid
var STEPPER_SERVICE_UUID = '936f7a1c-052d-4dda-b676-db64cc778da5';
// could not figure out how to get bangle.js to recognize full length uuid's for characteristics
// so for the proof of concept, i used these short uuid's.
// the final product should eventually have its own uuid's as i believe these conflict with the standards
var GOOD_STEPS_CHARACTERISTIC_UUID = '0xbeef';
var BAD_STEPS_CHARACTERISTIC_UUID = '0xcafe';

var LEFT_FOOT_NAME = "LSmartStepper";
var RIGHT_FOOT_NAME = "RSmartStepper";

let gattServers = {};
let bleCharacteristics = {};
let goodChar = {};
let badChar = {};

function decodeAsciiString(bytes) {
    return String.fromCharCode.apply(null, bytes);
}

// read and interpret the data from the BLE "good" characteristic
function readMixedGoodCharacteristic(event) {
    const data = event.target.value; // This is a DataView
    const buffer = data.buffer; // Get the ArrayBuffer from the DataView

    // Get uint32 from the first 4 bytes
    const uint32Value = data.getUint32(0, true); // true for little-endian
    console.log(`Uint32: ${uint32Value}`);

    // Read the last byte as an ASCII string
    const stringBytes = new Uint8Array(buffer).slice(data.byteLength - 1);
    const stringValue = decodeAsciiString(stringBytes); // Fallback for ASCII decoding
    console.log(`String: ${stringValue}`);

    // due to the weird scoping issues of javascript, i had to include a left or right
    // identifier in the charactersistic data being sent, to double check which foot its
    // coming from.
    if (stringValue === "L") {
        updateLeftGoodSteps(uint32Value);
    } else if (stringValue === "R") {
        updateRightGoodSteps(uint32Value);
    }
}

// read and interpret the data from the BLE "bad" characteristic
function readMixedBadCharacteristic(event) {
    const data = event.target.value; // This is a DataView
    const buffer = data.buffer; // Get the ArrayBuffer from the DataView

    // Get uint32 from the first 4 bytes
    const uint32Value = data.getUint32(0, true); // true for little-endian
    console.log(`Uint32: ${uint32Value}`);

    // Read the last byte as an ASCII string
    const stringBytes = new Uint8Array(buffer).slice(data.byteLength - 1);
    const stringValue = decodeAsciiString(stringBytes); // Fallback for ASCII decoding
    console.log(`String: ${stringValue}`);

    // due to the weird scoping issues of javascript, i had to include a left or right
    // identifier in the charactersistic data being sent, to double check which foot its
    // coming from.
    if (stringValue === "L") {
        updateLeftBadSteps(uint32Value);
    } else if (stringValue === "R") {
        updateRightBadSteps(uint32Value);
    }
}

// setup notifications for the "good" step BLE characteristic
function setupGoodCharacteristicNotifications(characteristic) {
    return new Promise((resolve, reject) => {
        console.log("Enabling notifications for characteristic: " + characteristic.uuid);
        characteristic.startNotifications()
        .then(() => {
            characteristic.on('characteristicvaluechanged', readMixedGoodCharacteristic);
            console.log("Notifications enabled for characteristic: " + characteristic.uuid);
            resolve();
        })
        .catch(error => {
            console.error(`Error setting up notifications for ${LEFT_FOOT_NAME}: ${error}`);
            reject(error);
        });
    });
}

// setup notifications for the "bad" step BLE characteristic
function setupBadCharacteristicNotifications(characteristic) {
    return new Promise((resolve, reject) => {
        console.log("Enabling notifications for characteristic: " + characteristic.uuid);
        characteristic.startNotifications()
        .then(() => {
            characteristic.on('characteristicvaluechanged', readMixedBadCharacteristic);
            console.log("Notifications enabled for characteristic: " + characteristic.uuid);
            resolve();
        })
        .catch(error => {
            console.error(`Error setting up notifications for ${LEFT_FOOT_NAME}: ${error}`);
            reject(error);
        });
    });
}

// function used to connect to a foot
function connectToFoot(footName) {
    return new Promise((resolve, reject) => {
        if (gattServers[footName] && gattServers[footName].connected) {
            console.log(`${footName} is already connected.`);
            resolve();
            return;
        }
        console.log(`Starting connection process for ${footName}...`);
        NRF.requestDevice({ filters: [{ name: footName }] })
            .then(device => {
                console.log(`Device found ${device.name}`);
                console.log("Connecting...");
                return device.gatt.connect();
            })
            .then(gatt => {
                gattServers[footName] = gatt;
                console.log("Connected, getting services...");
                gatt.device.on('gattserverdisconnected', () => onDisconnected(footName));
                return delayms(1000).then(() => gatt.getPrimaryService(STEPPER_SERVICE_UUID));
            })
            .then(service => {
                console.log("Service found:", service.uuid);
                return service.getCharacteristics();
            })
            .then(characteristics => {
                bleCharacteristics[footName] = characteristics;
                console.log(`Found ${bleCharacteristics[footName].length} characteristics for ${footName}:`);
                let goodCharacteristic = bleCharacteristics[footName].find(c => c.uuid === GOOD_STEPS_CHARACTERISTIC_UUID);
                if (!goodCharacteristic) {
                    throw new Error("Good Steps characteristic not found");
                }
                return setupGoodCharacteristicNotifications(goodCharacteristic);
            })
            .then(() => {
                let badCharacteristic = bleCharacteristics[footName].find(c => c.uuid === BAD_STEPS_CHARACTERISTIC_UUID);
                if (!badCharacteristic) {
                    throw new Error("Bad Steps characteristic not found");
                }
                return setupBadCharacteristicNotifications(badCharacteristic);
            })
            .then(() => {
                console.log(`${footName} setup complete.`);
                resolve();
            })
            .catch(error => {
                console.error("Error during Bluetooth operation for " + footName + ": " + error);
                setTimeout(() =>
                {
                  console.log(`Retrying...`);
                  connectSequentially(); // Attempt to reconnect
                }, 2000);
                reject(error);  // Reject the promise on error
            });
    });
}

// function used to ensure connecting to the feet sequentially
// as by default javascript is an asynchronous language, and has issues connecting to
// more than one BLE device at the same time.
function connectSequentially() {
  connectToFoot(LEFT_FOOT_NAME)
    .then(() => {
      console.log("Left foot connected successfully. Now connecting right foot...");
      return connectToFoot(RIGHT_FOOT_NAME);
    })
    .then(() => {
      console.log("Right foot connected successfully.");
    })
    .catch(error => {
      console.error("Error in sequential connection process", error);
      // Handle any errors that occurred during the connection attempts
    });
}

// function used to cleanup connection info for the left foot when disconnected, and to start the reconnect process
function onLeftDisconnected()
{
  console.log(`${LEFT_FOOT_NAME} disconnected. Attempting to reconnect...`);
  leftGoodStepsSinceConnect = 0;
  leftBadStepsSinceConnect = 0;
  if (gattServers[LEFT_FOOT_NAME] && gattServers[LEFT_FOOT_NAME].connected)
  {
    gattServers[LEFT_FOOT_NAME].disconnect() // Explicitly disconnect if we are somehow still connected
    .then(() =>
    {
      console.log("Disconnected from GATT server.");
    })
    .catch(error2 =>
    {
      console.log("Error disconnecting GATT server: " + error2);
    });
    gattServers[LEFT_FOOT_NAME] = null;
    leftFootCharacteristics = null;
  }
  setTimeout(() =>
  {
    console.log(`Attempting to reconnect to ${LEFT_FOOT_NAME}...`);
    connectToFoot(LEFT_FOOT_NAME); // Attempt to reconnect
  }, 1000);
}

// function used to cleanup connection info for the right foot when disconnected, and to start the reconnect process
function onRightDisconnected()
{
  console.log(`${RIGHT_FOOT_NAME} disconnected. Attempting to reconnect...`);
  rightGoodStepsSinceConnect = 0;
  rightBadStepsSinceConnect = 0;
  if (gattServers[RIGHT_FOOT_NAME] && gattServers[RIGHT_FOOT_NAME].connected)
  {
    gattServers[RIGHT_FOOT_NAME].disconnect() // Explicitly disconnect if we are somehow still connected
    .then(() =>
    {
      console.log("Disconnected from GATT server.");
    })
    .catch(error2 =>
    {
      console.log("Error disconnecting GATT server: " + error2);
    });
    gattServers[RIGHT_FOOT_NAME] = null;
    rightFootCharacteristics = null;
  }
  setTimeout(() =>
  {
    console.log(`Attempting to reconnect to ${RIGHT_FOOT_NAME}...`);
    connectToFoot(RIGHT_FOOT_NAME); // Attempt to reconnect
  }, 1000);
}

function onDisconnected(footName)
{
  if (footName === LEFT_FOOT_NAME)
  {
    onLeftDisconnected();
  }
  else
  {
    onRightDisconnected();
  }
}

// Initiate the sequential connection process
connectSequentially();
