#!/bin/bash

# run as root like the following : 
#chmod +x filename.sh
#sudo ./filename.sh


if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi



#UBUNTU SOFTWARE
#apt-get install grep git sed wget
apt-get install gcc gfortran g++ gcc-multilib #cmake python
#apt-get install git-gui
apt-get install openmpi-bin openmpi-doc libopenmpi-dev 
#apt-get install perl zlib1g-dev


#MODIFY BASHRC
## Adding definitions and variables in bashrc

echo "
   mpignu()
   {
	               export CXX=/usr/bin/g++;
	               export CC=/usr/bin/gcc; 
                  export FC=/usr/bin/gfortran; 
                  export F77=/usr/bin/gfortran; 
                  export F90=/usr/bin/gfortran; 
                  export PETSC_ARCH_DEBUG=linux-gnu-debug; 
                  export PETSC_ARCH_RELEASE=linux-gnu-release; 
                  export COMPILER=MPIGNU;
                  export OMPI_FC=/usr/bin/gfortran
                  export OMPI_CC=/usr/bin/gcc
                  export OMPI_CXX=/usr/bin/g++
   }
   #default is gnu
   mpignu   " >> $HOME/.hpcpaths
   chmod 777 $HOME/.hpcpaths

  
   ##ADD TO BASHRC
   TEST=`grep ".hpcpaths" $HOME/.bashrc` 
   if [[ $TEST == *".hpcpaths"* ]]
   then
      echo ""   
   else
      echo "   ##HPC ENVIRONMENT VARIABLES   
   source $HOME/.hpcpaths
      " >> $HOME/.bashrc
   fi

source $HOME/.hpcpaths

#########################################################################################
 

      
      

   
   
     
      
      
      
      

   









