From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Wed, 19 Sep 2012 11:04:45 +0200
Message-ID: <20120919090445.GA1612@vandijck-laurijssen.be>
References: <50586A50.5060300@pengutronix.de>
 <50586DE4.9020707@grandegger.com>
 <50587058.7090703@pengutronix.de>
 <50587987.3070308@grandegger.com>
 <50587A4F.5060105@pengutronix.de>
 <5058C28A.5030300@grandegger.com>
 <5058C505.6020605@pengutronix.de>
 <5058C7EC.1080206@grandegger.com>
 <20120918202018.GA78585@macbook.local>
 <50595B4A.10409@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay004.isp.belgacom.be ([195.238.6.170]:8542 "EHLO
	mailrelay004.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752313Ab2ISJFD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 19 Sep 2012 05:05:03 -0400
Content-Disposition: inline
In-Reply-To: <50595B4A.10409@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, =?utf-8?Q?Heinz-J=C3=BCrgen?= Oertel <oe@port.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Wed, Sep 19, 2012 at 07:42:34AM +0200, Oliver Hartkopp wrote:
> On 18.09.2012 22:20, Kurt Van Dijck wrote:
>=20
> > On Tue, Sep 18, 2012 at 09:13:48PM +0200, Wolfgang Grandegger wrote=
:
> >> On 09/18/2012 09:01 PM, Marc Kleine-Budde wrote:
> >>> On 09/18/2012 08:50 PM, Wolfgang Grandegger wrote:
> >>>> On 09/18/2012 03:42 PM, Marc Kleine-Budde wrote:
> >>>>> On 09/18/2012 03:39 PM, Wolfgang Grandegger wrote:
> >>>>>> On 09/18/2012 03:00 PM, Marc Kleine-Budde wrote:
> >>>>>>> On 09/18/2012 02:49 PM, Wolfgang Grandegger wrote:
> >>>>>>> [...]
> >>>>>>>
> >>>>>>>>> We have several customers who asked how to abort pending TX=
 messages,
> >>>>>>>>> too. Which involves:
> >>>>>>>>> a) clear the TX-queue in Linux
> >>>>>>>>> b) clear queue in hardware
> >>>>>>>>> c) abort currently transmitting CAN frame
> >>>>>>>>>
> >>>>>>>>> I think c) would be a usecase of its own, too.
> >>>>>>>>
> >>>>>>>> I think you need c) for b), at least for some controllers. T=
hese
> >>>>>>>
> >>>>>>> Yes, if it's a hardware limitation so be it. But if we design=
 an
> >>>>>>> interface it should support "clear everything" (a+b+c), but a=
lso just
> >>>>>>> only c.
> >>>>>>
> >>>>>> Yes, that you be nice. The only portable "clear everything" (a=
+b+c) I
> >>>>>> see is "ifconfig down -> up". This also answers you other rela=
ted mail.
> >>>>>>
> >>>>>> What do people really want/need and why? This is still not cle=
ar to me.
> >>>>>> More input would be nice.
> >>>>>
> >>>>> Heinz-J=C3=BCrgen uses abort current TX Message on SJA1000, can=
 you give us
> >>>>> more insight? I've talked to customers, e.g. they want to abort=
 the
> >>>>> current frame if it takes "too long" to send it, because the fr=
ames CAN
> >>>>> id priority is too low.
> >=20
> > If "too long" is defined as a period of time where it makes sense t=
o
> > take such actions in software (like > 10msec), and your message sti=
ll
> > did not get out, but you wanted it to be,
> > then IMO the bus load is too high with regard to the expected time =
restrictions.
> >=20
> > Or am I missing something?
>=20
>=20
> The question is, if we should add some time of expiry to the tx-skb?!=
?
>=20
> I have not checked whether the new ematch queuing discipline
>=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3Dco=
mmitdiff;h=3Df057bbb6f9ed0fb61ea11105c9ef0ed5ac1a354d
>=20
> http://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf
>=20
> would allow already to sort out expired skbs.
>=20
> This is probably the preferred solution instead of checking expired s=
kbs
> inside the driver.
> =20

I did not check the qdisc code.

Would this expiry be a per-skb option (maybe per-socket), then I think
this solves the unclear usecase mentioned above, while not
being too invasive in current and future designs.

Kurt

