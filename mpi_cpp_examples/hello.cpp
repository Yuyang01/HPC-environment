/*
 * hello.cxx
 * 
 * Copyright 2018 Yuyang Wang <Yuyang@ub246013.ub.es>
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 * 
 * 
 */


#include <iostream>
#include <mpi.h>


int main(int argc, char *argv[])
{
	
	MPI::Init(argc, argv); 
 int num_procs = MPI::COMM_WORLD.Get_size();
 int rank = MPI::COMM_WORLD.Get_rank();
 std::cout << "Hello world from process " << rank
        << " of " << num_procs << "\n";
 MPI::Finalize();
 return 0;
}

