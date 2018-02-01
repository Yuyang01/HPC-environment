program hello
  use MPI
  integer :: me, np, ierr

  call MPI_Init(ierr)
  call MPI_Comm_size(MPI_COMM_WORLD, np, ierr)
  call MPI_Comm_rank(MPI_COMM_WORLD, me, ierr)
  
  write(*,*) 'Hello World, I am ', me, ' of ', np
  
  call MPI_Finalize(ierr)
end

