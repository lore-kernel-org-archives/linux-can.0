From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH can-utils 1/3] Update license information for some header
 files
Date: Sun, 12 Jan 2014 20:53:31 +0100
Message-ID: <20140112195331.GA29475@pengutronix.de>
References: <20130817190521.GK30496@pengutronix.de>
 <1389481823-8379-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1389481823-8379-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <52D269D1.9030009@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59355 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbaALTxd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 12 Jan 2014 14:53:33 -0500
Content-Disposition: inline
In-Reply-To: <52D269D1.9030009@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

Hello,

On Sun, Jan 12, 2014 at 11:09:21AM +0100, Oliver Hartkopp wrote:
> On 12.01.2014 00:10, Uwe Kleine-K=F6nig wrote:
> > This corresponds to Linux commits
> >   2485602f1af2 (can: add explicit copyrights to can headers)
> >   1c2da13c21a1 (can: add explicit copyrights to can's netlink heade=
r)
> > ---
> > Hello,
> >=20
> > I would have expected to just need to do something like:
> >=20
> > cd $path_to_canutils
> > rm -r include/socketcan/can
> > cd $path_to_linux
> > git archive --format=3Dtar --prefix=3Dsocketcan/can/ v3.13-rc7:incl=
ude/uapi/linux/can | tar xC $path_to_canutils/include
> > git cat-file blob v3.13-rc7:include/uapi/linux/can.h > $path_to_can=
utils/include/socketcan/can.h
> >=20
> > to sync the header files. I didn't test but some changes introduced=
 by
> > the above sequence seem to be uncompilable so I choosed to only
> > cherry-pick the two Linux commits. IMHO this is a bug (in Linux or
> > can-utils or maybe both).
That is actually easy to resolve. Please don't pick up this patch, I
will send a better one shortly.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
