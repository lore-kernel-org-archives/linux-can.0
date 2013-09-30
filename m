From: Sebastian Haas <dev@sebastianhaas.info>
Subject: Re: adding can4linux to drivers/char
Date: Mon, 30 Sep 2013 09:30:09 +0200
Message-ID: <CADGMhsXb+uEweThQxxnytO3Kw_psYfyase=2gS1pwvuVFzquyA@mail.gmail.com>
References: <1881932.U1kQQJkqCz@heinz.site>
	<523DF9C1.30300@grandegger.com>
	<2109885.0l6dWmo4a5@heinz.site>
	<CADGMhsXTbEc5ifQEbNM=dS3OP6uwGrvGfZ3OCvWJ=aXJyzGs+A@mail.gmail.com>
	<52487518.80008@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay01.ispgateway.de ([80.67.31.35]:43945 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011Ab3I3HaN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 30 Sep 2013 03:30:13 -0400
Received: from [209.85.128.53] (helo=mail-qe0-f53.google.com)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.68)
	(envelope-from <dev@sebastianhaas.info>)
	id 1VQXvm-00064s-5M
	for linux-can@vger.kernel.org; Mon, 30 Sep 2013 09:30:10 +0200
Received: by mail-qe0-f53.google.com with SMTP id jy17so3438548qeb.40
        for <linux-can@vger.kernel.org>; Mon, 30 Sep 2013 00:30:09 -0700 (PDT)
In-Reply-To: <52487518.80008@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Sebastian Haas <dev@sebastianhaas.info>, =?ISO-8859-1?Q?Heinz=2DJ=FCrgen_Oertel?= <hj.oertel@t-online.de>, linux-can@vger.kernel.org

Am 29.09.2013 20:44 schrieb "Marc Kleine-Budde" <mkl@pengutronix.de>:
>
> On 09/29/2013 07:45 PM, Sebastian Haas wrote:
> > I think Heinz-J=FCrgens' arguments are not that wrong. There are a =
bunch
> > of example in the kernel of concurring solution for the same issues
> > every single one with different advantages and disadvantages (just
> > compare how many solution for virtualization are available kvm, xen=
,
> > paravirt, ...).
>
> You're right.
>
> > There must be space in kernel for the classical chardev CAN-approac=
h.
> > Sharing common code to access the different controllers must be
> > possible.
>
> That's already implemented in the Kernel, it's called a driver.
You think I'm an idiot, don't you?

> > I think there are a bunch of use cases out there which are easier a=
nd
> > more efficiently solved with a simple chardev API. A simple chardev
> > CAN driver like can4linux provide doesn't depend on the whole
> > networking subsystem which may be imported of real embedded systems
> > with strong memory constraints (less memory footprint, smaller
> > kernel).
>
> The smallest system we're running Linux is a Cortex M3, it's on chip =
RAM
> is to small for Kernel + Userspace, so you need an external RAM chip
> anyways.
RAM is not the only limiting factor there is memory out there called fl=
ash or
ROM and then we are talking about code size and required tools to use a
specific features. And you know what I wrote whole CAN drivers with as =
much
LOC as libsocketcan.

In a system with just 2MB flash and no need for networking stuff except=
 CAN
every 10KB counts. To get a full features Socket CAN installation on su=
ch a
system you need the networking subsystem, iputils and libsocketcan wher=
eas
a chardev solution is much more leaner, you just need the driver and yo=
ur app
- that's it.

> > The Socket approach has some real advantages (multi-user for single
> > CAN controller, iptables filtering, netutil integration, buffering,
> > ..), but many of them may be considered as disadvantages as well (n=
o
> > control of the message flow in terms of timing and ordering, no
>
> You you have ordering problem? That's a bug? Which driver/hardware?
I didn't say I have an ordering bug, but due to the queuing the message=
s
on sending you loose control _when_ a message is actually sent and if i=
t was
sent. On Socket-CAN I can only guess if the message was sent. If you wa=
nt
to couple this with an automatic bitrate detection which relies on send=
ing
messages (e.g. SafetyBus p) in a different pattern this is simple not p=
ossible.

> > exclusive use of the interface, networking dependency). Implementin=
g
> > an automatic bitrate detection or application driver busoff recover=
y
> > is a pain in the ass with SocketCAN.
>
> If there is a need for bitrate detection, feel free request it here. =
I
> think there are some controllers that support this in hardware, while
> others don't. Is there a known working algorithm for bitrate detectio=
n?
There are different approaches described. The one Max described (passiv=
e
detection) is feasible with SocketCAN+libsocketcan and only if the bus
is already
communication. Active detection algorithm (I already mentioned SafetyBu=
s p) are
really hard to realize with Socket-CAN cause of the queuing stuff.

> How can we make busoff recovery better? What's the most annoying poin=
t?
The automatic recovery is fine, but the manual recovery needs NETIF stu=
ff or
libsocketcan.

But again I'm not saying Socket-CAN is bullshit, it is good for desktop=
 use and
for embedded system with enough resources. When it comes to determinist=
ic
requirements (and don't come with that SocketCAN Xenomai stuff, you don=
't
solve stuff if you put more code on top of it, keep it simple) and a
lean, simple
and efficient use it wouldn't be my first choice. So why shouldn't we
try to share
drivers code without netdev dependencies and allow the user to have a c=
hardev
interface as well with the well known behavior behind?

-Sebastian
