! pi.f90 -- computes pi by integrating f(x) = 4/(1+x**2) 
!           in the [0,1] interval
!
!           This integral can be approximated thorough a 
!           a quadrature method (rectangle method):
!
!           pi = 1/n sum_i=1^n f(x_i), with x_i = (i-1/2)/n
!                                      for i=1,...,n 

program calculate_pi
  !$ use omp_lib
  implicit none

  real(8), parameter :: pi25dt = 3.141592653589793238462643d0

  real(8) :: t0, t1, pi, h 
  integer :: i, n

  n  = 1000000000
  pi = 0.0d0
  h  = 1.0d0/dble(n)

  t0 = 0.0d0
  !$ t0 = omp_get_wtime();
  !$omp parallel default(none) private(i) shared(pi,n,h) 
  !$omp do schedule(static) reduction(+:pi)
  do i=1, n 
     pi = pi + 4.0d0/(1.0d0 + (h*(dble(i)-0.5d0))*(h*(dble(i)-0.5d0)))
  end do
  !$omp end do
  !$omp end parallel 
  pi = pi *h 
  t1 = 0.0d0
  !$ t1 = omp_get_wtime();

  write(*,'(a,f0.25)')   " Pi is ", pi 
  write(*,*)   " Error is ", abs(pi-pi25dt) 
  write(*,'(a,f0.3,a)') " Time: ", t1 - t0, "s"

end program
