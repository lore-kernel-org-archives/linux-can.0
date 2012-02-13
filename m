From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [Socketcan-users] Message stalls in SocketCan Layer?
Date: Mon, 13 Feb 2012 11:45:51 +0100
Message-ID: <4F38E9DF.6030804@grandegger.com>
References: <4F29091F.4010908@in.tum.de> <4F2AA5DF.9080304@grandegger.com> <4F2C0675.1050808@in.tum.de> <4F2C11DF.7010707@hartkopp.net> <4F2C3884.2000808@grandegger.com> <4F38DF36.9060007@in.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:48342 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab2BMKpy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Feb 2012 05:45:54 -0500
In-Reply-To: <4F38DF36.9060007@in.tum.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Michael_J=E4ntsch?= <michael.jaentsch@in.tum.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Hi Michael,

On 02/13/2012 11:00 AM, Michael J=E4ntsch wrote:
> Hi,
>=20
> sorry for the late reply. I wanted to test the older kernel and
> therefore needed to setup the OS from scratch which I didn't have tim=
e
> to do right away. Now, I tested it with Ubuntu 11.04 and kernel 2.6.3=
8-13.
> The problem appears a lot less often. From the time frame of a few
> minutes we went to something more like half an hour. So maybe this ha=
s
> been there all along but did not appear frequently enough to be notic=
ed.
> For the reasons I already mentioned I'm still pretty sure this has
> nothing to do with our code.
> Does anybody have an idea how to go about debugging this?
>=20
> On 03.02.2012 20:41, Wolfgang Grandegger wrote:
>> On 02/03/2012 05:57 PM, Oliver Hartkopp wrote:
>>> please consider that if it works on other machines with the same ke=
rnel that
>>> there could be some changes within the USB subsystem or some interr=
upt or
>>> ACPI/powersaving issues too.
>>>
>>> Going back to an older Kernel is a good check - don't know, if you =
also can go
>>> further (3.1, 3.2) with Ubuntu 11.10 too ?!?
>>>
>>> Maybe there's some USB debugging available to check whether the URB=
 has been
>>> sent properly to the USB wire and if the interrupt of the USB contr=
oller
>>> reached the system after sending.
>> IIUC, he said that the time stamps indicated that the USB transfers =
have
>> happened in time. The delays occured later. That's wired, indeed.
> Wolfgang is right, the debug output of the driver indicated that the =
USB
> transfers happened in time which is why I the guys from PEAK send me =
to
> you. This looks to me like the messages get stalled somewhere in the
> PF_CAN netlayer, but I'm also not a hundred percent sure how to verif=
y
> this, as this of course not that reproducable. Any ideas?

=46trace may help to find the problem. It's not too difficult to use, I
think. I assume that function tracing is enabled in your kernel. You
should find in your ".config":

CONFIG_DEBUG_FS=3Dy
CONFIG_FTRACE=3Dy
CONFIG_FUNCTION_TRACER=3Dy
CONFIG_DYNAMIC_FTRACE=3Dy

With that kernel, activate FTRACE as shown below:

Mount DebugFS file system
# mount -t debugfs nope /sys/kernel/debug
Stop tracing
# echo 0 > /sys/kernel/debug/tracing/tracing_on
Clear trace buffer
# echo 0 > /sys/kernel/debug/tracing/trace
If necessary, increase buffer size
# echo 16384 > /sys/kernel/debug/tracing/buffer_size_kb
Use function tracer
# cat /sys/kernel/debug/tracing/available_tracers
=2E.. function ...
# echo function > /sys/kernel/debug/tracing/current_tracer
=46inally enable ftracing
# echo 1 > /sys/kernel/debug/tracing/tracing_on
Inspect trace buffer
# cat /sys/kernel/debug/tracing/trace

This will create a huge amount of data. In a first step, only the
functions relevant for CAN might be enabled to debug the timing.

When you realize the long delay in your application, you should call
"echo 0 > /sys/kernel/debug/tracing/tracing_on" from the application
context (using fopen, etc.) to freeze the trace. That should give you
more or less detailed information on what has happened. I think it's no=
t
too complicated. Interpreting the traces might be harder, tough.

Some useful links are:

http://lxr.linux.no/#linux+v2.6.37/Documentation/trace/ftrace.txt

There are also a few nice articles about Ftrace at LWN.

Wolfgang.
