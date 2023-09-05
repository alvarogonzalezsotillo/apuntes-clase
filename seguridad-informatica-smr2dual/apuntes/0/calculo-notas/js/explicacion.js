
var Explicacion = (function(){

    function muestraOcultaTextoExplicacion(elem){
        // TO DO: UTILIZAR JQUERYUI
        //$(elem).toggleClass("explicacion-visible");
        $(elem).toggle(200);
    }

    
    return {
        convertirEnExplicacion :  function convertirEnExplicacion( selector, explicacion ){
            var elems = $(selector);
            elems.each( function(number,elem){
                var toggle = $("<div/>", {
                    "class" : "toggle-explicacion"
                });
                toggle.html("?");
                $(elem).append(toggle);

                var textoExplicacion = $("<div/>",{
                    "class" : "texto-explicacion"
                }).html(explicacion);
                $(elem).append(textoExplicacion);

                toggle.mouseenter(function(){
                    muestraOcultaTextoExplicacion(textoExplicacion);
                });

                toggle.mouseleave(function(){
                    muestraOcultaTextoExplicacion(textoExplicacion);
                });


            });
        }
    };
    
})();