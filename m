From: Alex Layton <alex@layton.in>
Subject: Re: can-j1939 API
Date: Thu, 22 Oct 2015 12:39:43 -0400
Message-ID: <CAFUozzFqDtOdkgFye4M3jU-g+9uF=XH8SmU44j5qK4PTEXp8qQ@mail.gmail.com>
References: <linux-can/can-utils/pull/7@github.com> <linux-can/can-utils/pull/7/c144149208@github.com>
 <560ADC91.1090408@pengutronix.de> <20150929194920.GA11430@airbook.vandijck-laurijssen.be>
 <CAFUozzFQTOASSR94vKQnMGajUSvHGgL7BMuJSvuXKd3=n6aiog@mail.gmail.com>
 <20151018023225.GA29078@airbook.vandijck-laurijssen.be> <CAFUozzGy0UZhKaeLfJiySkJfrK-XuOD7cwz01=hsO48hAk+mow@mail.gmail.com>
 <20151019204442.GA16852@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:33556 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982AbbJVQkX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Oct 2015 12:40:23 -0400
Received: by obbwb3 with SMTP id wb3so72677804obb.0
        for <linux-can@vger.kernel.org>; Thu, 22 Oct 2015 09:40:22 -0700 (PDT)
In-Reply-To: <20151019204442.GA16852@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, linux-can <linux-can@vger.kernel.org>

> --- Original message ---
>> Date: Mon, 19 Oct 2015 12:53:50 -0400
>> From: Alex Layton <alex@layton.in>
>> To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, linux-can
>>  <linux-can@vger.kernel.org>
>> Subject: Re: can-j1939 API
>>
>> On Sat, Oct 17, 2015 at 10:32 PM, Kurt Van Dijck
>> <dev.kurt@vandijck-laurijssen.be> wrote:
>> >
>> > --- Original message ---
>> >> Date: Thu, 15 Oct 2015 18:04:58 -0400
>> >> From: Alex Layton <alex@layton.in>
>> >> To: linux-can <linux-can@vger.kernel.org>
>> >> Subject: Re: can-j1939 API
>> >>
>> >> On Tue, Sep 29, 2015 at 3:49 PM, Kurt Van Dijck
>> >> <dev.kurt@vandijck-laurijssen.be> wrote:
>> >> > I would like to challenge other j1939 (not necessarily socketcan+can-j1939)
>> >> > users to share their opinions.
>> >>
>> >> Hello, I am the author of https://github.com/ISOBlue/isoblue-software,
>> >> finally getting around to participating in this list.
>> >>
>> >> > > > If you look at http://elinux.org/J1939
>> >> >
>> >> > > > $ modprobe can-j1939
>> >> >
>> >> > This is a systemwide action, as opposed to
>> >> >
>> >> > > > $ ip link set can0 j1939 on
>> >> >
>> >> > which is an interface-wide action.
>> >> >
>> >> > Due to the nature of CAN, the kernel should not/cannot decide if CAN
>> >> > traffic is J1939 or not.
>> >> > Unlike other CAN protocols (RAW, BCM, ISOTP), J1939 allocates the whole
>> >> > CAN id range for its use, and using CAN ids incompatible with j1939
>> >> > is regarded illegal.
>> >> >
>> >> > So this must become a switch.
>> >>
>> >> I disagree with this, like Austin Schuh did. In my experience there is
>> >> almost always other non-J1939 CAN traffic present and it must be
>> >> possible to use both. The module should just ignore any CAN that does
>> >> not look right to it, and there needs to still be a way to get at the
>> >> other CAN on the bus through a CAN_RAW socket or something.
>> >
>> > The 'switch' is to turn can-j1939 on/off on a specific interface.
>> > The condition that I'd like to solve is where you end up having a
>> > j1939 bus can0, obviously with 29bit CAN id's, and another bus, can1,
>> > that is NOT j1939 compliant while using 29bit identifiers.
>> >
>> > I'd prefer to disable can-j1939 processing on can1 in that case, before
>> > reporting any obvious protocol violations in the log.
>>
>> I can understand that. Can you not have you module only listen on
>> interfaces where J1939 sockets have been opened?
>
> That sounds like a fine idea!
> It would behave slightly different during booting, but given the critics
> on the switch, this will probably the best thing to do.
> This implies that a non-root user decides to turn on can-j1939
> processing on an interface, which I found a hard nut to crack.

I had not really considered the user permissions ramifications of
things. You raise a good point here.

Doesn't SocketCAN automatically load the protocol module when you try
to open a socket? That means non-root users can already decide to turn
on processing on an interface for ISOTP etc. I am good with non-root
users being able to enable J1939 like this, especially if the
precedent is already set by other protocols.

