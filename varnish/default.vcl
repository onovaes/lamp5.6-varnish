vcl 4.0;



# DEFAULT backend definition. Set this to point to your content server.
backend default {
    .host = "phpserver";
    .port = "8080";
}




## VCL FOR dothnews
## VERSION 0.36


# Happens before we check if we have this in cache already.
#
# Typically you clean up the request here, removing cookies you don't need,
# rewriting the request, etc.
sub vcl_recv {
  
    # BEBIN GO TO BACKEND IMEDIATLY
    # Requisições POST e Authorization vao direto pro BACKEND 
    if (req.http.Authorization || req.method == "POST") {
        return (pass);
    }


    # Did not cache the admin, login and other pages
    if (req.url ~ "/(dothnews|sitemap|sitemaps|usuario|logout|feed|assinatura|atendimento)") {
        return (pass);
    }
    # END GO TO BACKEND IMEDIATLY




    # BEGIN UNSET's
    # Unset headers that might cause us to cache duplicate infos
    unset req.http.Accept-Language;

    # Remove os parametros GET para evitar dois caches para a mesma pagina
    # STRIP gclid, fbclid e todos que começam com utm_
    if (req.url ~ "(\?|&)(gclid|fbclid|utm_[a-z]+)=") {
        set req.url = regsuball(req.url, "(gclid|fbclid|utm_[a-z]+)=[-_A-z0-9+()%.]+&?", "");
        set req.url = regsub(req.url, "[?|&]+$", "");
    }
    # END UNSET's




    ### BEGIN FOR COOKIES
    #Goodbye for all incoming cookies:
    #unset req.http.Cookie;

    # Remove has_js and Cloudflare/Google Analytics __* cookies.
    set req.http.Cookie = regsuball(req.http.Cookie, "(^|;\s*)(_[_a-z]+|has_js)=[^;]*", "");
    
    # Remove a ";" prefix, if present.
    set req.http.Cookie = regsub(req.http.Cookie, "^;\s*", "");
    
    # Are there cookies left with only spaces or that are empty?
    if (req.http.cookie ~ "^ *$") { unset req.http.cookie; }

    # drop tracking params
    if (req.url ~ "\?(utm_(campaign|medium|source|term)|_gat|votou_enq_|adParams|client|cx|eid|fbid|feed|ref(id|src)?|v(er|iew))=") {
        set req.url = regsub(req.url, "\?.*$", "");
    }

    # pass admin cookies
    if (req.http.cookie) {
        # SE TIVER LOGADO NO SGI OU LEITOR IDETIFICADO, NAO DEVE FAZER CACHE
        if (req.http.cookie ~ "(dn_user_conectado|dn_cookie_ident_manter_conectado)") {
            return(pass);
        } else {
          unset req.http.cookie;
        }
    }
    ### END FOR COOKIES




    ### BEGIN FOR CLEAR CACHES
    # Command to clear complete cache for all URLs and all sub-domains
    # curl -X CACACHE http://www.vejaobem.com.br
    if (req.method == "CACACHE") {
        ban("req.http.host ~ .*");
        return (synth(200, "Full cache cleared"));
    }

    # Command to clear ONE CACHE BY URL
    # curl -X COCACHE http://www.vejaobem.com.br/amor/garoto-supera-bullying-pra-doar-cabelo-a-criancas-com-cancer/23/
    if (req.method == "COCACHE") {
        return (purge);
    }
    ### END FOR CLEAR CACHES


    
    # Do not cache HTTP authentication and HTTP Cookie
    if (req.http.Authorization || req.http.Cookie) {
            # Not cacheable by default
            return (pass);
    }

    # Cache all others requests
    return (hash);
}



# Happens after we have read the response headers from the backend.
#
# Here you clean the response headers, removing silly Set-Cookie headers
# and other mistakes your backend does.
sub vcl_backend_response {
    
    # Paginas que geram/removem cookie e nunca devem ser cacheadas
    # Se tirar essa linha o backend nao consegue criar o COOKIE
    if (bereq.url ~ "/(dothnews|usuario|enquete|promocoes|atendimento|logout)") {
        set beresp.uncacheable = true;
        set beresp.ttl = 0s;
        return(deliver);
    }

    # Remove cookies that destroy cache:
    unset beresp.http.Set-Cookie;

    # Remove o vay para evitar - Varnish: same hash, different results?
    unset beresp.http.Vary;
}



# Happens when we have all the pieces we need, and are about to send the
# response to the client.
#
# You can do accounting or modifying the final object here.
sub vcl_deliver {


    #Adding a header indicating hit/miss (zertico)
    if (obj.hits > 0) {
        set resp.http.X-Status = "1"; #HIT
    } else {
        set resp.http.X-Status = "0"; #MISS
        set resp.http.Link = "</miss.css>;rel=stylesheet;type=text/css;media=all";
    }

    # Add the number of hits in the header response
    set resp.http.X-Status-h = obj.hits;


    # Remove inutil header response
    #unset resp.http.X-Varnish;
    #unset resp.http.Via;
    #unset resp.http.X-Powered-By;
    #unset resp.http.Server;
}