From: Arnej Duranovic <arnejduranovic@pm.me>
Subject: Re: J1939: /proc/net/can interface
Date: Wed, 17 Jun 2020 14:14:25 +0000
Message-ID: <hnYzPLiW0iarondCAesso_T4K1RQoJphq2FgiwQa6cRGPv1X6RvEaMoyuJgN67Cr8PRr_TEVrPOSdgomsrdVsBapHgWua3xHQq3dtcrZQrg=@pm.me>
References: <4SjA_8nFwOgutMJ5YoVaQPwX-zU-3shqgm7lsWxNWIQas0hIsCMdujJJbEJXOdxFjnDlDTqaDs4yiOXhAgZUYDUKIHXKcwtih3aa1fL8LV4=@pm.me> <20200617125949.GA12583@x1.vandijck-laurijssen.be> <86064094-05f7-edc7-db98-d3c9d41592b0@pengutronix.de>
Reply-To: Arnej Duranovic <arnejduranovic@pm.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-40131.protonmail.ch ([185.70.40.131]:59474 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgFQOOb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 Jun 2020 10:14:31 -0400
In-Reply-To: <86064094-05f7-edc7-db98-d3c9d41592b0@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Wednesday, June 17, 2020 8:03 AM, Marc Kleine-Budde <mkl@pengutronix.de>=
 wrote:

> On 6/17/20 2:59 PM, Kurt Van Dijck wrote:
>
> > > -   6.  /proc/net/can-j1939 Interface.
> > > -
> > > -
> > > -   Files giving you a view on the in-kernel operation of J1939 are l=
ocated at:
> > > -   /proc/net/j1939.
> > > -
> > > -   6.1 /proc/net/can-j1939/ecu
> > > -
> > > -   This file gives an overview of the known ECU's to the kernel.
> > > -   -   iface : network interface they operate on.
> > > -   -   SA : current address.
> > > -   -   name : 64bit NAME
> > > -   -   flags : 'L' =3D local, 'R' =3D remote
> > >
> > > I am interested in what happened to this feature since I do not see i=
t in the latest implementation or in the documentation?
> >
> > The feature got removed, as (almost) all of the /proc interface
> > for making mainline integration easier.
> > The idea was to restore the required interfaces when necessary.

That's what I thought, thanks!

>
> ...or rather use something modern and machine readable.
>
> > > I am interested in retrieving "known ECU's to the kernel" in the late=
st implementation. What is recommended?
> >
> > I understand your question. The simple answer right now is: there isn't=
.
> > we could debate about this being necessary in /proc,
> > or rather in debugfs,
> > since this knowledge should not be used in real applications?
> > Am I right that your intended use is debugging related?

I think this would be great for debugging and helpful in a development envi=
ronment but I am being asked to include this feature in production. If you =
have time, can you please elaborate on why this should not be used in real =
applications?

>
> Today we probably want to have a netlink interface to read that informati=
on from
> the kernel.
>
> Marc
>
> -------------------------------------------------------------------------=
----------------------------
>
> Pengutronix e.K. | Marc Kleine-Budde |
> Embedded Linux | https://www.pengutronix.de |
> Vertretung West/Dortmund | Phone: +49-231-2826-924 |
> Amtsgericht Hildesheim, HRA 2686 | Fax: +49-5121-206917-5555 |
