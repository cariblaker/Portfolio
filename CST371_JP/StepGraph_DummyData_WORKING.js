

// Initialize data for the week's steps
let left_steps_data = require("Storage").readJSON("stepsData.json") || [];
if (!left_steps_data.length) {
  // Provide default data if the file is not found or invalid
  left_steps_data = [
    { day: 'Mon', steps: { good: 100, bad: 100 } },
    { day: 'Tue', steps: { good: 70, bad: 150 } },
    { day: 'Wed', steps: {good: 80, bad: 50 } },
    { day: 'Thr', steps: { good: 90, bad: 76 } },
    { day: 'Fri', steps: { good: 95, bad: 90 } },
    { day: 'Sat', steps: { good: 10, bad: 50 } },
    { day: 'Sun', steps: { good: 100, bad: 200 } }
  ];
}

let right_steps_data = require("Storage").readJSON("stepsData.json") || [];
if (!right_steps_data.length) {
  // Provide default data if the file is not found or invalid
  right_steps_data = [
    { day: 'Mon', steps: { good: 100, bad: 50 } },
    { day: 'Tue', steps: { good: 100, bad: 150 } },
    { day: 'Wed', steps: { good: 200, bad: 50 } },
    { day: 'Thr', steps: { good: 300, bad: 76 } },
    { day: 'Fri', steps: { good: 90, bad: 90 } },
    { day: 'Sat', steps: { good: 200, bad: 100 } },
    { day: 'Sun', steps: { good: 200, bad: 200 } }
  ];
}


//else, we'll have to parse the info from the file(s?) into the left_steps_data array & right_steps_data array.

const green = "#00FF00";
const red = "#FF0000";
const screen_size = 240;
const y_offset = 150;
const num_labels = 5;  




class Bar {  //the class that constructs a day's bar on the graph, including good/bad, left/right steps for the day

  constructor(data_left, data_right, x, y){
    if (data_left.day != data_right.day){ 
      console.log("ERROR!!!! Days for feet do not match!!!!");
    }
    this.day = data_left.day;          //the day that will be printed on the X axis under the bar
    this.left_good = data_left.steps.good;
    this.left_bad = data_left.steps.bad;
    this.right_good = data_right.steps.good;
    this.right_bad = data_right.steps.bad;
    this.left_front_num = (this.left_good > this.left_bad) ? this.left_bad : this.left_good;  //gives number of steps for front bar left foot
    this.left_behind_num = (this.left_good > this.left_bad) ? this.left_good : this.left_bad;  //gives number of steps for behind bar left foot
    this.right_front_num = (this.right_good > this.right_bad) ? this.right_bad : this.right_good; 
    this.right_behind_num = (this.right_good > this.right_bad) ? this.right_good : this.right_bad;
    this.left_front_color = (this.left_bad > this.left_good) ? green : red;
    this.left_behind_color = (this.left_bad > this.left_good) ? red : green;
    this.right_front_color = (this.right_bad > this.right_good) ? green : red;
    this.right_behind_color = (this.right_bad > this.right_good) ? red : green;
    this.left_total = this.left_good + this.left_bad;
    this.right_total = this.right_good + this.right_bad;
    //bar positioning
    this.x_pos_left = x;
    this.width = 7;
    //this.x_pos_right = x + this.width + this.space;
    this.y_pos_front = y;
    //this.y_pos_behind =              <<<<<<<<<<<not really possible to calculate here the way things are....

    this.space = 2;
    this.x_pos_right = x + this.width + this.space;
  }

}

//create the Bar objects for the graph, put them in an array called "bars"
    let bars = [];
    let x = 10;
    for (i = 0; i < 7; i++){                                                  //y stays the same 
      bars[i] = new Bar(left_steps_data[i], right_steps_data[i], x, y_offset);
      x = bars[i].x_pos_right + (bars[i].width * 2) + bars[i].space;                        //x becomes the position of the last bar, plus the two bars of the last day, plus the space to be put in between days.
        }


  //figure out the max steps, and pixels per step for this graph
let max_steps = 0;

bars.forEach(function(bar) {
  if (bar.left_total > max_steps) {
    max_steps = bar.left_total;
  }

  if (bar.right_total > max_steps) {
    max_steps = bar.right_total;
  }
});

let pix_per_step = (y_offset / max_steps);

  // Set up the Bangle.JS LCD screen
g.clear();
g.setFont("6x8");


// Draw the graph
function drawGraph() {
  
  bars.forEach(function(bar){

    // Draw left foot front bar
    g.setColor(bar.left_front_color);
    g.fillRect(bar.x_pos_left, bar.y_pos_front, (bar.x_pos_left + bar.width), (bar.y_pos_front - (bar.left_front_num * pix_per_step) ) );

  //Draw left foot behind bar
    g.setColor(bar.left_behind_color);
    let y_front_start = bar.y_pos_front - (bar.left_front_num * pix_per_step);
    let x_front_end = bar.x_pos_left + bar.width;
    let y_front_end = (y_front_start - ( bar.left_behind_num * pix_per_step ));
    g.fillRect( bar.x_pos_left, y_front_start, x_front_end, y_front_end );
    
    g.setColor("#000000");
    g.setFont("4x6");
    g.drawString("L", bar.x_pos_left, y_offset + 3);

    // Draw right foot front bar
    g.setColor(bar.right_front_color);
    g.fillRect(bar.x_pos_right, bar.y_pos_front, (bar.x_pos_right + bar.width), (bar.y_pos_front - (bar.right_front_num * pix_per_step) ) );
    
    //Draw right foot behind bar
    g.setColor(bar.right_behind_color);
    let right_y_front_start = bar.y_pos_front - (bar.right_front_num * pix_per_step);
    let right_x_front_end = bar.x_pos_right + bar.width;
    let right_y_front_end = (right_y_front_start - ( bar.right_behind_num * pix_per_step ));
    g.fillRect( bar.x_pos_right, right_y_front_start, right_x_front_end, right_y_front_end );
    
    g.setColor("#000000");
    g.setFont("4x6");
    g.drawString("R", bar.x_pos_right, y_offset + 3);

    // Display day label beneath day's steps on the x-axis
    g.setColor("#000000");
    g.setFont("6x8");
    g.drawString(bar.day, bar.x_pos_left, y_offset + 10);

  });
  
  g.setFont("6x8");
  // Add Y-axis labels
  const y_increment = max_steps / (num_labels);
  let j = num_labels;
  for (let i = 0; i <= num_labels; i++) {
      const label_value = Math.round(i * y_increment);
      const y_position = (y_offset/num_labels) * j;
      j--;
      g.setColor("#000000");
      g.drawString(label_value.toString(), 0, y_position);
  }

  
  // Update the screen
  g.flip();
}

// Draw the initial graph
drawGraph();

