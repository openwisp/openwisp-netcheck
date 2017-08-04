=================
openwisp-netcheck
=================

.. image:: https://ci.publicwifi.it/buildStatus/icon?job=openwisp-netcheck
   :target: #

.. image:: http://img.shields.io/github/release/openwisp/openwisp-check.svg
   :target: https://github.com/openwisp/openwisp-netcheck/releases

------------

`LEDE <https://lede-project.org/>`_ / `OpenWrt <https://openwrt.org/>`_ network connectivity check tool for the OpenWISP project.

.. image:: http://netjsonconfig.openwisp.org/en/latest/_images/openwisp.org.svg
  :target: http://openwisp.org

.. contents:: **Table of Contents**:
 :backlinks: none
 :depth: 3

------------

Install precompiled package
---------------------------

First run:

.. code-block:: shell

    opkg update

Then install one of the `latest builds <http://downloads.openwisp.org/openwisp-netcheck/>`_:

.. code-block:: shell

    opkg install <URL>

Where ``<URL>`` is the URL of the image that is suitable for your case.

For a list of the latest built images, take a look at `downloads.openwisp.org
<http://downloads.openwisp.org/openwisp-netcheck/>`_.

**If you need to compile the package yourself**, see `Compiling openwisp-netcheck`_
and `Compiling a custom LEDE / OpenWrt image`_.

Once installed *openwisp-netcheck* needs to be configured (see `Configuration options`_)
and then started with::

    /etc/init.d/openwisp_netcheck start

To ensure the agent is working correctly find out how to perform debugging in
the `Debugging`_ section.

Configuration options
---------------------

UCI configuration options must go in ``/etc/config/openwisp_netcheck``.

- ``vpn_iface``: configure the name of VPN interface, defaults to ``data``
- ``radio_iface``: configure the name of RADIO interface, defaults to ``owf2``
- ``interval``: time in seconds between checks for network status, defaults to ``30``

Compiling openwisp-netcheck
---------------------------

The following procedure illustrates how to compile *openwisp-netcheck* and its dependencies:

.. code-block:: shell

    git clone git://git.lede-project.org/source.git lede
    cd lede

    # configure feeds
    echo "src-git openwisp https://github.com/openwisp/openwisp-netcheck.git" > feeds.conf
    cat feeds.conf.default >> feeds.conf
    ./scripts/feeds update -a
    ./scripts/feeds install -a
    # any arch/target is fine because the package is architecture indipendent
    arch="ar71xx"
    echo "CONFIG_TARGET_$arch=y" > .config;
    echo "CONFIG_PACKAGE_openwisp-netcheck=y" >> .config
    make defconfig
    make tools/install
    make toolchain/install
    make package/openwisp-netcheck/compile
    make package/openwisp-netcheck/install

Alternatively, you can configure your build interactively with ``make menuconfig``, in this case
you will need to select the *openwisp-netcheck* variant by going to ``Administration > openwisp``:

.. code-block:: shell

    git clone git://git.lede-project.org/source.git lede
    cd lede

    # configure feeds
    echo "src-git openwisp https://github.com/openwisp/openwisp-netcheck.git" > feeds.conf
    cat feeds.conf.default >> feeds.conf
    ./scripts/feeds update -a
    ./scripts/feeds install -a
    make menuconfig
    # go to Administration > openwisp and select the variant you need interactively
    make -j1 V=s

Compiling a custom LEDE / OpenWrt image
---------------------------------------

If you are managing many devices and customizing your ``openwisp-netcheck`` configuration by hand on
each new device, you should switch to using a custom LEDE / OpenWrt firmware image that includes
``openwisp-netcheck`` and its precompiled configuration file, this strategy has a few important benefits:

* you can save yourself the effort of installing and configuring ``openwisp-netcheck`` con each device
* if you happen to reset the firmware to initial settings, these precompiled settings will be restored as well

The following procedure illustrates how to compile a custom `LEDE 17.01 <https://lede-project.org>`_
image with a precompiled minimal ``/etc/config/openwisp_netcheck`` configuration file:

.. code-block:: shell

    git clone git://git.lede-project.org/source.git lede
    cd lede
    git checkout lede-17.01

    # configure feeds
    cp feeds.conf.default feeds.conf
    echo "src-git openwisp https://github.com/openwisp/openwisp-netcheck.git" >> feeds.conf
    ./scripts/feeds update -a
    ./scripts/feeds install -a
    # replace with your desired arch target
    arch="ar71xx"
    echo "CONFIG_TARGET_$arch=y" > .config
    echo "CONFIG_PACKAGE_openwisp-netcheck=y" >> .config
    make defconfig
    # compile with verbose output
    make -j1 V=s

Debugging
---------

Debugging *openwisp-netcheck* can be easily done by using the ``logread`` command:

.. code-block:: shell

    logread

Use grep to filter out any other log message:

.. code-block:: shell

    logread | grep openwisp-netcheck

If you are in doubt openwisp-netcheck is running at all, you can check with::

    ps | grep openwisp-netcheck

You should see something like::

    1648 root      1192 S    {openwisp_netche} /bin/sh /usr/sbin/openwisp_netcheck

---------

See `CHANGELOG <https://github.com/openwisp/openwisp-netcheck/blob/master/CHANGELOG.rst>`_.

License
-------

See `LICENSE <https://github.com/openwisp/openwisp-netcheck/blob/master/LICENSE>`_.

Support
-------

See `OpenWISP Support Channels <http://openwisp.org/support.html>`_.
