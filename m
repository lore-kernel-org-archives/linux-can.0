From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: [PATCH 4/4] j1939: remove proc support
Date: Thu, 25 Jan 2018 10:29:19 +0100
Message-ID: <20180125092919.GA30696@airbook.vandijck-laurijssen.be>
References: <20180124110659.438-1-o.rempel@pengutronix.de>
 <20180124110659.438-4-o.rempel@pengutronix.de>
 <20180124201307.GB4214@airbook.vandijck-laurijssen.be>
 <20180124205026.fxnveeioxsbdhvie@pengutronix.de>
 <cf9548ff-6d48-fd2b-3c62-a0ab5ed3b0d2@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:37324 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbeAYJ3X (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 Jan 2018 04:29:23 -0500
Content-Disposition: inline
In-Reply-To: <cf9548ff-6d48-fd2b-3c62-a0ab5ed3b0d2@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Robert Schwebel <r.schwebel@pengutronix.de>, Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org


--- Original message ---
> Date: Thu, 25 Jan 2018 09:44:38 +0100
> From: Marc Kleine-Budde <mkl@pengutronix.de>

> On 01/24/2018 09:50 PM, Robert Schwebel wrote:
> > On Wed, Jan 24, 2018 at 09:13:07PM +0100, Kurt Van Dijck wrote:
> >> I'm in favor of stripping all unnecessary, but ...
> > 
> > The idea is to make it a step-by-step process: start with mainlining the
> > absolutely necessary parts, with interfaces where we actually know that
> > they are right. There might be other functionality which is helpful, but
> > it can be added at a later point in time.
> >  
> >>> Date:   Wed, 24 Jan 2018 12:06:59 +0100
> >>> From: Oleksij Rempel <o.rempel@pengutronix.de>
> >>>
> >>> to make upstreaming more simple, remove procfs support.
> >>>
> >>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> >>> ---
> >>>  Documentation/networking/j1939.txt |  82 +----------------------
> >>>  net/can/j1939/main.c               | 101 ----------------------------
> >>>  net/can/j1939/transport.c          | 131 +------------------------------------
> >>>  3 files changed, 5 insertions(+), 309 deletions(-)
> >>>
> >>> diff --git a/Documentation/networking/j1939.txt b/Documentation/networking/j1939.txt
> >>> index 08f7b035d821..d0e74df97baa 100644
> >>> --- a/Documentation/networking/j1939.txt
> >>> +++ b/Documentation/networking/j1939.txt
> >>> @@ -36,18 +36,7 @@ This file contains
> >>>      5.3 SO_J1939_RECV_OWN
> >>>      5.4 SO_J1939_SEND_PRIO
> >>>  
> >>> -  6 can-j1939 procfs interface
> >>> -    6.1 /proc/net/can-j1939/ecu
> >>> -    6.2 /proc/net/can-j1939/filter
> >>> -    6.3 /proc/net/can-j1939/sock
> >>> -    6.4 /proc/net/can-j1939/transport
> >>
> >> the ecu, filter & sock properties can be dropped, but huge transports,
> >> like those in IsoBUS, remain hidden from an application, but it may be
> >> usefull to indicate that a transfer is pending.
> >> Such application relies on /proc/net/can-j1939/transport
> > 
> > In fact we'll need an interface for that, but we are not convinced that
> > /proc is the right one: /proc is mainly for "human readable" information
> > or for debugging and not intended as an interface for software.
> > 
> > Do you have an example that shows how this information is being used by
> > an application? That would be pretty helpful in order to learn about
> > what the right interface might be (sysfs? netlink? ...)

I have no open-source application, but I've contributed to a closed
IsoBUS VT terminal that has a fancy gui illustrating the pending 'object
pool transfers'. I found no better way to communicate this info to the
GUI than via a proc file. The GUI has read access to all pending
transfers, and shows those for a specific PGN.

> > 
> >>> -  7 can-j1939 SYSCTL
> >>> -    7.1 /proc/sys/net/can-j1939/transport_max_payload_in_bytes
> >>> -    7.2 /proc/sys/net/can-j1939/transport_cts_nr_of_frames
> >>> -    7.3 /proc/sys/net/can-j1939/transport_tx_retry_ms
> >>
> >> Those parameters shape the kernels behaviour on transport sessions.
> >> It makes sense to configure them globally.
> >> Should this be returned to module parameters then?
> 
> A module parameter is as global as a sysctl, ....
> 
> > Is this information really global? Or is it per interface? What happens
> > if you have a device with more than one CAN bus?
> > 
> > It also might be good to be able to support network namespaces, so even
> > global information should be "per namespace" in that case.
> 
> ... as long as we don't have namespace support. Then that would be a
> sysctl per namespace.

Theoretically, those parameters are per-interface.
more Realistaclly,
(1) 'max_payload_in_bytes' protects against a memory limitation
which is probably to be applied equally on all interfaces of a system,
(2) cts_nr_of_frames serves a kind of throttling to control the load
of incoming traffic which is probably also platform-wide,
(3) tx_retry_ms is the counterpart, so is probably specific per
destination, so in reality, packet.
I have no indication that anyone wanted to use different tx_retry_ms on
the same j1939 bus. Most of the examples I've seen behave like whales,
i.e. all nodes limit themselves so the slowest and tiniest can keep up.

Kurt
