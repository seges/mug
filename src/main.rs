#[macro_use] extern crate tera;
#[macro_use] extern crate lazy_static;
extern crate serde;

use std::io::prelude::*;
use std::fs::File;
use std::io::{BufWriter, Write};
use std::env;
use std::process;

use tera::{Tera, Context};
use serde::{Serialize};

struct Config {
    command: String,
    mugDir: String,
    imageName: String
}

impl Config {
    fn new(args: &[String]) -> Result<Config, &'static str> {
        println!("zero {}", args[0]);
        // println!("{:?}", std::env::current_exe().unwrap().parent().unwrap());
        if args.len() < 2 {
            return Err("not enough arguments");
        }
    
        let command = args[1].clone();
        let mugDir = std::env::current_exe().unwrap().parent().unwrap().to_str().unwrap().to_string();

        if args.len() == 3 {
            let lang_type_arg = args[2].clone();
            let imageName = match lang_type_arg.as_ref() {
                "rust" => String::from("rust:1.32"),
                "node" => String::from("seges/mug-frontend-javascript:10.15.3"),
                _ => String::from("rust:1.32")
            };
            
            return Ok(Config { command, mugDir, imageName });
        }
        
        Ok(Config { command, mugDir, imageName: String::from("rust:1.32") })
    }
}

#[derive(Serialize)]
struct Lang {
    image: String
}

#[derive(Serialize)]
struct User {
    uid: String,
    name: String
}

lazy_static! {
    pub static ref TEMPLATES: Tera = {
        let mugDir = std::env::current_exe().unwrap().parent().unwrap().to_str().unwrap().to_owned();
        let path = format!("{}/{}", mugDir, "templates/**/*");
        println!("templates in {}", path);
        let mut tera = compile_templates!(path.as_str());
        // tera.autoescape_on(vec!["html", ".sql"]);
        // tera.register_filter("do_nothing", do_nothing_filter);
        tera
    };
}

fn render(config: Config) {
    let username = env::var("USER").unwrap();

    let lang = Lang {
        image: config.imageName
    };

    let user = User {
        uid: String::from("1000"),
        name: username
    };

    let mut context = Context::new();
    context.insert("lang", &lang);
    context.insert("user", &user);
    
    match TEMPLATES.render("docker-compose.single.yml.tera", &context) {
        Ok(s) => {
            // println!("{:?}", s)
            let path = std::env::current_dir();

            let mut file = File::create(format!("{}/{}", path.unwrap().to_str().unwrap(), "docker-compose.yml")).unwrap();
            let mut writer = BufWriter::new(&file);

            writer.write_all(s.as_bytes()).expect("Unable to write data");
        },
        Err(e) => {
            println!("Error: {}", e);
            for e in e.iter().skip(1) {
                println!("Reason: {}", e);
            }
        }
    };
}

fn main() {
    let args: Vec<String> = env::args().collect();
    
    let config = Config::new(&args).unwrap_or_else(|err| {
        println!("There was a problem parsing arguments = {}", err);
        println!("");
        println!("mug <command>");
        println!("");
        println!("Commands:");
        println!("");
        println!("create [<language>] - creates new Docker compose file; language one of 'rust'");
        process::exit(42);
    });

    // println!("Hello, world!");
    render(config);
}