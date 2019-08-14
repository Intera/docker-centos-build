FROM centos:7

RUN yum -y update

RUN yum -y install centos-release-scl \
    && yum-config-manager --enable rhel-server-rhscl-7-rpms

RUN yum -y install devtoolset-7 libicu-devel zlib-devel xz-devel bzip2-devel

WORKDIR /opt/boost

RUN curl -L https://dl.bintray.com/boostorg/release/1.69.0/source/boost_1_69_0.tar.gz -o boost_1_69_0.tar.gz \
    && tar --strip-components=1  -xzf boost_1_69_0.tar.gz

RUN source scl_source enable devtoolset-7 && ./bootstrap.sh

RUN source scl_source enable devtoolset-7; ./b2 || echo "Warnings during build"
