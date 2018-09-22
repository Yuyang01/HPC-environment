//
//  main.cpp
//  omp
//
//  Created by Yuyang Wang on 22/09/2018.
//  Copyright © 2018 Yuyang Wang. All rights reserved.
//
// reference 1:http://antonmenshov.com/2017/09/09/clang-openmp-setup-in-xcode/
// reference 2: https://stackoverflow.com/questions/46527662/xcode-9-clang-error-cannot-specify-o-when-generating-multiple-output-files
// reference 3: http://danlec.com/st4k#questions/46765974



#include <iostream>
#include "omp.h"
int main(int argc, const char * argv[]) {
#pragma omp parallel
#pragma omp critical
    std::cout << "Greetings from thread "<<omp_get_thread_num()<<std::endl;
    return 0;
}