>> >> > > > and if you think about this kind of assignment, it should be implemented
>> >> > > > inside the j1939 stuff and not in af_can.c. The can-gw routing netlink
>> >> >
>> >> > j1939 touches af_can because address configuration via netlink is
>> >> > absent in af_can. j1939 adds (with seperate patches) the ability to add
>> >> > addressess for CAN sockets, but only for those CAN protocols that
>> >> > support it.
>> >> > I see no decent way to bypass af_can, except for creating af_j1939.
>> >>
>> >> Sorry if this is a stupid question, but what is the point of adding
>> >> addresses to a CAN interface with ip? Doesn't the code creating the
>> >> socket set what its address and/or NAME is? My implementation does not
>> >> modify af_can, though it is admittedly much more simplistic than
>> >> Kurt's.
>> >
>> > I offloaded the (static) addressing onto the kernel, so I needs to know
>> > its address, much like any other address-capable protocol like e.g. ipv4.
>> > Its obviously that not every ipv4 capable application needs to know it
>> > local ip address. I made can-j1939 likewise multi-user ready.
>>
>> I don't really think of there being a "localhost" type thing in J1939.
>> The address go with specific function, not devices, Often one physical
>> device claims multiple addresses on the network, one for each thing
>> that device does. For my module, when the program opening the socket
>> does not know or care about which address to use, I simply claim an
>> address for it that is unused and in the self-configurable range.
>
> This sounds like a usage policy enforced by the kernel API semantics.
> At least, I understand the background a bit more.
> More on this below.
>
>>
>> >> > > > I remember our discussion about the address claiming but I wonder if we
>> >> > > > really follow the requirement to only put functionality into the kernel
>> >> > > > that really has to be implemented there.
>> >> >
>> >> > The kernel tracks and validates J1939 traffic. Any userspace application
>> >> > can track, but none can validate & reject without duplicating effort.
>> >>
>> >> I too think at least part of the address handling needs to be in the
>> >> kernel module.
>> >>
>> >> > > > Did you take a look at https://github.com/ISOBlue/isoblue-software -
>> >> > > > which is far simpler - whether it can fulfill the basic functionalities
>> >> > > > (segmentation, etc.) to enable j1939 for Linux?
>> >> >
>> >> > I took a quick look. It appears that they only put the address claiming
>> >> > in the kernel. I understand that this is exactly your concern in my
>> >> > implementation :-).
>> >>
>> >> Yes, my implementation does address claiming in the module. From what
>> >> I understand, mine does even more of the process than Kurt's does (my
>> >> module actually sends the address claim messages). However, my module
>> >> does not deal with NAMEs, only the addresses.
>> >
>> > I'd like to know your idea:
>> > Is it possible with isoblue to have multiple sockets using the same
>> > source address?
>> > How does an application needs to deal with address changes? Does every
>> > application just receives the address claims without asking?
>>
>> No, my module does not allow multiple sockets with the same address.
>> My module takes the view that address go to functions, not devices,
>> and assumes one socket per function.
>
> So a single application deals with the entire source address.
> It seems that quite a lot of code gets duplicated, especially the
> diagnostics interfaces.
> I tend to look at a linux box as having different functions/addresses,
> and moreover, I look to a single address as being handled by different
> processes, of which most are generic processes with different
> parameters.
>
> Things like ECU version information (I lost the precise PGN now), DM1,
> DM2 & DM3 handling, ... all seem very generic processes to me that all process
> a well-defined distinct set of PGN's, and can be reused easily.
> The easier each single application becomes, the quicker it can become
> stable, so I avoided the all-in-one approach.

Now I see the value of this use case.

I like the address claiming being in the kernel module. It does have
timing requirements to be met, and it's code every application would
have to repeat otherwise. Perhaps there could be a socket option
telling the kernel module to allow assigning an address already in use
by another socket?

That being said, if everyone else wants less (or no) address claiming
in the kernel module than my implementation has, I could live with
that.

>> If a socket loses its address, that socket returns -EADDRINUSE the
>> next time a function is called on it (e.g., recvmesg). When that
>> happens, the program must use bind again to get a new address. I had
>> hoped to one day implement transparently claiming another address if
>> the socket was set as self-configurable.
>>
>> My module has support for filtering which PGNs a socket actually
>> receives. If the filters on the socket allow address claim messages
>> through, the socket will see them.
>
> Given my major remark above, I can understand these API choices :-)
>
> One of the differences between our approaches is that you implicitely assign
> addresses to the interface on kernel level by opening sockets.
> As with your proposal above, this allows a non-root user to add
> addresses.
> I'm considering such approach. Would it make the difference?
> I would then drop the netlink interface, and add some summary
> in /proc for diagnose of the actual used source addresses.

I see J1939 addresses as being closer to TCP/IP ports rather than
addresses (the go with functions/applications rather than devices),
and non-root users can open new TCP/IP ports. In my opinion this
aligns with how existing socket types work and so not an issue, but it
is an opinion.

Perhaps we should get opinions on this from Oliver and anyone else who
has one? Personally, I think if you take that approach your
implementation would be pretty darn close to what I envisions mine
being one day.


Alex
