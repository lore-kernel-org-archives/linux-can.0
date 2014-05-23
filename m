From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: Re: [PATCH 0/2] CAN SJA100 controller emulation and SocketCAN based host CAN bus access
Date: Fri, 23 May 2014 16:25:01 +0200
Message-ID: <201405231625.01426.pisa@cmp.felk.cvut.cz>
References: <201405092010.19482.pisa@cmp.felk.cvut.cz> <201405151553.07872.pisa@cmp.felk.cvut.cz> <20140523094225.GA1260@stefanha-thinkpad.redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay.felk.cvut.cz ([147.32.80.7]:29455 "EHLO
	relay.felk.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbaEWOZe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 23 May 2014 10:25:34 -0400
In-Reply-To: <20140523094225.GA1260@stefanha-thinkpad.redhat.com>
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Andreas =?iso-8859-1?q?F=E4rber?= <afaerber@suse.de>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Oliver Hartkopp A <socketcan@hartkopp.net>, jinyang.sia@gmail.com, Stefan Weil <sw@weilnetz.de>, linux-can@vger.kernel.org

Hello Stefan,

On Friday 23 of May 2014 11:42:25 Stefan Hajnoczi wrote:
> On Thu, May 15, 2014 at 03:53:07PM +0200, Pavel Pisa wrote:
> > The decisions for further development
> >
> > Should be minimal working solution included in the QEMU
> > mainline in short term?
> > (months .. or rather wait for agreement on final
> > infrastructure, may be years because of our other load
> > and complexity of full model task)
> >
> > Is preferred approach to open CAN QEMU fork on GitHub?
> > Etc...
>
> It sounds like there is doubt about whether anyone has enough time to
> implement CAN more fully.  I'm not thrilled about reviewing patches if
> it's a partial implementation with few end users - something like that
> can be kept out-of-tree until someone with enough resources can polish
> it and push it upstream.

I can maintain only my available time for this work for now.
A demand for state equivalent to QEMU standard network subsystem
developed already for 10 years by many people is quite strict
requirement for discussion about this project.
I hope that inform/release early approach can help to join forces
and comments from QEMU experts helps to not invest into dead
ends.

As for the users, CAN is fundamental communication backbone
of allmost all (expect 99%) todays vehicles. Without this support
QEMU is useless for development or testing of automotive
control units (today quiet often based on PowerPC or ARM).
There is expected some movement from CAN to other standards
in future (FlexRay, Flexible Datarate CAN and may it be some
variant of Real-Time ETHERNET). But FD CAN is extension of CAN
which can be integrated into same infrastructure and other
two are much more complex and I do not expect that they
would phase out CAN completely. There are 6 to 10 or more CAN
busses in the today cars and for smaller MCUs it is much more cost
and resources effective than others options. CAN will be used
there for decades. CAN is used in many industry automation
and robotic systems, railway vehicles etc. as well. This is prevalent
bus (not counting UART and board local I2C and SPI) interface
integrated to todays MCUs. CAN is not found on mobile
chips where USB often is present. But even some of chips used
even in mobile devices (i.e. i.MX6) have CAN bus integrated.

So there is HUGE base of potential users who would gain from
such support. Other missing part for industrial control
is support of data acquisition cards emulation.
We have started some effort even in this direction

  https://rtime.felk.cvut.cz/hw/index.php/Humusoft_MF6xx#QEMU_Emulation_of_MF624

So I think that our contribution can be really valuable.

> A few more comments about the network subsystem:
>
> The QEMU network subsystem doesn't emulate Ethernet.  It's just a way to
> connect an emulated NIC with a host netdev (tap, socket, etc) with a few
> extra services like link down/up, flow control, etc.
>
> In the CAN world it would connect a CAN controller (e.g. Kvaser PCI)
> with a host device (e.g. using libcan or whatever).  I don't think it's
> necessary to emulate bus arbitration in this model, that should happen
> via the host device (which is talking to an real CAN bus).

This is not so easy. CAN has critical property of priority based
deterministic arbitration. I can imagine that such property could be
directly mapped to the host in the case of SocketCAN. This would
result in mapping each communication object of emulated controller
(one Tx one Rx in the case of SJA1000 but up to 32 or 128 for
C_CAN, HCAN2, FlexCAN, etc.) to one socket on the host side.
But such model would be quite resources demanding a there is question
what to do with unfortunate users of Windows where CAN API is
usually proprietary for each card vendor. The demand of CAN support
on host side would break one significant reason to use QEMU.
Because QEMU should allow to do development for CAN equipped
guests even on systems without CAN support. For Linux, there
is VCAN for such case although and there are approaches
(not with single standard yet) to tunnel CAN over ETHERNET.

On the other hand, including full CAN bus emulation allows
to use QEMU directly even on host without CAN support and even
to emulate some standard CAN devices directly in QEMU
or by some pluging which could be simpler than requirement to setup
VCAN (usually root access required) or some daemons communicating
over TCP IP or raw ETHERNET frames/VLANs. I think that for I2C,
SPI and some other embedded targets support it is implemented that
way in QEMU already.

But I am not sure what is the best approach now.

> The question is whether the network subsystem's send/receive model works
> or whether you need something CAN-specific like publishing RX/TX objects
> along with their metadata (IDs, priorities, deadlines, etc).  That would
> be a major difference and it would probably make sense it implement it
> as a separate subsystem.

As I have re-analyzed above, important properties can
be preserved through pass through to the host side but complexity
would show somewhere else. As for future (and may it be quite demanded)
FD CAN support, this would result in problems to use SocketCAN
on actual distributions stable kernels because FD CAN support matures
only in actual development ones.

Anyway, I would be happy if some perspective approach can be found.
I understand that you want stable and long term maintainable
and supported solution and that we should prove usefulness of
our approach. But I do not like classical situation where there
is no infomation about effort target and more teams start
independently from different old stable branches and do not care
about mainlining or following what is opinion of core project members.
Such project are usually good for some research funding final
presentation and then they hide in black hole. I have found some
pledge to develop complex-complete CAN emulation framework on the
net in one research project from 1010. But I have not found any
code or documentation about it. This is waste of work and money.
That is why I want to find agreement where to put code. We have
many public GITs at our department server but this is project
which expects more contributors so I prefer some more neutral
location, GitHub (or SF.net) and some agreement to direct
people to look there before they start from zero again
so that at least they consider to reuse work already done.
I.e. such reuse at least happened in case of our LinCAN and
later alternative wining SocketCAN development.

I would be happy if you are not against use of qemu-devel
list at least to coordinate/help with changes required to keep
separate branch/fork compatible/in-sync with core QEMU changes.

Thanks for comments and providing your options how to
proceeded with our effort.

Best wishes,

            Pavel



