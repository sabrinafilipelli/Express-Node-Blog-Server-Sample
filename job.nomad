job "express-node-blog-server-sample" {
 datacenters = ["office"]
 type = "service"

 constraint {
   attribute = "${attr.kernel.name}"
   value = "linux"
 }

 # Configure the job to do rolling updates
 update {
   # Stagger updates every 10 seconds
   stagger = "10s"

   # Update a single task at a time
   max_parallel = 1
 }

 group "express-node-blog-server-sample" {
  count = 1
  task "express-node-blog-server-sample" {
   driver = "docker"
   config {
    image = "axisofentropy/express-node-blog-server-sample"
    network_mode = "host"
    volumes = [
     "name=express-node-blog-server-sample,size=1,repl=3/:/data",
    ]
    volume_driver = "pxd"
   }

   service {
    name = "express-node-blog-server-sample"
    tags = [
     "global",
     "public.enable=true",
     "public.frontend.entryPoints=http",
     "public.frontend.rule=PathPrefix: /",
    ]
    port = "express_node_blog_server_sample"

    check {
     name = "express-node-blog-server-sample"
     type = "http"
     protocol = "http"
     path = "/"
     interval = "10s"
     timeout = "2s"
    }
   }

   resources {
    cpu = 500 # Mhz
    memory = 256 # MB
    network {
     mbits = 1

     port "express_node_blog_server_sample" {
      static = 9000
     }
    }
   }
  }
 }
}
