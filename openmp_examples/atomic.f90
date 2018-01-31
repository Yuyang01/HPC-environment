!* *****************************************************************************
!* A simple example on how to use OpenMP atomics. 
!* ************************************************************************** */

program atomic 
 !$ use omp_lib 
 implicit none
 integer :: me, lnum, num, n

 num=0
 !$OMP PARALLEL DEFAULT(NONE) SHARED(num)  PRIVATE(me,lnum,n) 
 me   = 0
 lnum = -1 
 n    = 0 
 !$ me = omp_get_thread_num() 
 do while ( lnum /= me ) 
    !$OMP ATOMIC READ
    lnum = num
    n = n + 1
 end do 
 write(*,*) 'Thread ', me, 'arrives after spinning ', n, ' times'
 !$OMP ATOMIC UPDATE
 num = num + 1
 !$OMP END PARALLEL 
 write(*,*) 'All done' 

end program 
