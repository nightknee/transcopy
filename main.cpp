
#include "TransCopy.h"

const bool DEBUG = true;

int main(int argc, char **argv) {
    TransCopy *MainTrans = new TransCopy;
    return MainTrans->run(argc, argv);
}
