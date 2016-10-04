From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: j1939
Date: Tue, 4 Oct 2016 09:41:53 +0200
Message-ID: <20161004074153.GC13813@airbook.vandijck-laurijssen.be>
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <018c2e89-87c0-c1cc-686e-d5d715651ab3@hartkopp.net>
 <9a40e851-4bc8-f57c-ffc5-478f3ea93acb@pengutronix.de>
 <1be622f4-1376-189b-9180-487aef3dc636@hartkopp.net>
 <CANGgnMaxNRBDG9WWAanHEem-wDJ1ujxYdqgko7nAx3iJNcPUGA@mail.gmail.com>
 <6d3c3af0-12bb-ba14-c8f9-a8837da82795@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:37841 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753946AbcJDMo3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Oct 2016 08:44:29 -0400
Content-Disposition: inline
In-Reply-To: <6d3c3af0-12bb-ba14-c8f9-a8837da82795@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Austin Schuh <austin@peloton-tech.com>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>

> 
> On 09/19/2016 11:37 PM, Austin Schuh wrote:
> >>>> What about putting them into socket depended sockopts with setsockopt()?
> >>>
> >>> Is it a per interface or a per socket setting?
> >>
> >> At least for iso-tp these kind of settings are transport channel
> >> specific. Don't know if this can be applied to j1939 too.
> >>
> >> This is something Kurt or others can answer better than me.
> > 
> > These parameters should be defined by the standard.  For the padding,
> > I'm not aware of any messages (besides the RQST message which should
> > be 3 bytes long) which are not already 8 bytes.  If you want to
> > enforce that, I would think it would be better to refuse to accept the
> > packet rather than pad it out to surprise the user less.
> 
> So an option is to check if PGN is 0xea00 then length must be 3,
> otherwise length must be 8?
> 
> > The unused bits should be set to 1, but that's hard to do at the
> > driver level when you don't know which bits are used and which are
> > unused in a request.
> 
> The padding is done in the j1939_send() function. So padding is no
> problem here.
> 
> > SAE J1939-21 defines all the timing requirements and other constraints
> > pretty well.  Is there a reason to make them configurable?
> 
> Dunno...Kurt?

As said in a previous email, to support different environments.
The timings are defined in the standard, but in a 'receive' way, i.e.
the standard defines what timing is acceptable.
For the TX path, you may prefer to send ASAP (most of the times) or to
relax the timing so the opposite side can keep up. This preference does
not violate the standard.

> 
> Marc
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 



