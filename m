From: David Jander <david@protonic.nl>
Subject: Re: flexcan napi poll and error frames
Date: Mon, 27 Oct 2014 15:01:11 +0100
Message-ID: <20141027150111.08248771@archvile>
References: <544A2943.1080808@marel.com>
	<544A64A1.3050104@marel.com>
	<544A78A8.40909@marel.com>
	<4764001.1dH8LXDQX4@lisa>
	<544A8F03.8040906@marel.com>
	<20141027082955.52ecece2@archvile>
	<544E2C19.1050608@marel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:12784 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953AbaJ0OAn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 27 Oct 2014 10:00:43 -0400
In-Reply-To: <544E2C19.1050608@marel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On Mon, 27 Oct 2014 11:27:21 +0000
Andri Yngvason <andri.yngvason@marel.com> wrote:

> Hi David,
>=20
> On m=C3=A1n 27.okt 2014 07:29, David Jander wrote:
> > Andri Yngvason <andri.yngvason@marel.com> wrote:
> >
> >> On f=C3=B6s 24.okt 2014 16:36, Steffen Rose wrote:
> >>> Hello,
> >>>
> >>> Am Freitag, 24. Oktober 2014, 16:04:56 schrieben Sie:
> >>>>> We can do little if the CAN controller does not notify the Soft=
ware
> >>>>>> via interrupt.
> >>>>> Yes, that's why I wanted to figure out if it's a controller pro=
blem or
> >>>>> not.
> >>>>> Turns out it's a controller problem, but perhaps we can work ar=
ound it?
> >>>>> E.g. if we check esr for state changes every time someone trans=
mits a
> >>>>> frame, both of these problems would go away. Would it be unacce=
ptable
> >>>>> overhead to do so?
> >>>> I've just confirmed that this "fix" works, but only if berr-repo=
rting is
> >>>> enabled.
> >>> Is this workaround working in case of an open CAN Bus?
> >>> (Ack error situation)
> >> Yes
> >>> The flexcan can generate an error interrupt after every CAN bus e=
rror.
> >>> But in case of an error situation the interrupt load would be ver=
y high
> >>> (e.g. short circuit of the CAN).
> >>>
> >> That's what berr-reporting does, right? Considering that when the =
bus is
> >> flooded with errors, things are in a pretty bad shape anyway, I th=
ink it's
> >> not really going to contribute much to the over-all mess to just l=
eave the
> >> error interrupts on all the time. It's far worse if the user doesn=
't get
> >> the correct error state.
> >>
> >> Anyway, defensive measures can be taken. When the bus has reached
> >> error-passive, the driver is not going to need those interrupts an=
y more
> >> so it could turn off the interrupts until the bus goes to bus-off =
or back
> >> down to warning or active; except when berr-reporting is enabled.
> > Would you mind trying out the patch series posted a few days ago he=
re:
> >
> > http://article.gmane.org/gmane.linux.can/6654
> >
> > It applies to the flexcan-next branch of
> > git://gitorious.org/linux-can/linux-can-next.git
> > (base commit should be 907aa2d61697035a921cad6375c0d546b1d18af6 if =
HEAD
> > fails).
> >
> > I think it solves your problem.
> >
> Sure, I'll try those patches, but applying them is non-trivial. I.e. =
they
> don't apply. Patching the base commit fails after "Applying: can: rx-=
fifo:
> fix long lines". Could you maybe just send me a link to a git repo or=
 branch
> where they're already applied? A single .patch file might also work.

Hmmm. It seems that tree is kind of a moving target sometimes....
Here's a link to the whole series re-based on top of vanilla 3.17:

https://github.com/yope/linux/tree/flexcan-v3.17

I hope this works for you.

Best regards,

--=20
David Jander
Protonic Holland.
