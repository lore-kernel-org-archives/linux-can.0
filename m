From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: Re: [Qemu-devel] [PATCH 0/2] CAN SJA100 controller emulation and SocketCAN based host CAN bus access
Date: Thu, 15 May 2014 15:53:07 +0200
Message-ID: <201405151553.07872.pisa@cmp.felk.cvut.cz>
References: <201405092010.19482.pisa@cmp.felk.cvut.cz> <CAJSP0QXLCZYrvHpPQH6CSTkfL2ezdvZya32kuHfs4FgYvC_Btg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay.felk.cvut.cz ([147.32.80.7]:10786 "EHLO
	relay.felk.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbaEONxk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 15 May 2014 09:53:40 -0400
In-Reply-To: <CAJSP0QXLCZYrvHpPQH6CSTkfL2ezdvZya32kuHfs4FgYvC_Btg@mail.gmail.com>
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>, Andreas =?utf-8?q?F=C3=A4rber?= <afaerber@suse.de>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Oliver Hartkopp A <socketcan@hartkopp.net>, jinyang.sia@gmail.com, Stefan Weil <sw@weilnetz.de>, rtems-devel@rtems.org, linux-can@vger.kernel.org

Hello all,

the first much thanks to Stefan, Andreas and Peter
for reply.

Next, should I keep linux-can in the talk
(it is against list cross-posting rule) or all
potentially interrested participants agree to stay/follow
this and future CAN+QEMU related topics on QEMU list?

I would remove RTEMS in the next post. Even that
it is one of potential users, original "investor",
internals of the emulation are out of this project
scope.

On Monday 12 of May 2014 11:18:09 Andreas F=C3=A4rber wrote:
> Am 12.05.2014 11:01, schrieb Peter Crosthwaite:
> > On Sat, May 10, 2014 at 4:14 AM, Pavel Pisa <pisa@cmp.felk.cvut.cz>=
 wrote:
> >> The work is based on Jin Yang GSoC 2013 work funded
> >> by Google and mentored in frame of RTEMS project GSoC
> >> slot donated to QEMU.
>
> Should/can that be recorded in form of his Signed-off-by before yours=
?

I try to do something with that. I would preffer to add him
but I would like to have his confirmation beforehand.
The GSoC 2013 work is available in his GitHub repo including
negotiated final licence inclusion

https://github.com/Jin-Yang/QEMU-1.4.2

I was against to bothering you by patches for old QEMU
version so I have postponed communication till I have
time to bring it to the latest GIT. But there is significant
redesign which unties changes from hardcoded modifications
to QEMU character driver (original approach) and changes
whole patches architecture substantially including
omission of some functionality for beginning and probably
introduction of new errors. So I think that I am not
authorized to provide Signed-off-by Jin Yang on my own.
But original work status and license is declared by
Jin Yang and GSoC 2013.

> > That's a big patch. And it seems to add a new API/framework, then n=
ew
> > users of that API. Can you add your core as a single patch, then
> > incrementally bring your devices stuff as subsequent patches? My gu=
ess
> > is this should be about 3 patches - are there any circular deps,
> > requiring you to bring your three c files all at once or is there a
> > logical order you can add them for ease of review?
>
> True. But before you resend, I'd like to hear Stefan H.'s view of
> whether CAN should go into hw/net/ at all or into, e.g., hw/can/.

That is significant question and my sending of the patch series is main=
ly
base to start discussion about this and support architecture.
I need to learn mnore about QEMU internals and possible mechanisms
to use from QEMU experts as well.

> Independently of the placement, it's always an interesting question o=
f
> who will maintain this new infrastructure - I don't see any new
> MAINTAINERS entries getting added in either patch (NB: a diffstat in =
0/2
> would've been nice) for patch review.

I have personal interrest in CAN and control systems etc. which
can be tracked more than 15 years back. But I have no funding
for this/QEMU work and some of my other projects available.
On the other hand, our group on Department of Control Enginnering
of Czech Technical University have participated in many serious
projects and we contribute to (ideally all open) CAN ecosystems.

CAN at Czech Technical University

  https://rtime.felk.cvut.cz/can/

links our group projects and some small part of our university
other departments CAN projects, which we have got some notice about.

I cannot speak for our group head if he provide support/allows
to maintain QEMU CAN project by us. But I personally have
interrest for this and I would apply for maintainership.
But I/personally can provide only my spare time thought
I have a problems with fast responses and time in general.

But I am keeping many open project alive or at least compilable
for 15 years and more already.

https://www.ohloh.net/accounts/ppisa/positions

On Tuesday 13 of May 2014 14:29:08 Stefan Hajnoczi wrote:
> On Fri, May 9, 2014 at 8:10 PM, Pavel Pisa <pisa@cmp.felk.cvut.cz> wr=
ote:
>
> Please run the patches through scripts/checkpatch.pl and address the
> warnings.
>
> This patch doesn't use QEMU's network layer.  Perhaps it should but
> I'm not familiar with CAN.  The QEMU network layer implements a
> point-to-point model where NetClientState instances can send/receive
> packets.  It seems a subset of this was reimplemented for CAN but I
> don't see much unique behavior in the core CAN code.  Why didn't you
> use the QEMU network layer?

Yes, that is main question. It would be great to use QEMU infrastructur=
e
for broadcasting messages/frames. I am not enough familiar with it
and I would need some help to find how it could be used for CAN.

But on the other hand, there is question, if real behavior
and messages ordering should be modelled for CAN or if
we consider only some +/- working solution. If the behave
of real CAN network is required later, it can be very hard
to model it by infrastructure designed for other data flow.

In the full model case, each CanBusClient should publish
its list of CAN communication objects ready for Tx and Rx.
=46or Tx usually ordered by message IDs (representing priority
in arbitration process). Global clients order for given bus
should be recomputed for each change on clients list by
client's change activated bus arbitration process.
That process should then select next message for transmition.
Then it should be delivered to all CanBusClien's Rx communication
objects which filters match CAN message ID.

The main problem (when compared to the real bus) is, that real
bus does transfer rate limiting (max 1M bit/s - stuffing etc.).
But in QEMU faster messages flow can overflow Rx buffers
in situations which cannot lead to the overflow in real situation.
So there should be some mechanism to check Rx object availability
in clients. Than there should be mechanism to postpone data exchange
in such case for at least time equivalent to real message presence
on a wire (we have implemented computation for exact time required
for message from its actual data including stuffing and CRC done
for our industrial partner in other project).

The message Tx attempt expiration should be postponed for
even longer when it is not accepted/confirmed by any
target and error should be reported back to corresponding
Tx object.

Some controllers provide "overload frame" response which
should/could be included/emulated as well.

Controllers should evaluate and count Tx and Rx errors counts
and change state appropriately.

I am not sure if all that can be emulated by network QEMU
subsystem or if required changes are acceptable.

I do not know if it worth to consider all this at all.

My actual goal was to have something simple which works
and can be used for drivers implementors (i.e. RTEMS)
to get into state when first message is sent and received
and then switch to real HW.

And yes, it would be great to have all this implemented
to can do drivers testing and correctness assessment in QEMU.

I am able to think about infrastructure which allows such
extensions in future. But real implementation is muti-man-year
project which needs contribution from more people.

So at the end, I am not sure if net or not-net. I expected
some objections to addition of subsystem. If you agree
with hw/can than I would incline to separation of code which
needs to follow CAN infrastructure development caused
changes together.

> >   - CAN bus simple SJA1000 PCI card emulation for QEMU
> >
> >     Files:
> >
> >       - include/net/can_emu.h
> >           - basic CAN bus related types. Those which could possibly=
 clash
> >             with Linux kernel prepended by "qemu_".
> >           - prototypes for CAN buses naming and clients registratio=
n
> >           - original Jin Yang approach uses chardev, but that does =
not
> >             map well to little different semantics of CAN messages
> >             distribution. I have considered common vlan code but
> >             I have not found how to use it with CAN well too.
> >
> >       - hw/net/can_core.c
> >           - implementation of CAN messages delivery
> >           - support to connect into real host CAN bus network for c=
ase
> >             of Linux SocketCAN
>
> The network layer implements (poorly) a flow control mechanism so tha=
t
> devices with limited buffers, like a USB network card, can pause
> receive until the guest has drained the receive buffer.  I don't see
> that in the CAN code, so is it okay to drop frames?

There is no such mechanism in our implementation now.
But it is desirable in longer run an there was some minimal
solution in original Jin Yang's char device code.

> About the Linux socket file descriptor:
> 1. It should be non-blocking because QEMU is an event-driven program.
> We must never block waiting to read/write data from/to a socket.
> 2. Missing EINTR error handling in case a signal interrupted a
> read(2)/write(2) system call.

Yes, that are next steps or other option is to start
delivery thread for each CAN bus. Which could be natural
solution for real bus behavior simulation.
Are there some reasons against use of separate thread
for this purpose?

Even such thread could call actual syscall nonblockin
to can timeout and report errors. But it could be simpler
to program and parallelize mesages delivery with emulated CPU run.

> In the QEMU network layer the can_core.c behavior would be produced
> using a hub with a tap or socket netdev.  The broadcast code in the
> hub netdev is separate from the Linux-specific tap code.  I think you
> can implement a CAN socket netdev and use the hub to broadcast.

I need to learn more about QEMU internals and reusable features.
Thank for suggestions.

> >       - hw/net/can_sja1000.h
> >           - declarations of SJA1000 CAN controller registers
> >             and connection type independent part of API
> >
> >       - hw/net/can_sja1000.c
> >           - SJA1000 CAN controller registers and registers model
> >             implementation - hard part implemented by Jin Yang
> >
> >       - hw/net/can_pci.c
> >           - connection of above infrastructure to the minimal PCI
> >             card with only one mmio BAR and no bridge interrupts se=
tup
> >             and control. Unfortuantelly, I am not aware of any such
> >             straightforward card but it is great for testing and
> >             drivers porting. Used vendor and product ID are random =
ones
> >             chosen by Jin Yang, if there is some consensus that wor=
k
> > worth for integration then I suggest to ask RedHat for unique PCI I=
D
> > donation
>
> What is the relationship between can_pci.c and the emulated Kvaser de=
vice?
>
> Implementing one real device would be very important to establish tha=
t
> this CAN implementation can model real devices.

There is broad range of CAN controllers, we have selected one famous CA=
N
discrete controller chip SJA1000. Problem is, that it predates PCI
and is intended to be used with 8051 like multiplexed bus.
It is still one of the most used chips on addons cards. CAN is common
on SoC and MCUs and they use many different derivations or completely
different registers models. But there is really very little other
CAN controller chips available for addon cards (OKI, discontinued Intel=
, ...).
So SJA1000 is reasonable choice for our QEMU effort. But it has to be u=
sed
in combination with some PCI-local bus bridge. But these bridges
are quite strange, sometimes reused chip for old ISDN solutions etc.
So they need special configuration to access local bus connected CAN
controller and mainly to setup routing of interrupts.

Emulation of PCI-local bus bridge complicates both sides in action -
QEMU emulation side and developed CAN drivers side. That is why
we have "designed" basic card with clean implementation directly
mapping SJA1000 chip into PCI memory BAR with direct, level triggered
routing of interrupt to corresponding "PCI board" A pin.

When we have confirmed that this works together with modified
LinCAN driver I have started to implement model corresponding
to real PCI CAN card. I have selected Kvaser card because
we pose more of these at university/so I can check real contents
of other configuration/support spaces/BARs on real device.
The advantage of that selection is that driver for this card
is included in mainline Linux in CAN/SocketCAN subsystem.
This board can have up to four SJA1000 chips in one of its BARs,
The board routes interrupts through bride interrupt control/masking
and configuration, which has to be emulated as well.
It even maps chips into I/O space instead of MMIO.

I think that for drivers writers or even can infrastructure
developers (userspace and higher level tools) it is advantage to have
simple solution with corresponding driver in a guest kernel (something
like virtio). On the other hand, concrete real hardware driver
testing requires exact hardware complexity emulation and allows
to use unmodified OS and available drivers.

But if you think, that this artificial simple card design is not
good idea for QEMU, then it can be discarded and only Kvaser
(when it works now) included.

The decisions for further development

Should be minimal working solution included in the QEMU
mainline in short term?
(months .. or rather wait for agreement on final
infrastructure, may be years because of our other load
and complexity of full model task)

Is preferred approach to open CAN QEMU fork on GitHub?
Etc...

I consider as a good result, that my actual attempt and QEMU offered
infrastructure allows to to provide minimal testable solution with
no QEMU modifications (except Makefiles). So I hope that is is
reasonable start and our effort would be of some use for others.

Best wishes,

              Pavel

PS: I am not sure if I will be online till Monday




