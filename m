From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: flexcan napi poll and error frames
Date: Mon, 27 Oct 2014 15:53:18 +0000
Message-ID: <20141027155318.GB29093@shannon>
References: <544A2943.1080808@marel.com> <544A64A1.3050104@marel.com>
 <544A78A8.40909@marel.com> <4764001.1dH8LXDQX4@lisa>
 <544A8F03.8040906@marel.com> <20141027082955.52ecece2@archvile>
 <544E2C19.1050608@marel.com> <20141027150111.08248771@archvile>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1on0066.outbound.protection.outlook.com ([157.56.110.66]:29024
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751060AbaJ0Pxd (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 27 Oct 2014 11:53:33 -0400
Content-Disposition: inline
In-Reply-To: <20141027150111.08248771@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On Mon, Oct 27, 2014 at 03:01:11PM +0100, David Jander wrote:
> On Mon, 27 Oct 2014 11:27:21 +0000
> Andri Yngvason <andri.yngvason@marel.com> wrote:
>=20
> > Hi David,
> >=20
> > On m=E1n 27.okt 2014 07:29, David Jander wrote:
> > > Andri Yngvason <andri.yngvason@marel.com> wrote:
> > >
> > >> On f=F6s 24.okt 2014 16:36, Steffen Rose wrote:
> > >>> Hello,
> > >>>
> > >>> Am Freitag, 24. Oktober 2014, 16:04:56 schrieben Sie:
> > >>>>> We can do little if the CAN controller does not notify the So=
ftware
> > >>>>>> via interrupt.
> > >>>>> Yes, that's why I wanted to figure out if it's a controller p=
roblem or
> > >>>>> not.
> > >>>>> Turns out it's a controller problem, but perhaps we can work =
around it?
> > >>>>> E.g. if we check esr for state changes every time someone tra=
nsmits a
> > >>>>> frame, both of these problems would go away. Would it be unac=
ceptable
> > >>>>> overhead to do so?
> > >>>> I've just confirmed that this "fix" works, but only if berr-re=
porting is
> > >>>> enabled.
> > >>> Is this workaround working in case of an open CAN Bus?
> > >>> (Ack error situation)
> > >> Yes
> > >>> The flexcan can generate an error interrupt after every CAN bus=
 error.
> > >>> But in case of an error situation the interrupt load would be v=
ery high
> > >>> (e.g. short circuit of the CAN).
> > >>>
> > >> That's what berr-reporting does, right? Considering that when th=
e bus is
> > >> flooded with errors, things are in a pretty bad shape anyway, I =
think it's
> > >> not really going to contribute much to the over-all mess to just=
 leave the
> > >> error interrupts on all the time. It's far worse if the user doe=
sn't get
> > >> the correct error state.
> > >>
> > >> Anyway, defensive measures can be taken. When the bus has reache=
d
> > >> error-passive, the driver is not going to need those interrupts =
any more
> > >> so it could turn off the interrupts until the bus goes to bus-of=
f or back
> > >> down to warning or active; except when berr-reporting is enabled=
=2E
> > > Would you mind trying out the patch series posted a few days ago =
here:
> > >
> > > http://article.gmane.org/gmane.linux.can/6654
> > >
> > > It applies to the flexcan-next branch of
> > > git://gitorious.org/linux-can/linux-can-next.git
> > > (base commit should be 907aa2d61697035a921cad6375c0d546b1d18af6 i=
f HEAD
> > > fails).
> > >
> > > I think it solves your problem.
> > >
> > Sure, I'll try those patches, but applying them is non-trivial. I.e=
=2E they
> > don't apply. Patching the base commit fails after "Applying: can: r=
x-fifo:
> > fix long lines". Could you maybe just send me a link to a git repo =
or branch
> > where they're already applied? A single .patch file might also work=
=2E
>=20
> Hmmm. It seems that tree is kind of a moving target sometimes....
> Here's a link to the whole series re-based on top of vanilla 3.17:
>=20
> https://github.com/yope/linux/tree/flexcan-v3.17
>=20
> I hope this works for you.
>=20
Thanks for rabasing this for me. It turns out that the source of all my=
 problems
was my mail client (Thunderbird). It seems to mangle even maildir.

I switched to offlineimap and mutt, and the patches applied. I've been =
trying to
make thunderbird work because co-workers keep sending me HTML mail...

Sorry for making you do that extra work.

--
Andri

