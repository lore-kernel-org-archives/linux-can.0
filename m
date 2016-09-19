From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: j1939
Date: Mon, 19 Sep 2016 14:37:15 -0700
Message-ID: <CANGgnMaxNRBDG9WWAanHEem-wDJ1ujxYdqgko7nAx3iJNcPUGA@mail.gmail.com>
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <018c2e89-87c0-c1cc-686e-d5d715651ab3@hartkopp.net> <9a40e851-4bc8-f57c-ffc5-478f3ea93acb@pengutronix.de>
 <1be622f4-1376-189b-9180-487aef3dc636@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yb0-f180.google.com ([209.85.213.180]:33655 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932762AbcISVhh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Sep 2016 17:37:37 -0400
Received: by mail-yb0-f180.google.com with SMTP id i66so95232255yba.0
        for <linux-can@vger.kernel.org>; Mon, 19 Sep 2016 14:37:37 -0700 (PDT)
In-Reply-To: <1be622f4-1376-189b-9180-487aef3dc636@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can <linux-can@vger.kernel.org>
Cc: David Jander <david@protonic.nl>, Kurt Van Dijck <kurt.van.dijck@eia.be>

On Mon, Sep 19, 2016 at 12:45 PM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
>
>
> On 09/19/2016 08:52 PM, Marc Kleine-Budde wrote:
> > On 09/19/2016 08:27 PM, Oliver Hartkopp wrote:
> >> On 09/19/2016 06:54 PM, Marc Kleine-Budde wrote:
> >>
> >>>
> >>> Another thing that IMHO has to be sorted out is the use of module
> >>> parameters:
> >>>
> >>>> ./main.c:49:MODULE_PARM_DESC(padding, "Pad all packets to 8 bytes, and stuff with 0xff");
> >>>> ./transport.c:60:MODULE_PARM_DESC(transport_burst_count, "Number of packets to send in burst between flow control (1..255, default 255)");
> >>>> ./transport.c:61:MODULE_PARM_DESC(transport_max_size, "Maximum packet size (default 100k)");
> >>>> ./transport.c:62:MODULE_PARM_DESC(transport_retry_time, "Packet retransmission timeout in msecs, used in case of buffer full. (default 20)");
> >>>> ./transport.c:63:MODULE_PARM_DESC(transport_packet_delay, "Delay between packets to avoid buffer overruns (default 0)");
> >>>
> >>> Better convert them to netlink options.
> >>>
> >>
> >> What about putting them into socket depended sockopts with setsockopt()?
> >
> > Is it a per interface or a per socket setting?
> >
>
> At least for iso-tp these kind of settings are transport channel
> specific. Don't know if this can be applied to j1939 too.
>
> This is something Kurt or others can answer better than me.

These parameters should be defined by the standard.  For the padding,
I'm not aware of any messages (besides the RQST message which should
be 3 bytes long) which are not already 8 bytes.  If you want to
enforce that, I would think it would be better to refuse to accept the
packet rather than pad it out to surprise the user less.  The unused
bits should be set to 1, but that's hard to do at the driver level
when you don't know which bits are used and which are unused in a
request.

SAE J1939-21 defines all the timing requirements and other constraints
pretty well.  Is there a reason to make them configurable?

Austin
