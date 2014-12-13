
#include <stdio.h>


void rs_function(int value);
void rs_register(void(* value)(int));


void callback(int value) {
	printf("C callback invoked with value: %d\n", value);
}


int main(int argc, char *argv[]) {
	rs_function(0);
	rs_register(&callback);
	rs_function(42);

	return 0;
}
