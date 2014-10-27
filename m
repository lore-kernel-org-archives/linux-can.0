From: David Jander <david@protonic.nl>
Subject: Re: flexcan napi poll and error frames
Date: Mon, 27 Oct 2014 08:29:55 +0100
Message-ID: <20141027082955.52ecece2@archvile>
References: <544A2943.1080808@marel.com>
	<544A64A1.3050104@marel.com>
	<544A78A8.40909@marel.com>
	<4764001.1dH8LXDQX4@lisa>
	<544A8F03.8040906@marel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:11748 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbaJ0H33 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 27 Oct 2014 03:29:29 -0400
In-Reply-To: <544A8F03.8040906@marel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>
Cc: Steffen Rose <ro@emtas.de>, linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>


Hi Andri,

On Fri, 24 Oct 2014 17:40:19 +0000
Andri Yngvason <andri.yngvason@marel.com> wrote:

>=20
> On f=C3=B6s 24.okt 2014 16:36, Steffen Rose wrote:
> > Hello,
> >
> > Am Freitag, 24. Oktober 2014, 16:04:56 schrieben Sie:
> >>> We can do little if the CAN controller does not notify the Softwa=
re
> >>>> via interrupt.
> >>> Yes, that's why I wanted to figure out if it's a controller probl=
em or
> >>> not.
> >>> Turns out it's a controller problem, but perhaps we can work arou=
nd it?
> >>> E.g. if we check esr for state changes every time someone transmi=
ts a
> >>> frame, both of these problems would go away. Would it be unaccept=
able
> >>> overhead to do so?
> >> I've just confirmed that this "fix" works, but only if berr-report=
ing is
> >> enabled.
> > Is this workaround working in case of an open CAN Bus?
> > (Ack error situation)
> Yes
> > The flexcan can generate an error interrupt after every CAN bus err=
or. But
> > in case of an error situation the interrupt load would be very high=
 (e.g.
> > short circuit of the CAN).
> >
> That's what berr-reporting does, right? Considering that when the bus=
 is
> flooded with errors, things are in a pretty bad shape anyway, I think=
 it's
> not really going to contribute much to the over-all mess to just leav=
e the
> error interrupts on all the time. It's far worse if the user doesn't =
get
> the correct error state.
>=20
> Anyway, defensive measures can be taken. When the bus has reached
> error-passive, the driver is not going to need those interrupts any m=
ore
> so it could turn off the interrupts until the bus goes to bus-off or =
back
> down to warning or active; except when berr-reporting is enabled.

Would you mind trying out the patch series posted a few days ago here:

http://article.gmane.org/gmane.linux.can/6654

It applies to the flexcan-next branch of
git://gitorious.org/linux-can/linux-can-next.git
(base commit should be 907aa2d61697035a921cad6375c0d546b1d18af6 if HEAD=
 fails).

I think it solves your problem.

Best regards,

--=20
David Jander
Protonic Holland.
