/**
 *
 * Created by Matthias on 10/6/14.
 * Destroyed by Nico on 10/29/14.
 */

var clear;
var correct_words = "";
var start_time = new Date().getTime();
var wpm;

GameLogic = {
  process_input: function(input)
  {
    console.log("input: " + input);
    var text_arr  = get_text().split("");
    var input_arr = input.split("");

    var r   = [];
    var b = correct_words;
    var g;

    for( i = 0; i < input_arr.length; i++)
    {
      if( text_arr[i+correct_words.length] == input_arr[i] && r.length == 0)
      {
        b += input_arr[i]
        if( input_arr[i] == ' ' )
        {
            clear = true;
            correct_words += input;
            input = "";
            wpm = calculate_wpm();
        }
      }
      else
      {
        r.push(text_arr[i+correct_words.length]);
      }
    }
    g = text_arr.slice(correct_words.length+input.length).join("")

    return {advance: clear, black:b, red:r.join(""), gray:g};
  }
};

function get_text()
{
   return "The quick brown fox jumped over the slow lazy dog"
}

function calculate_wpm(){

    var end_time = new Date().getTime();

    var diff = end_time - start_time;

    diff = diff/60000; // Convert to Minutes

    total_entries = correct_words.length;

    var gwpm = (total_entries/5)/ diff; //Gross Words Per Minute

    return gwpm;

}
