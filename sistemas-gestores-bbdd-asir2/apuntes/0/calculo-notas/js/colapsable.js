var Colapsable = (function () {
  
    
    function logg(o){
        //console.log(o);
    }
    
    var escuchadoresColapsable = [];
    
    
    function convertirEnLlaveExpandible(id){

        var llave = $("<div>-</div>").toggleClass( "llave-expandible" );

        $(id).addClass("oculto-por-llave");
        llave.insertBefore($(id));

        function llaveDeColapsable(id){
            var ret = $(id).prev();
            if( !ret.hasClass("llave-expandible") ){
                throw "La llave no tiene la clase adecuada:" + ret.prop("class");
            }
            return ret;
        }

        function colapsableDeLlave(llave){
            var ret = $(llave).next();
            if( !ret.hasClass("colapsable") ){
                throw "El colapsable no tiene la clase adecuada:" + ret.prop("class");
            }
            return ret;
        }

        function actualizaOrientacionDeTodasLasLlaves(){
            var llaves = $(".llave-expandible");
            llaves.each( function(number,llave){
                actualizaOrientacion( llave, colapsableDeLlave(llave) );
            });
        }

        llave.click( function(){
            muestraOcultaLlave(llave,id);
        });



        function actualizaOrientacion( llave, elem ){
            var lbb = $(llave).offset();
            var ebb = $(elem).offset();

            logg( "llave lbb: top" + lbb.top + " -- left:" + lbb.left );
            logg( "elem  ebb: top" + ebb.top + " -- left:" + ebb.left );

            if( lbb.top < ebb.top ){
                logg( "add abajo" );
                $(llave).addClass( "abajo" );
            }
            else{
                logg( "remove abajo" );
                $(llave).removeClass( "abajo" );
            }
        }

        function muestraOcultaLlave(llave,elem){
            var delay = 200;

            var yaCambiado = function(){
                logg( "tras abrir o cerrar llave" );
                actualizaOrientacionDeTodasLasLlaves();
            }

            if( llave.html() == "-" ){
                llave.html("+");
                llave.addClass("llave-cerrada" );
                $(elem).addClass("oculto-por-llave");
                $(elem).hide(delay,yaCambiado);
            }
            else{
                llave.html("-");
                llave.removeClass("llave-cerrada" );
                $(elem).removeClass("oculto-por-llave");
                $(elem).show(delay,yaCambiado);
            }


            console.log( "Escuchadores:" + escuchadoresColapsable.length );
            for( var i in escuchadoresColapsable ){
                escuchadoresColapsable[i](llave);
            }
            
        }

        muestraOcultaLlave(llave,id);
        $(window).resize( function(){
            actualizaOrientacionDeTodasLasLlaves( llave,id );
        });
    }


    function actualizaLlavesExpandibles(){
        $(".colapsable").each( function(number,elem){
            convertirEnLlaveExpandible(elem);
        });
    }

  
    return {
        actualizaLlavesExpandibles : actualizaLlavesExpandibles,
        avisaColapsadoExpandido : function( handler ){
            escuchadoresColapsable.push(handler);    
        }
        
    };
    
    
    
    
})()