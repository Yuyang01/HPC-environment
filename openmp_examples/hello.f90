program hello
  !$ use omp_lib 
  implicit none
  integer id, num

  !$omp parallel private(id, num)
  id  = 0
  num = 1
  !$ id  = omp_get_thread_num()  
  !$ num = omp_get_num_threads() 
  write(*,'(a,i0,a,i0)') " I'm thread ", id, " of ", num
  !$omp end parallel

end program
