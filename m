From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: j1939
Date: Tue, 4 Oct 2016 09:28:20 +0200
Message-ID: <20161004072820.GA13813@airbook.vandijck-laurijssen.be>
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <018c2e89-87c0-c1cc-686e-d5d715651ab3@hartkopp.net>
 <9a40e851-4bc8-f57c-ffc5-478f3ea93acb@pengutronix.de>
 <1be622f4-1376-189b-9180-487aef3dc636@hartkopp.net>
 <CANGgnMaxNRBDG9WWAanHEem-wDJ1ujxYdqgko7nAx3iJNcPUGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b01.edpnet.be ([212.71.1.221]:37000 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751549AbcJDMpc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Oct 2016 08:45:32 -0400
Content-Disposition: inline
In-Reply-To: <CANGgnMaxNRBDG9WWAanHEem-wDJ1ujxYdqgko7nAx3iJNcPUGA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>

Hey ho,

Please note my @eia.be address is obsolete now.
I should investigate why the kbuild robot send mail to that address.
this (dev.kurt@...) is meant to stay :-)

Ans I was very occupied the due to a move.
I'm glad there's momentum on the J1939 side, a bit sad it happened just
when I was a bit off.

--- Original message ---
> Date:   Mon, 19 Sep 2016 14:37:15 -0700
> From: Austin Schuh <austin@peloton-tech.com>
> To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde
>  <mkl@pengutronix.de>, linux-can <linux-can@vger.kernel.org>
> Cc: David Jander <david@protonic.nl>, Kurt Van Dijck <kurt.van.dijck@eia.be>
> Subject: Re: j1939
> 
> On Mon, Sep 19, 2016 at 12:45 PM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> >
> >
> >
> > On 09/19/2016 08:52 PM, Marc Kleine-Budde wrote:
> > > On 09/19/2016 08:27 PM, Oliver Hartkopp wrote:
> > >> On 09/19/2016 06:54 PM, Marc Kleine-Budde wrote:
> > >>
> > >>>
> > >>> Another thing that IMHO has to be sorted out is the use of module
> > >>> parameters:
> > >>>
> > >>>> ./main.c:49:MODULE_PARM_DESC(padding, "Pad all packets to 8 bytes, and stuff with 0xff");
> > >>>> ./transport.c:60:MODULE_PARM_DESC(transport_burst_count, "Number of packets to send in burst between flow control (1..255, default 255)");
> > >>>> ./transport.c:61:MODULE_PARM_DESC(transport_max_size, "Maximum packet size (default 100k)");
> > >>>> ./transport.c:62:MODULE_PARM_DESC(transport_retry_time, "Packet retransmission timeout in msecs, used in case of buffer full. (default 20)");
> > >>>> ./transport.c:63:MODULE_PARM_DESC(transport_packet_delay, "Delay between packets to avoid buffer overruns (default 0)");
> > >>>
> > >>> Better convert them to netlink options.
> > >>>
> > >>
> > >> What about putting them into socket depended sockopts with setsockopt()?
> > >
> > > Is it a per interface or a per socket setting?
> > >
> >
> > At least for iso-tp these kind of settings are transport channel
> > specific. Don't know if this can be applied to j1939 too.
> >
> > This is something Kurt or others can answer better than me.
> 
> These parameters should be defined by the standard.  For the padding,
> I'm not aware of any messages (besides the RQST message which should
> be 3 bytes long) which are not already 8 bytes.  If you want to
> enforce that, I would think it would be better to refuse to accept the
> packet rather than pad it out to surprise the user less.  The unused
> bits should be set to 1, but that's hard to do at the driver level
> when you don't know which bits are used and which are unused in a
> request.
> 
> SAE J1939-21 defines all the timing requirements and other constraints
> pretty well.  Is there a reason to make them configurable?

The timing parameters are defined pretty well, but sometimes
light-weight ECU's cannot handle what's defined by the standard.
Therefore, a sort of rate-limiting may be defined.

The 8-byte sutffing also is particular. Do you need to send 7 unused
bytes? The standard says yes, but what happens if you don't.
So I put module parameters there.

Oliver idea is what I was heading to, making a lot of those module
paramters also a socket option, with the module parameters still being
the default. So, the module parameters do not disappear.

I'm still catching up, I agree with David Jander's comments.
