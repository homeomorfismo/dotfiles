#!bin/bash

export OS=$(uname -s)
export LINUX="Linux"
export MAC="Darwin"

mkdir -p ${HOME}/Software/ngs
cd ${HOME}/Software/ngs

# Pre-requisites
case $OS in
    $LINUX)
        sudo apt update
        sudo apt upgrade -y
        sudo apt install -y python3 python3-distutils python3-tk libpython3-dev libxmu-dev tk-dev tcl-dev cmake git g++ libglu1-mesa-dev liblapacke-dev libocct-data-exchange-dev libocct-draw-dev occt-misc libtbb-dev libxi-dev xorg-dev libgl1-mesa-dev libglu1-mesa-dev libxmu-dev libxmu-headers libxmuu-dev libxmuu1
        ;;
    $MAC)
        xcode-select --install
        brew install cmake python@3.10 opencascade openmpi
        ;;
esac

# Clone ngsolve repo
cd ${HOME}/Software/ngs
git clone --recurse-submodules https://github.com/NGSolve/ngsolve.git src
# Clone specialfunctions repo
git clone https://github.com/NGSolve/ngs-special-functions.git sf
# Update ngsolve repo
cd src
git pull
git submodule update --recursive --init

# Build ngsolve
mkdir -p ${HOME}/Software/ngs/build
mkdir -p ${HOME}/Software/ngs/install
cd ${HOME}/Software/ngs/build

case $OS in
    $LINUX)
        cmake -DCMAKE_INSTALL_PREFIX=${HOME}/Software/ngs/install -DUSE_OCC=ON -DUSE_MKL=OFF -DUSE_PETSC=OFF -DUSE_SLEPC=OFF -DUSE_MPI=OFF -DUSE_HYPRE=OFF -DUSE_MUMPS=OFF -DUSE_MKL=OFF -DUSE_UMFPACK=OFF -DUSE_SUPERLU=OFF -DUSE_SUPERLU_DIST=OFF -DUSE_PARDISO=OFF -DUSE_MUMPS=OFF -DUSE_SCALAPACK
        ;;
    $MAC)
        ;;
esac
