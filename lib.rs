extern crate libc;
use self::libc::c_int;


static mut HASKELL:Option<extern fn(c_int)> = None;

/* Register the callback */
#[no_mangle]
pub fn rs_register(cb: extern fn(c_int)) {
    unsafe {
        HASKELL = Some(cb);
        println!("callback registered");
    }
}


#[no_mangle]
pub fn rs_function(val:c_int) {
    println!("triggered Rust function with: {}", val);

    if val != 42 {
        println!("life, the universe, and everything");
    }

    unsafe {
        match HASKELL {
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
