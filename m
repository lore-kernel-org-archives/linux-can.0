From: David Jander <david@protonic.nl>
Subject: Re: j1939
Date: Tue, 4 Oct 2016 14:52:02 +0200
Message-ID: <20161004145202.6c5238d9@erd980>
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
        <018c2e89-87c0-c1cc-686e-d5d715651ab3@hartkopp.net>
        <9a40e851-4bc8-f57c-ffc5-478f3ea93acb@pengutronix.de>
        <1be622f4-1376-189b-9180-487aef3dc636@hartkopp.net>
        <CANGgnMaxNRBDG9WWAanHEem-wDJ1ujxYdqgko7nAx3iJNcPUGA@mail.gmail.com>
        <20160920091525.2ff22d58@erd980>
        <20161004073703.GB13813@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:6525 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752074AbcJDMwF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Oct 2016 08:52:05 -0400
In-Reply-To: <20161004073703.GB13813@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: Austin Schuh <austin@peloton-tech.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can <linux-can@vger.kernel.org>

On Tue, 4 Oct 2016 09:37:03 +0200
Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be> wrote:

> --- Original message ---
> > Date:   Tue, 20 Sep 2016 09:15:25 +0200
> > From: David Jander <david@protonic.nl>
> > To: Austin Schuh <austin@peloton-tech.com>
> > Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde
> >  <mkl@pengutronix.de>, linux-can <linux-can@vger.kernel.org>, Kurt Van
> >  Dijck <kurt.van.dijck@eia.be>
> > Subject: Re: j1939
> > X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
> > 
> > On Mon, 19 Sep 2016 14:37:15 -0700
> > Austin Schuh <austin@peloton-tech.com> wrote:
> >   
> > > On Mon, Sep 19, 2016 at 12:45 PM Oliver Hartkopp <socketcan@hartkopp.net> wrote:  
> > > >
> > > >
> > > >
> > > > On 09/19/2016 08:52 PM, Marc Kleine-Budde wrote:    
> > > > > On 09/19/2016 08:27 PM, Oliver Hartkopp wrote:    
> > > > >> On 09/19/2016 06:54 PM, Marc Kleine-Budde wrote:
> > > > >>    
> > > > >>>
> > > > >>> Another thing that IMHO has to be sorted out is the use of module
> > > > >>> parameters:
> > > > >>>    
> > > > >>>> ./main.c:49:MODULE_PARM_DESC(padding, "Pad all packets to 8 bytes, and stuff with 0xff");  
> > 
> > This is true only for 99% of all J1939 messages. I need to investigate some
> > more, but I fear this option can better be removed. I couldn't think of a
> > situation where I'd ponder setting this parameter to true.  
> 
> There exist engine controller software that adhere to this for the
> transport protocol messages. This means, I implemented the transport
> protocol to not necessarily use all 8 bytes at the end.

Do you mean this only applies to TP messages?
In that case, the option may make sense, although according to the standard,
all TP messages should always be 8-bytes long, so when is it desirable to
have non-standard TP-messages? Is this ECU software you mention not
standards-compliant? Does it bark on standards-compliant TP messages?

> > > > >>>> ./transport.c:60:MODULE_PARM_DESC(transport_burst_count, "Number
> > > > >>>> of packets to send in burst between flow control (1..255, default
> > > > >>>> 255)");  
> > 
> > Usually you'd want this parameter to be 255, except for some special
> > situations, and I think this should be a per-socket setting.  
> 
> ack. This should also become a per-socket setting.
> >   
> > > > >>>> ./transport.c:61:MODULE_PARM_DESC(transport_max_size, "Maximum
> > > > >>>> packet size (default 100k)");  
> > 
> > No idea if this limit makes any sense to the kernel driver... for the
> > protocol it doesn't. For ISOBus applications this limit is much too low.
> > ISOBus VT clients for example can easily send packets of several times
> > that amount. IMHO, this parameter should either be removed or set to
> > infinite per default.  
> 
> The default is questionable :-)
> On the other hand, on a low-memory device, it may make no sense to
> allocate buffers for large packets that are not intended for the host
> anyway. To avoid out-of-memory conditions triggered by multiple j1939
> transport sessions, I added this parameter to protect against such
> attack.

Ok, I understand your point. I still feel a bit uncomfortable with having a
default limit that, if the user is not aware of it, can cause a lot of
confusion. Things can suddenly and seemingly randomly not work as expected,
and IMHO this is never good. What can we do about this?

> > > > >>>> ./transport.c:62:MODULE_PARM_DESC(transport_retry_time, "Packet
> > > > >>>> retransmission timeout in msecs, used in case of buffer full.
> > > > >>>> (default
> > > > >>>> 20)"); ./transport.c:63:MODULE_PARM_DESC(transport_packet_delay,
> > > > >>>> "Delay between packets to avoid buffer overruns (default 0)");    
> > 
> > These two parameters could be a per interface setting I believe.  
> 
> as mentioned earlier, the parameters may serve as a system-wide default,
> and may be overruled per socket even (it about the TX path).

System-wide would mean per-interface setting (ip link set...?), but overruled
per socket would imply setsockopt... this seems a bit contradictory to me.
Shouldn't it be either one _or_ the other?

> > > > >>>
> > > > >>> Better convert them to netlink options.  
> 
> I just dropped netlink?
> and I'd first import j1939 in the kernel before going to netlink again.
> having iproute2 out-of-tree patches is not handy.

I agree here.

Best regards,

-- 
David Jander
Protonic Holland.
