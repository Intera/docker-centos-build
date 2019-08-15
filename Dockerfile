FROM centos:7

RUN yum -y update

RUN yum -y install centos-release-scl \
    && yum-config-manager --enable rhel-server-rhscl-7-rpms

RUN yum -y install devtoolset-7 libicu-devel zlib-devel xz-devel bzip2-devel rh-python36

WORKDIR /opt/boost

RUN curl -L https://dl.bintray.com/boostorg/release/1.69.0/source/boost_1_69_0.tar.gz -o boost_1_69_0.tar.gz \
    && tar --strip-components=1  -xzf boost_1_69_0.tar.gz

RUN source scl_source enable devtoolset-7 && source scl_source enable rh-python36 && CPLUS_INCLUDE_PATH="$CPLUS_INCLUDE_PATH:/opt/rh/rh-python36/root/usr/include/python3.6m/" ./bootstrap.sh

RUN source scl_source enable devtoolset-7 && source scl_source enable rh-python36; CPLUS_INCLUDE_PATH="$CPLUS_INCLUDE_PATH:/opt/rh/rh-python36/root/usr/include/python3.6m/" ./b2 || echo "Warnings during build"

RUN yum install -y llvm-toolset-7 llvm-toolset-7-cmake
