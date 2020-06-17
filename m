From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939: /proc/net/can interface
Date: Wed, 17 Jun 2020 18:37:41 +0200
Message-ID: <20200617163741.GA14228@x1.vandijck-laurijssen.be>
References: <4SjA_8nFwOgutMJ5YoVaQPwX-zU-3shqgm7lsWxNWIQas0hIsCMdujJJbEJXOdxFjnDlDTqaDs4yiOXhAgZUYDUKIHXKcwtih3aa1fL8LV4=@pm.me>
 <20200617125949.GA12583@x1.vandijck-laurijssen.be>
 <86064094-05f7-edc7-db98-d3c9d41592b0@pengutronix.de>
 <hnYzPLiW0iarondCAesso_T4K1RQoJphq2FgiwQa6cRGPv1X6RvEaMoyuJgN67Cr8PRr_TEVrPOSdgomsrdVsBapHgWua3xHQq3dtcrZQrg=@pm.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:54689 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgFQQh5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 Jun 2020 12:37:57 -0400
Content-Disposition: inline
In-Reply-To: <hnYzPLiW0iarondCAesso_T4K1RQoJphq2FgiwQa6cRGPv1X6RvEaMoyuJgN67Cr8PRr_TEVrPOSdgomsrdVsBapHgWua3xHQq3dtcrZQrg=@pm.me>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Arnej Duranovic <arnejduranovic@pm.me>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On wo, 17 jun 2020 14:14:25 +0000, Arnej Duranovic wrote:
> On Wednesday, June 17, 2020 8:03 AM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> 
> > On 6/17/20 2:59 PM, Kurt Van Dijck wrote:
> >
> > > > -   6.  /proc/net/can-j1939 Interface.
> > > > -
> > > > -
> > > > -   Files giving you a view on the in-kernel operation of J1939 are located at:
> > > > -   /proc/net/j1939.
> > > > -
> > > > -   6.1 /proc/net/can-j1939/ecu
> > > > -
> > > > -   This file gives an overview of the known ECU's to the kernel.
> > > > -   -   iface : network interface they operate on.
> > > > -   -   SA : current address.
> > > > -   -   name : 64bit NAME
> > > > -   -   flags : 'L' = local, 'R' = remote
> > > >
> > > > I am interested in what happened to this feature since I do not see it in the latest implementation or in the documentation?
> > >
> > > The feature got removed, as (almost) all of the /proc interface
> > > for making mainline integration easier.
> > > The idea was to restore the required interfaces when necessary.
> 
> That's what I thought, thanks!
> 
> >
> > ...or rather use something modern and machine readable.
> >
> > > > I am interested in retrieving "known ECU's to the kernel" in the latest implementation. What is recommended?
> > >
> > > I understand your question. The simple answer right now is: there isn't.
> > > we could debate about this being necessary in /proc,
> > > or rather in debugfs,
> > > since this knowledge should not be used in real applications?
> > > Am I right that your intended use is debugging related?
> 
> 
> >
> > Today we probably want to have a netlink interface to read that information from
> > the kernel.

If we consider this an application interface, then yes, but for
debugging only, some ascii debugfs file is way more simple to use.

> I think this would be great for debugging and helpful in a development environment but I am being asked to include this feature in production.
> If you have time, can you please elaborate on why this should not be used in real applications?

The kernel's notion of local/remote ecu's is to verify and validate
traffic and avoid protocol violations.

If an application needs to know all local and/or remote ecu's, then you
listen to traffic on the bus and maintain your own logic.

This provides less obscure situations during transitions due to the
single source of information (j1939 traffic) compared to j1939 traffic
combined with netlink or debugfs information, where the latter is
inherently taken on a different timestamp, out-of-sync with the rest.

Of course, this is not a big problem for all applications, but it is an
essential defect.

If you would want to know all ecu's on a modern J1939 bus, then issue a
request-for-address-claim, and listen to all claimed addressed. That is,
IMHO, a correct way compared to fetching the info from the kernel's
cache. It is also easier to describe, reproduce, debug and maintain.

Kurt
 
