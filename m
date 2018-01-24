From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [PATCH 4/4] j1939: remove proc support
Date: Wed, 24 Jan 2018 21:50:26 +0100
Message-ID: <20180124205026.fxnveeioxsbdhvie@pengutronix.de>
References: <20180124110659.438-1-o.rempel@pengutronix.de>
 <20180124110659.438-4-o.rempel@pengutronix.de>
 <20180124201307.GB4214@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37863 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932072AbeAXUua (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 24 Jan 2018 15:50:30 -0500
Content-Disposition: inline
In-Reply-To: <20180124201307.GB4214@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, mkl@pengutronix.de

On Wed, Jan 24, 2018 at 09:13:07PM +0100, Kurt Van Dijck wrote:
> I'm in favor of stripping all unnecessary, but ...

The idea is to make it a step-by-step process: start with mainlining the
absolutely necessary parts, with interfaces where we actually know that
they are right. There might be other functionality which is helpful, but
it can be added at a later point in time.
 
> > Date:   Wed, 24 Jan 2018 12:06:59 +0100
> > From: Oleksij Rempel <o.rempel@pengutronix.de>
> > 
> > to make upstreaming more simple, remove procfs support.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  Documentation/networking/j1939.txt |  82 +----------------------
> >  net/can/j1939/main.c               | 101 ----------------------------
> >  net/can/j1939/transport.c          | 131 +------------------------------------
> >  3 files changed, 5 insertions(+), 309 deletions(-)
> > 
> > diff --git a/Documentation/networking/j1939.txt b/Documentation/networking/j1939.txt
> > index 08f7b035d821..d0e74df97baa 100644
> > --- a/Documentation/networking/j1939.txt
> > +++ b/Documentation/networking/j1939.txt
> > @@ -36,18 +36,7 @@ This file contains
> >      5.3 SO_J1939_RECV_OWN
> >      5.4 SO_J1939_SEND_PRIO
> >  
> > -  6 can-j1939 procfs interface
> > -    6.1 /proc/net/can-j1939/ecu
> > -    6.2 /proc/net/can-j1939/filter
> > -    6.3 /proc/net/can-j1939/sock
> > -    6.4 /proc/net/can-j1939/transport
> 
> the ecu, filter & sock properties can be dropped, but huge transports,
> like those in IsoBUS, remain hidden from an application, but it may be
> usefull to indicate that a transfer is pending.
> Such application relies on /proc/net/can-j1939/transport

In fact we'll need an interface for that, but we are not convinced that
/proc is the right one: /proc is mainly for "human readable" information
or for debugging and not intended as an interface for software.

Do you have an example that shows how this information is being used by
an application? That would be pretty helpful in order to learn about
what the right interface might be (sysfs? netlink? ...)

> > -  7 can-j1939 SYSCTL
> > -    7.1 /proc/sys/net/can-j1939/transport_max_payload_in_bytes
> > -    7.2 /proc/sys/net/can-j1939/transport_cts_nr_of_frames
> > -    7.3 /proc/sys/net/can-j1939/transport_tx_retry_ms
> 
> Those parameters shape the kernels behaviour on transport sessions.
> It makes sense to configure them globally.
> Should this be returned to module parameters then?

Is this information really global? Or is it per interface? What happens
if you have a device with more than one CAN bus?

It also might be good to be able to support network namespaces, so even
global information should be "per namespace" in that case.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
