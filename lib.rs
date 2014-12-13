extern crate libc;
use self::libc::c_int;


static mut haskell:Option<extern fn(c_int)> = None;

/* Register the callback */
#[no_mangle]
pub fn rs_register(cb: extern fn(c_int)) {
    unsafe {
        haskell = Some(cb);
        println!("callback registered");
    }
}


/* Register the callback */
#[no_mangle]
pub fn rs_function(val:c_int) {
    println!("triggered Rust function with: {}", val);

    if val != 42 {
        println!("life, the universe, and everything");
    }

    unsafe {
        match haskell {
            Some(ref callback) => {
                println!("registered callback found");
                (*callback)(100);
            },
            _ => {
                println!("no callback has been registered");
            }
        }
    }
}
