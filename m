From: David Jander <david@protonic.nl>
Subject: Re: j1939
Date: Tue, 20 Sep 2016 09:15:25 +0200
Message-ID: <20160920091525.2ff22d58@erd980>
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
        <018c2e89-87c0-c1cc-686e-d5d715651ab3@hartkopp.net>
        <9a40e851-4bc8-f57c-ffc5-478f3ea93acb@pengutronix.de>
        <1be622f4-1376-189b-9180-487aef3dc636@hartkopp.net>
        <CANGgnMaxNRBDG9WWAanHEem-wDJ1ujxYdqgko7nAx3iJNcPUGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:2722 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752187AbcITHrw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 20 Sep 2016 03:47:52 -0400
In-Reply-To: <CANGgnMaxNRBDG9WWAanHEem-wDJ1ujxYdqgko7nAx3iJNcPUGA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can <linux-can@vger.kernel.org>, Kurt Van Dijck <kurt.van.dijck@eia.be>

On Mon, 19 Sep 2016 14:37:15 -0700
Austin Schuh <austin@peloton-tech.com> wrote:

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

This is true only for 99% of all J1939 messages. I need to investigate some
more, but I fear this option can better be removed. I couldn't think of a
situation where I'd ponder setting this parameter to true.

> > >>>> ./transport.c:60:MODULE_PARM_DESC(transport_burst_count, "Number of packets to send in burst between flow control (1..255, default 255)");

Usually you'd want this parameter to be 255, except for some special
situations, and I think this should be a per-socket setting.

> > >>>> ./transport.c:61:MODULE_PARM_DESC(transport_max_size, "Maximum packet size (default 100k)");

No idea if this limit makes any sense to the kernel driver... for the protocol
it doesn't. For ISOBus applications this limit is much too low. ISOBus VT
clients for example can easily send packets of several times that amount.
IMHO, this parameter should either be removed or set to infinite per default.

> > >>>> ./transport.c:62:MODULE_PARM_DESC(transport_retry_time, "Packet retransmission timeout in msecs, used in case of buffer full. (default 20)");
> > >>>> ./transport.c:63:MODULE_PARM_DESC(transport_packet_delay, "Delay between packets to avoid buffer overruns (default 0)");  

These two parameters could be a per interface setting I believe.

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
> 
> Austin

Best regards,

-- 
David Jander
Protonic Holland.
