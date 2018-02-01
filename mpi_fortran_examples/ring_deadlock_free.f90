program ring_deadlock 
  use mpi 
  implicit none

  integer :: left, right, me, np, ierr
  integer, allocatable :: buf(:)
  integer, dimension(MPI_STATUS_SIZE) :: status
  character(len=256) :: argument 
  integer :: N 

  ! Read buffer size as a command-line argument
  call getarg(1,argument)
  read (argument,*) N

  call MPI_Init(ierr)

  call MPI_Comm_size(MPI_COMM_WORLD, np, ierr)
  call MPI_Comm_rank(MPI_COMM_WORLD, me, ierr)

  ! Set rank of right & left neighbours 
  right = me+1    
  left  = me-1   

  ! Close the ring for the processes at ring extremes
  if(left<0)    left=np-1  
  if(right==np) right=0

  allocate(buf(N))
  buf = me
  if(MOD(me,2)/=0) then
    call MPI_Recv(buf,N,MPI_INTEGER,left,0, &
                  MPI_COMM_WORLD,status,ierr)
    call MPI_Send(buf, N, MPI_INTEGER, right, 0, &
                  MPI_COMM_WORLD,ierr)
  else
    call MPI_Send(buf, N, MPI_INTEGER, right, 0, & 
                  MPI_COMM_WORLD,ierr)
    call MPI_Recv(buf,N,MPI_INTEGER,left,0, &
                  MPI_COMM_WORLD,status,ierr)
  end if

  deallocate(buf)
  write(*,*) 'Process ', me, 'out of ring'
  call MPI_Finalize(ierr)
   
end 
