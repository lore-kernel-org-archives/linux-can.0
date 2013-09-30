From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: adding can4linux to drivers/char
Date: Mon, 30 Sep 2013 12:20:38 +0200
Message-ID: <20130930102038.GA13680@vandijck-laurijssen.be>
References: <1881932.U1kQQJkqCz@heinz.site>
 <523DF9C1.30300@grandegger.com>
 <2109885.0l6dWmo4a5@heinz.site>
 <CADGMhsXTbEc5ifQEbNM=dS3OP6uwGrvGfZ3OCvWJ=aXJyzGs+A@mail.gmail.com>
 <52487518.80008@pengutronix.de>
 <CADGMhsXb+uEweThQxxnytO3Kw_psYfyase=2gS1pwvuVFzquyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay008.isp.belgacom.be ([195.238.6.174]:36722 "EHLO
	mailrelay008.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755887Ab3I3KUx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 30 Sep 2013 06:20:53 -0400
Content-Disposition: inline
In-Reply-To: <CADGMhsXb+uEweThQxxnytO3Kw_psYfyase=2gS1pwvuVFzquyA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sebastian Haas <dev@sebastianhaas.info>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, =?utf-8?Q?Heinz-J=C3=BCrgen?= Oertel <hj.oertel@t-online.de>, linux-can@vger.kernel.org

Hi,

Please find my remarks on this topic below.

On Mon, Sep 30, 2013 at 09:30:09AM +0200, Sebastian Haas wrote:
> Am 29.09.2013 20:44 schrieb "Marc Kleine-Budde" <mkl@pengutronix.de>:
> >
> > On 09/29/2013 07:45 PM, Sebastian Haas wrote:
> > > I think Heinz-J=C3=BCrgens' arguments are not that wrong. There a=
re a bunch
> > > of example in the kernel of concurring solution for the same issu=
es
> > > every single one with different advantages and disadvantages (jus=
t
> > > compare how many solution for virtualization are available kvm, x=
en,
> > > paravirt, ...).
> >
> > You're right.

You cannot have 1 device with 2 drivers (1 can4linux + 1 linux-can),
because users would need to choose the set of drivers to use.
That choice is made for an application, but must be implemented on a
system level: some udev magic or module blacklisting, or in your
case, compile only 1 set in the kernel.
No arguments exist to provide non-expert users with those choices.

I agree that adding 1 api as emulation layer really suits some usecases=
=2E

Linux-CAN is IMHO superior because linux-can preserves
the network semantics in the way that the linux kernel has foreseen.
can4linux may provide network semantics (I'm not specialist there),
but providing network semantics through a chardev is simply wrong.

> > > I think there are a bunch of use cases out there which are easier=
 and
> > > more efficiently solved with a simple chardev API. A simple chard=
ev
> > > CAN driver like can4linux provide doesn't depend on the whole
> > > networking subsystem which may be imported of real embedded syste=
ms
> > > with strong memory constraints (less memory footprint, smaller
> > > kernel).

If you put all application logic in 1 binary, you don't need
the multi-user capabilities nor the network semantics.
But that's not the typical scenario, so it shouldn't be abused
to promote single-user or chardev API's.
Bare metal programming, if done well, will always render a more efficie=
nt
system, but requires more effort :-)

> >
> > The smallest system we're running Linux is a Cortex M3, it's on chi=
p RAM
> > is to small for Kernel + Userspace, so you need an external RAM chi=
p
> > anyways.
> RAM is not the only limiting factor there is memory out there called =
flash or
> ROM and then we are talking about code size and required tools to use=
 a
> specific features. And you know what I wrote whole CAN drivers with a=
s much
> LOC as libsocketcan.
>=20
> In a system with just 2MB flash and no need for networking stuff exce=
pt CAN
> every 10KB counts. To get a full features Socket CAN installation on =
such a
> system you need the networking subsystem, iputils and libsocketcan wh=
ereas
> a chardev solution is much more leaner, you just need the driver and =
your app
> - that's it.
>=20
> > > The Socket approach has some real advantages (multi-user for sing=
le
> > > CAN controller, iptables filtering, netutil integration, bufferin=
g,
> > > ..), but many of them may be considered as disadvantages as well =
(no
> > > control of the message flow in terms of timing and ordering, no

You compare a stripped chardev solution with a 'full featured' socket C=
AN,
with iptables & stuff?
You should compare against a 'stripped' socket CAN solution: no iproute=
,
just libsocketcan. You app will 'up' the netdev.
No ip sockets, no unix sockets, ....
> >
> > You you have ordering problem? That's a bug? Which driver/hardware?
> I didn't say I have an ordering bug, but due to the queuing the messa=
ges
> on sending you loose control _when_ a message is actually sent and if=
 it was

The issues you mention only expose themselves in 'real' multi-user syst=
ems,
but you have only 1 user. You can predict exactly what is in the queues=
=2E
With a chardev API, you would administer queues yourself in application=
=2E
You could do this on top of socketCAN too.

> sent. On Socket-CAN I can only guess if the message was sent. If you =
want
> to couple this with an automatic bitrate detection which relies on se=
nding
> messages (e.g. SafetyBus p) in a different pattern this is simple not=
 possible.

You can retrieve you own sent messages in the same flow.
see commit 1e55659ce6ddb5247cee0b1f720d77a799902b85

>=20
> > > exclusive use of the interface, networking dependency).
You had only 1 application running, right?
You know that you have exclusive use then!

[...]
>=20
> -Sebastian

Kind regards,

--=20
Kurt Van Dijck
