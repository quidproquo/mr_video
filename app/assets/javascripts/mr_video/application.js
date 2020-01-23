// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require_tree ./jquery
//= require_tree ./bootstrap
//= require_tree ./dataTables

$(document).ready(function() {
  var t = $(".table").DataTable({
    fixedHeader: {headerOffset: $('.navbar').outerHeight()},
    lengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']],
    order: [[1, 'asc']],
    stateSave: true
  });

  t.on( 'order.dt search.dt', function() {
    t.column(0, {search:'applied', order:'applied'}).nodes().each(function(cell, i) {
      cell.innerHTML = i+1;
    });
  }).draw();
});
