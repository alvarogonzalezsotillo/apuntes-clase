#!/usr/bin/env -vS scala -save -cp ./bin/scala-xml_2.13-2.0.0-RC1.jar # -*- mode: scala; -*-
// INSTALAR AMMONITE
// sudo sh -c '(echo "#!/usr/bin/env sh" && curl -L https://github.com/lihaoyi/Ammonite/releases/download/1.1.2/2.12-1.1.2) > /usr/local/bin/amm && chmod +x /usr/local/bin/amm' && amm

object IndexCreator{

  import java.io._


  def allFiles(current: File) : Stream[File] = {

    val includeExtensions = Seq( ".reveal.html", "charla-informatica-a-eso-bachillerato.html" )
    val excludeExtensions = Seq( ".svg.pdf" )
    val excludePatterns = Seq("aruizcristina", "examen");


    def sanitizeArray[T]( a: Array[T] )(implicit m: scala.reflect.ClassTag[T]) = if(a == null)  new Array[T](0) else a
    def extensionFilter(f:File) = {
      val name = f.getName.toLowerCase
      includeExtensions.exists( name.endsWith(_) ) && excludeExtensions.forall( !name.endsWith(_) )
    }

    def includeFilter(f:File) = {
      val name = f.getPath.toLowerCase
      (name.contains("apuntes") || name.contains("/charlas-motivacionales") ) && !name.contains("media") && !excludePatterns.exists( name.contains(_) )
    }

    if( current.isDirectory ){
      println( s"Mirando directorio $current")
      val all = sanitizeArray( current.listFiles ).sorted
      val files = all.filter(extensionFilter).filter(includeFilter)
      val directories = all.filter( _.isDirectory )
      lazy val recurse = directories.map(allFiles(_))
      files.foreach(println)
      files.toStream #::: recurse.foldLeft( Stream[File]() )( _ #::: _ )
    }
    else{
      Stream()
    }

  }

  def toLink( f : File ) = {
    val link = f.getPath
    <li><a href={link}>{link}</a></li>
  }

  def doPage( dir : File, out : Writer ) = {
    val files = allFiles( new File(".") )
    val links = files.map(toLink)
    val formatter = new scala.xml.PrettyPrinter(400, 2)
    out.write(
      formatter.format(
        <html>
          <head>
            <style>
            </style>
          </head>
          <body>
            <ul>
              {links}
            </ul>
          </body>
        </html>
      )
    )
  }
}

object Main extends App{
  val out = new java.io.FileWriter("index.html")
  IndexCreator.doPage( new java.io.File("."), out )
  out.close()
  println("Done")
}

Main.main(null)
