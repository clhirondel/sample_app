// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
  $(function() {
    //Chronometer for prospects   
    if ($('input[name="prospect[timespent]"]').length) { // implies *not* zero
        var time_parser = /^([0-9]{2}):([0-9]{2}):([0-9]{2})$/
        var timer=$('input[name="prospect[timespent]"]').attr('value', timer);                
        var parserMatches = time_parser.exec(timer);
        var hour=parseInt(parserMatches[1]);
        var minutes=parseInt(parserMatches[2]);
        var sec=parseInt(parserMatches[3]);

        chronometer = setInterval(function(){
            sec++;
            if (sec==60) {minutes++; sec = 0;}
            if (sec <10) timer=":0"+sec;
            else timer = ":"+sec;
            if (minutes==60) {hour++; minutes = 0;}
            if (minutes<10) timer = ':0'+minutes+timer;
            else timer = ':'+minutes+timer;
            if (hour<10) timer='0'+hour+timer;
            else timer = hour + timer;
            $('input[name="prospect[timespent]"]').attr('value', timer);                
        }, 1000);
    };

        //Char counter for Microposts (MAX 140)
        $('#micropost_content').keyup(function(){
          var content_length = $('#micropost_content').val().length;
          var remaining = 140 - content_length;
          $('#char_count').html(remaining);
        });
    
    //ProgressBar Init
    $( '#progressbar' ).progressbar({
        value: 0
    });
    $("#progresstext").html("0%");
    
    //ProgressBar Function
    //When key in
    progressbar = setInterval(function(){
        var nb_fields = 0;
        var nb_error_fields = 0;
        var nb_error_empty_fields = 0;
        var nb_empty_fields = 0;

        var percentage = 0;
        
        $('form .field_with_errors input').each(function(){
           nb_error_fields+=1;
           if(!$(this).val()){
               nb_error_empty_fields +=1;
           }
        });
        
        $('form .field input').each(function(){
           nb_fields+=1;
           if(!$(this).val()){
               nb_empty_fields +=1;
           };
        });
         
        percentage += ((nb_fields-nb_error_fields-nb_empty_fields+nb_error_empty_fields)/(nb_fields))*100;
        var pGress = setInterval(function() {
            var pVal = $('#progressbar').progressbar('option', 'value');
            var pCnt = 0;
                
            if (pVal <= percentage) {
                pCnt = !isNaN(pVal) ? (pVal + 1) : 1;
                if (pCnt > percentage) {
                    clearInterval(pGress);
                } else {
                    $('#progressbar').progressbar({value: Math.round(pCnt), easing: 'easeInOutQuint'});
                    $("#progresstext").html((pCnt)+"%");    
            } 
            } else {
                pCnt = !isNaN(pVal) ? (pVal - 1) : 1;
                if (pCnt < percentage) {
                    clearInterval(pGress);
                } else {
                    $('#progressbar').progressbar({value: Math.round(pCnt), easing: 'easeInOutQuint'});
                    $("#progresstext").html((pCnt)+"%");    
            } 
            }
        },100); 
        
            
        var submitButton = $("#validate_box > .actions > input[type='submit']");
        if (nb_error_fields>0) {

            $(submitButton).attr("disabled", "true");
        }
        else{
            $(submitButton).removeAttr('disabled');
        } 
        
    }, 1000);
    
    //Radion button hide/show <p>
    $('input[name="prospect[prospect_status]"]').each(function () {
        if (!$(this).is(':checked')){
        var test = $(this).attr("id");
        $('p[id="'+test +'"]').hide();
        }
    });
    $('input[name="prospect[prospect_status]"]').change(function() { 
      var test = $(this).attr("id");
        $('p[class="hidden_fields"]').fadeOut("medium").delay(800);
        $('p[id="'+test+'"]').fadeIn(400);
      }); 
      
      $( ".datepicker" ).datetimepicker({
          regional: 'fr',
          minDate: '0',
          duration: '',  
          showTime: true,  
         constrainInput: true,  
         stepMinutes: 15,  
         altTimeField: '',  
         time24h: true  //set today as minimum date
      });
      $.datepicker.regional['fr'] = {clearText: 'Effacer', clearStatus: '', closeText: 'Fermer', closeStatus: 'Fermer sans modifier', prevText: '<Préc', prevStatus: 'Voir le mois précédent', nextText: 'Suiv>', nextStatus: 'Voir le mois suivant', currentText: 'Courant', currentStatus: 'Voir le mois courant', monthNames: ['janvier','février','mars','avril','mai','juin', 'juillet','août','septembre','octobre','novembre','décembre'], monthNamesShort: ['Jan','Fév','Mar','Avr','Mai','Jun', 'Jul','Aoû','Sep','Oct','Nov','Déc'], monthStatus: 'Voir un autre mois', yearStatus: 'Voir un autre année', weekHeader: 'Sm', weekStatus: '', dayNames: ['Dimanche','Lundi','Mardi','Mercredi','Jeudi','Vendredi','Samedi'], dayNamesShort: ['Dim','Lun','Mar','Mer','Jeu','Ven','Sam'], dayNamesMin: ['Di','Lu','Ma','Me','Je','Ve','Sa'], dayStatus: 'Utiliser DD comme premier jour de la semaine', dateStatus: 'Choisir le DD, MM d', dateFormat: 'dd/mm/yy', firstDay: 0, initStatus: 'Choisir la date', isRTL: false}; $.datepicker.setDefaults($.datepicker.regional['fr']);

var windw = this;

//Validate box follow the scroll of the browser
$.fn.followTo = function ( pos ) {
    var $this = this,
        $window = $(windw);
    
    $window.scroll(function(e){
        if ($window.scrollTop() > pos) {
            $this.css({
                position: 'fixed',
                top: 50
            });
        } else {
            $this.css({
                position: 'absolute',
                top: pos
            });
        }
    });
};
$('#validate_box').followTo(210);

//JQuery Search Automation
$("#prospects_found table.order_by tbody tr td a, #prospects_found .pagination a").live('click', function() {
    $.getScript(this.href);
    return false;
});
$("#prospects_search input").keyup(function(){
    $.get($("#prospects_search").attr("action"), $("#prospects_search").serialize(), null, "script");
    return false;
});
})
  


  