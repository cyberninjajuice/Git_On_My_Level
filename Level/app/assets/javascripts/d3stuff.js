$(document).ready(function(){
// var data = [
//   ["Javascript", 2312],
//   ["Ruby", 674], 
//   ["Go", 994], 
//   ["Ios", 3433], 
//   ["Python", 127],
//   ["HTML/CSS", 2261]
// ];
//console.log(data);
if( document.getElementById("user-data")){
var data = document.getElementById("user-data").innerText();
console.log(data);
var chart = document.getElementById("chart"),
    axisMargin = 20,
    margin = 20,
    valueMargin = 4,
    width = chart.offsetWidth,
    height = chart.offsetHeight,
    barHeight = (height-axisMargin-margin*2)* 0.4/data.length,
    barPadding = (height-axisMargin-margin*2)*0.6/data.length,
    data, bar, svg, scale, xAxis, labelWidth = 0;

max = d3.max(data.map(function(i){ 
  return i[1];
}));

svg = d3.select(chart)
  .append("svg")
  .attr("width", width)
  .attr("height", 400);


bar = svg.selectAll("g")
  .data(data)
  .enter()
  .append("g");

bar.attr("class", "bar")
  .attr("cx",0)
  .attr("transform", function(d, i) { 
     return "translate(" + margin + "," + (i * (barHeight + barPadding) + barPadding) + ")";
  });

bar.append("text")
  .attr("class", "label")
  .attr("y", barHeight / 2)
  .attr("dy", ".35em") //vertical align middle
  .text(function(d){
    return d[0];
  }).each(function() {
    labelWidth = Math.ceil(Math.max(labelWidth, this.getBBox().width));
  });

scale = d3.scale.linear()
  .domain([0, max])
  .range([0, width - margin*2 - labelWidth]);

bar.append("rect")
  .attr("transform", "translate("+labelWidth+", 0)")
  .attr("height", barHeight)
  .attr("width", function(d){
    return scale(d[1]);
  });

bar.append("text")
  .attr("class", "value")
  .attr("y", barHeight / 2)
  .attr("dx", -valueMargin + labelWidth) //margin right
  .attr("dy", ".35em") //vertical align middle
  .attr("text-anchor", "end")
  .text(function(d){
    return d[1];
  })
 .attr("x", function(d){
    var width = this.getBBox().width;
    return Math.max(width + valueMargin, scale(d[1]));
  });

svg.insert("g",":first-child")
 .attr("class", "axis")
 .attr("transform", "translate(" + (margin + labelWidth) + ","+ (height - axisMargin - margin)+")")
 .call(xAxis);
}
})