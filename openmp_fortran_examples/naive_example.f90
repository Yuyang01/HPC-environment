program naive_example
  !$ use omp_lib 
  implicit none
  integer id, num, nthreads
  integer, allocatable :: x(:)
  
  id=1; nthreads=1
  !$ nthreads = omp_get_max_threads()
  allocate(x(nthreads))

  !$OMP PARALLEL DEFAULT(NONE) SHARED(x) PRIVATE(id)
  !$ id = omp_get_thread_num()
  !$ x(id) = id
  !$OMP END PARALLEL

  !$OMP PARALLEL DEFAULT(NONE) SHARED(x) PRIVATE(id, num)
  !$ id  = omp_get_thread_num()  
  !$ num = omp_get_num_threads() 
  write(*,'(a,i0,a,i0)') " I'm thread ", x(id), " of ", num
  !$OMP END PARALLEL  
  
  deallocate(x)  
end program naive_example
