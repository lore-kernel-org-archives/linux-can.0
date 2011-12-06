From: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Subject: Re: using j1939
Date: Tue, 06 Dec 2011 14:24:21 +0100
Message-ID: <4EDE1785.9000306@volkswagen.de>
References: <20111206104432.91170@gmx.net> <20111206121403.GB322@e-circ.dyndns.org> <loom.20111206T131950-88@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mr1.volkswagen.de ([194.114.62.75]:57618 "EHLO
	mr1.volkswagen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933031Ab1LFNa1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 6 Dec 2011 08:30:27 -0500
In-Reply-To: <loom.20111206T131950-88@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On 06.12.2011 13:37, Wolfgang wrote:
>> I'm afraid you lost me on this. Using your (cross)toolchain, you do
>> $ make
>> etc. to compile (&  install) the binaries.
>
> The guys from pengutronix (I am using ptxdist 2010.07.1) told me
> that I have to know how the things in the repositories
> have to be built.
>
>>> But now I am facing the next problem, what type of packages do
> I have to
> create for each particular repository?
>> I believe you're asking something for a specific build system, but I
>> do not know which one.
>> What build system do you use?
>
> found and using toolchain:
> '/opt/OSELAS.Toolchain-1.99.3/powerpc-603e-linux-gnu/
> gcc-4.3.2-glibc-2.8-binutils-2.18-kernel-2.6.27-sanitized/bin'
>

Hello Wolfgang,

when you build your BSP e.g. with

ptxdist images

in the directory 'build-target/linux-2.6.xx' your Linux kernel is 
unpacked, patched and compiled.

For a quick hack you can just try to update the files in

build-target/linux-2.6.xx/net/can/*
build-target/linux-2.6.xx/include/linux/can/*

with the files from Kurt (can-j1939-modules).

The you need to drop the compile stage with

pxtdist drop kernel.compile

And then build the stuff again (with 'ptxdist images')

Btw. the idea from Kurt with cross-compiling is also good.

But you should define the KERNELDIR= .../build-target/linux-2.6.xx then 
as THIS is the real kernel you are building for your system.

Regards,
Oliver



