# DO NOT EDIT
# This makefile makes sure all linkable targets are
# up-to-date with anything they link to
default:
	echo "Do not invoke directly"

# Rules to remove targets that are older than anything to which they
# link.  This forces Xcode to relink the targets from scratch.  It
# does not seem to check these dependencies itself.
PostBuild.hello.Debug:
/Users/Yuyang/Documents/programing/hpcEnv/mpi_cpp_examples/bin/Debug/hello:\
	/usr/local/Cellar/open-mpi/3.1.1/lib/libmpi.dylib
	/bin/rm -f /Users/Yuyang/Documents/programing/hpcEnv/mpi_cpp_examples/bin/Debug/hello


PostBuild.hello.Release:
/Users/Yuyang/Documents/programing/hpcEnv/mpi_cpp_examples/bin/Release/hello:\
	/usr/local/Cellar/open-mpi/3.1.1/lib/libmpi.dylib
	/bin/rm -f /Users/Yuyang/Documents/programing/hpcEnv/mpi_cpp_examples/bin/Release/hello


PostBuild.hello.MinSizeRel:
/Users/Yuyang/Documents/programing/hpcEnv/mpi_cpp_examples/bin/MinSizeRel/hello:\
	/usr/local/Cellar/open-mpi/3.1.1/lib/libmpi.dylib
	/bin/rm -f /Users/Yuyang/Documents/programing/hpcEnv/mpi_cpp_examples/bin/MinSizeRel/hello


PostBuild.hello.RelWithDebInfo:
/Users/Yuyang/Documents/programing/hpcEnv/mpi_cpp_examples/bin/RelWithDebInfo/hello:\
	/usr/local/Cellar/open-mpi/3.1.1/lib/libmpi.dylib
	/bin/rm -f /Users/Yuyang/Documents/programing/hpcEnv/mpi_cpp_examples/bin/RelWithDebInfo/hello




# For each target create a dummy ruleso the target does not have to exist
/usr/local/Cellar/open-mpi/3.1.1/lib/libmpi.dylib:
