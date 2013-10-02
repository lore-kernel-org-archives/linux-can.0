From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: Re: Linux CAN CUSE hacks, SocketCAN and RT Was: adding can4linux to drivers/char
Date: Wed, 2 Oct 2013 10:43:59 +0200
Message-ID: <201310021044.00281.pisa@cmp.felk.cvut.cz>
References: <1881932.U1kQQJkqCz@heinz.site> <206b49e0-6fcb-4895-8fca-19a9b38e6a18@email.android.com> <5B48DC5BA8D5D64A8F5E39AC7EF2A42008B864@ADXV3.win.desy.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay.felk.cvut.cz ([147.32.80.7]:63441 "EHLO
	relay.felk.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806Ab3JBJTM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Oct 2013 05:19:12 -0400
In-Reply-To: <5B48DC5BA8D5D64A8F5E39AC7EF2A42008B864@ADXV3.win.desy.de>
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "May, Stefan" <stefan.may@desy.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, =?iso-8859-1?q?Heinz-J=FCrgen?= Oertel <hj.oertel@t-online.de>, linux-can@vger.kernel.org, Michal Sojka <sojkam1@fel.cvut.cz>

Hello All,

I monitor this discussion for longer time.
Unfortuantelly I am quite out of time and we need some more
testing of newer kernels with SocketCAN and some alternatives
to backup my observations. But I cannot stay longer silent.

On Tuesday 01 of October 2013 22:20:55 May, Stefan wrote:
> > And add a CUSE adaption for your legacy costumers.
>
> CUSE adaption is not possible in the case of can4linux API. I tried that
> once and failed. The reason is in read() and write() call where can4linux
> chooses to use the number of frames instead of bytes for the count
> parameter.

Such choice is broken by design and I would beg and protest against
inclusion of such thing into mainline. This is against POSIX
read/write calls definitions. This breaks all tools like Valgrind
and security checks etc. You can do so such weird things on Linux
but under Windows KDM and WDM models with IRP packets you cannot.
Same in many sane systems either. It breaks possible future modifications
of Linux to the more microkernel/hypervisor based design etc.
(and yes, I am aware that there is/was similar brokenness in mainline
kernel already somewhere in I2C code where read uses address provided
in the first byte of buff which should be receive only, but at least
size matches).

On Wednesday 02 of October 2013 09:49:12 Oliver Hartkopp wrote:
> Btw. CUSE is open source.
> Why not adding a feature to CUSE that allows to pass the number of structs
> instead of the number of bytes?

Please no, NO, I expect that CUSE maintainers would cry loud as well.

Lack of in and out size arguments for IOCTL in POSIX standard
is enough disaster for now. That is one of (hopefully) not so
many things which are better on Windows and cannot be corrected
ON Linux without standard breakage. When suggested IOCL values
construction is used then it IS not so horrible for usual cases.

On the other hand, there is really only limited space for CUSE
use when we speak about CAN and real CAN applications targetting
control and real real-time applications. There would be even
additional overhead added to the SocketCAN.

And there are legal demand for Linux CAN support suitable
for real real-time/(near)hard real-time applications. SocketCAN
has very nice API, but its overhead and Linux networking
stack problems with RT-kernel are significant obstacles,
at least according our long time testing.

We (mainly my colleague Michal Sojka and this year even
Martin Horenovsky - student paid from our group budget over holidays)
have spent significant time on Linux CAN system testing and measurement.
This year round is not finished and interpretation is missing still.
We have intended to announce that after some analysis is finished
but to have some clue for possible future discussion, there are
actual results

  http://rtime.felk.cvut.cz/can/benchmark/3.0/

Even simple/not-tuned RTEMS system driver was added to the
test (per journal article reviewer request to compare against
other system). And it latencies are much much better than
SocketCAN or any RT kernel (we need to find time for update/porting/testing
latest ones but that is not so easy - 3.6.x-rt and around were
totally unusable on our HW). RT usability indicator "nop-highprio"
test breaks many RT kernels when Etherned load is applied and results
are not so great even for these which work

http://rtime.felk.cvut.cz/can/benchmark/3.0/host-2.6.36.2-00015-g4f1bc4e/2.6.33.7-rt29-00004-g92487e4/flood/eth/nop-highprio/results.html

Compare Linux results with RTEMS

http://rtime.felk.cvut.cz/can/benchmark/3.0/host-2.6.36.2-00015-g4f1bc4e/rtems4.10-midam/flood/eth/nop-highprio/results.html

The comparison is not fair to Linux, RTEMS driver is really much simpler
and no GW functionality or other SocketCAN/Linux advantages are present.
"GW" is only simple copy from one CAN interface to another through open,
read and write calls in standard application, but RTEMS has no 
userspace/kernelspace call overhead (it uses same memory context
and no protection in our case). But it illustrates bare
HW capabilities.

I have more things and thought to say but I am not fully ready
for that and I have fear that required amount of work is above
my time and knowledge so most of my thoughts are more or less
grumbles.

Best wishes,

                Pavel
