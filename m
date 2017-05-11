From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 kernel for Raspberry Pi
Date: Thu, 11 May 2017 21:29:36 +0200
Message-ID: <20170511192936.GB15112@airbook.vandijck-laurijssen.be>
References: <CAGJdXcFRUB=xLSdFkwadTkdd=OAvgkGgrOYRAxy0RkjpHGoCDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:36750 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755390AbdEKTn6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 11 May 2017 15:43:58 -0400
Content-Disposition: inline
In-Reply-To: <CAGJdXcFRUB=xLSdFkwadTkdd=OAvgkGgrOYRAxy0RkjpHGoCDQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Paul Bongaerts <pauluzs@gmail.com>
Cc: linux-can@vger.kernel.org

> Because this takes several hours per build and over a day on the pi i
> could use some help in the right direction

My principle is that I need indeed to decrease the
'modify-build-reload' time before problems get solved.

> Merge j1939-v4.7 with rpi-master takes several hours

restrict yourself to cross-compile then. git merge should take 1.2.3
seconds. A minute at most.

See my further comments inline below:

--- Original message ---
> Date:   Wed, 10 May 2017 13:50:25 +0200
> From: Paul Bongaerts <pauluzs@gmail.com>
> To: linux-can@vger.kernel.org
> Subject: J1939 kernel for Raspberry Pi
> 
> After struggling for the last 5 days i keep failing in building a
> working custom  jessie lite based j1939 arm kernel. for a raspberrypi
> (b.t.w. i'm certainly no expert on kernel building)
> 
> Tried  local and  crosscompiled builds with different setting
> 
> Goal is to build a kernel according to the Raspberrypi kernel building guide
> https://www.raspberrypi.org/documentation/linux/kernel/building.md
> 
> And merge this with a J1939 kernel according to this elinux j1939 guide.
> http://elinux.org/J1939
> 
> Because this takes several hours per build and over a day on the pi i
> could use some help in the right direction
> 
> 
> 
> Br, Paul
> 
> 
> 
> 
> Failed attempts summary :
> 
> Compile a working kernel with no j1939 support on rpi locally
> (modprobe can-j1939 Fails)
> Crosscompile unbootable kernels with j1939 support on ubuntu (Fails to boot)
> 
> 
> #########################################################################
> Native compile
> rapsberry pi zero w    16 GB SD Card
> #########################################################################

I stripped the native compile, it takes too much time, but should not be
different.

> #########################################################################
> Crosscompile j1939-v4.7 > rpi kernel
> ubuntu-16.04.2-server-amd64.iso
> #########################################################################
> 
> cd /usr/src
> 
> Get crosscompile Toolchain
> 
> git clone git://github.com/raspberrypi/tools.git --depth=1
> 
> Get j1939-v4.7 branch kernel sources
> 
> git clone -b j1939d-v4.7 git://github.com/kurt-vd/linux --depth=1

(1) You should not clone 2 repo's, but use remotes
(2) using '--depth=1' ignores history, but you will need the history for
the merge. 'git clone' takes time once, spending it enables you to
benefit of the git features.

> 
> cd /usr/src/linux
> 
> export PATH
> 
> export PATH=$PATH:/usr/src/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin
> 
> Clean the kernel source
> 
> make mrproper
> 
> 
> 
> Now login to a running rpi (Clean raspbian-jessie-lite, uname -a r 4.9.24+ )
> 
> Create config.gz
> 
> pi@raspberrypi:~ $ sudo modprobe configs
> 
> Copy the config.gz to build server
> 
> pi@raspberrypi:~ $ scp /proc/config.gz user@server.local:/usr/src/linux
> 
> 
> 
> Back on Server
> 
> gunzip -c config.gz > .config
> 
> Set kernel varialble
> 
> KERNEL=kernel
> 
> 
> Build Kernel Image, Modules and Devicetreeoverlays (select: SAE J1939
> as module, debug SAE J1939 yes, CAN_IFI_CANFD as module)
> 
> make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage modules dtbs
> 
> 
> copy files to SD according to raspberry's kernelbuildingguide and boot
> (fails to boot)

Which files did you copy?

I suspect you should make a (temporary) directory where you install
kernel & modules to. That directory is to be copies recursively to the
RPI.

Kind regards,
Kurt
