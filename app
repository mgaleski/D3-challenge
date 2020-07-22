var imageWidth = 1000;
var imageHeight = 500;

var width = 850;
var height = 350;

var scatterPlot = d3.select("#scatterplot").append("svg").attr("width", imageWidth).attr("height", imageHeight);

var transformChart = scatterPlot.append("g").attr("transform", "translate(100, 50)");

d3.csv("data.csv").then(plot);

function plot(importedData) {

    importedData.map(function (data) {
        data.healthcare =+ data.healthcare;
        data.obesity =+ data.obesity;
    });

    var xLinearScale = d3.scaleLinear()
        .domain([4.6, d3.max(importedData, d => d.healthcare)])
        .range([0, width]);

    var yLinearScale = d3.scaleLinear()
        .domain([20, d3.max(importedData, d => d.obesity)])
        .range([height, 0]);

    var bottomAxis = d3.axisBottom(xLinearScale)
        .ticks(7);
    var leftAxis = d3.axisLeft(yLinearScale);

    transformChart.append("g")
        .attr("transform", `translate(0, ${height})`)
        .call(bottomAxis);
    transformChart.append("g")
        .call(leftAxis);


    var circlesGroup = transformChart.selectAll("circle").data(importedData).enter().append("circle");

        circlesGroup.attr("cx", d => xLinearScale(d.healthcare)).attr("cy", d => yLinearScale(d.obesity)).attr("r", "15");

    var circlesGroupText = transformChart.selectAll().data(importedData).enter().append("text");

    circlesGroupText.attr("x", d => xLinearScale(d.healthcare)).attr("y", d => yLinearScale(d.obesity))
        .style("font-size", "12px").style("text-anchor", "middle").style('fill', 'white').text(d => (d.abbr));

    transformChart.append("text").attr("transform", "rotate(-90)").attr("y", -50).attr("x", -175).attr("class", "axisText").text("obesity %");

    transformChart.append("text").attr("transform", "translate(350, 400)").attr("class", "axisText").text("healthcare %");
}
