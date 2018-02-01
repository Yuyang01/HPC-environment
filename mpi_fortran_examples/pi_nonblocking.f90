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

  real(8) :: psum, res, h, t0, t1 
  integer :: i, n
  integer :: start, end 
  integer :: me, np, ierr
  integer, allocatable :: statuses (:,:)
  integer, allocatable :: requests (:)
  real(8), allocatable :: tmp (:)


  call MPI_Init(ierr)

  call MPI_Comm_size(MPI_COMM_WORLD, np, ierr)
  call MPI_Comm_rank(MPI_COMM_WORLD, me, ierr)

  if(me.eq.0) then
    allocate(statuses(MPI_STATUS_SIZE, np-1))
    allocate(requests(np-1))
    allocate(tmp(np-1)) 
    ! pre-post nonblocking receives
    do i=1,np-1
      call MPI_Irecv(tmp(i), 1, MPI_DOUBLE_PRECISION, &
                     i, 0, MPI_COMM_WORLD, &
                     requests(i), ierr)
    end do
  end if


  n     = 1000000000
  psum  = 0.0d0
  h     = 1.0d0/dble(n)
  start = me*(n/np)+1
  if (me == np-1) then
    end = start + n/np + mod(n,np) - 1
  else
    end = start + n/np - 1
  end if

  t0 = MPI_Wtime()

  do i=start, end 
     psum = psum + 4.0d0/(1.0d0 + (h*(dble(i)-0.5d0))*(h*(dble(i)-0.5d0)))
  end do

  if(me.eq.0) then
     ! rank 0 collects partial results
     res=psum
     call MPI_Waitall(np-1, requests, statuses, ierr)
     do i=1,np-1
        res=res+tmp(i)
     end do
     res=res*h
     write(*,'(a,f0.25)')   "Pi is ", res 
    ! write(*,'(a,e)') "Error is ", abs(pi25dt-res) 
     deallocate(tmp)
     deallocate(requests)
     deallocate(statuses)
  else
     ! ranks != 0 send their results to rank 0
     call MPI_Send(psum, 1, MPI_DOUBLE_PRECISION, & 
                   0, 0, MPI_COMM_WORLD, ierr)
  endif
  t1 = MPI_Wtime()
  write(*,'(a,f0.3,a)') " Time: ", t1 - t0, "secs."
 
  call MPI_Finalize(ierr)

end 
