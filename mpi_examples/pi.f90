! pi.f90 -- computes pi by integrating f(x) = 4/(1+x**2) 
!           in the [0,1] interval
!
!           This integral can be approximated thorough a 
!           a quadrature method (rectangle method):
!
!           pi = 1/n sum_i=1^n f(x_i), with x_i = (i-1/2)/n
!                                      for i=1,...,n 

program calculate_pi
  use mpi 
  implicit none

  real(8), parameter :: pi25dt = 3.141592653589793238462643d0

  real(8) :: psum, res, tmp, h, t0, t1 
  integer :: i, n
  integer :: start, end 
  integer, dimension(MPI_STATUS_SIZE) :: status
  integer :: me, np, ierr

  call MPI_Init(ierr)

  call MPI_Comm_size(MPI_COMM_WORLD, np, ierr) !np=4
  call MPI_Comm_rank(MPI_COMM_WORLD, me, ierr) !me=0,1,2,3

  n     = 1000000000 !total interval for integration
  psum  = 0.0d0   ! sum of integration
  h     = 1.0d0/dble(n) ! step length
  start = me*(n/np)+1 ! 1 251 501 501 751
  if (me == np-1) then
    end = start + n/np + mod(n,np) - 1
  else
    end = start + n/np - 1   ! 250 500 750 1000
  end if

  t0 = MPI_Wtime()

  do i=start, end 
     psum = psum + 4.0d0/(1.0d0 + (h*(dble(i)-0.5d0))*(h*(dble(i)-0.5d0)))
  end do



  if(me.eq.0) then
     ! rank 0 collects partial results
     res=psum
     do i=1,np-1
        call MPI_Recv(tmp,                  & ! receive buffer
                      1,                    & ! array length
                      MPI_DOUBLE_PRECISION, & ! data type
                      i,                    & ! rank of source
                      0,                    & ! tag (unused here)
                      MPI_COMM_WORLD,       & ! communicator
                      status,               & ! status array (msg info)
                      ierr)
        res=res+tmp
     end do
     res=res*h
     write(*,'(a,f0.25)')   "Pi is ", res 
     !write(*,'(a,Ew.d)') "Error is ", abs(pi25dt-res) 
  else
     ! ranks != 0 send their results to rank 0
     call MPI_Send(psum,                 & ! send buffer
                   1,                    & ! message length
                   MPI_DOUBLE_PRECISION, & ! data type
                   0,                    & ! rank of destination
                   0,                    & ! tag (unused here)
                   MPI_COMM_WORLD,       & ! communicator
                   ierr)
  endif
  
  t1 = MPI_Wtime()
  write(*,'(a,f0.3,a)') " Time: ", t1 - t0, "secs."
 
  call MPI_Finalize(ierr)

end 
