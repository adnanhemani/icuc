// setTimeout(function(){
//   $('body').addClass('loaded');
//   $('h1').css('color', '#222');
// }, 100);

$(document).on('page:change', function() {
    $('#demo').click(function() {
        document.getElementById("demo").value = "Loading..."; 
        $('#slow_warning').show();
//         $('#slower_warning').show();
//         var iDiv = document.createElement('div');
//         iDiv.id = 'block';
//         iDiv.className = 'loader-wrapper';
//         document.getElementsByTagName('body')[0].appendChild(iDiv);
//         var innerDiv = document.createElement('div');
//         innerDiv.className = 'loader';
//         iDiv.appendChild(innerDiv);
//         $('body').addClass('loaded');
//         $('h1').css('color', '#222');
//         setTimeout(function(){
//         $('body').addClass('loaded');
//         $('h1').css('color', '#222');
//         }, 5000);
    });
});
