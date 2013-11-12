From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: AW: Need support J1939 protocol support to my kernel (v3.8 on
 BeagleBone Black)
Date: Tue, 12 Nov 2013 11:02:22 +0100
Message-ID: <20131112100222.GA3748@vandijck-laurijssen.be>
References: <zarafa.5281024a.0b28.43b8b0d35b442ecc@v14647.1blu.de>
 <loom.20131112T015933-695@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay009.isp.belgacom.be ([195.238.6.176]:6784 "EHLO
	mailrelay009.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752615Ab3KLKC3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 12 Nov 2013 05:02:29 -0500
Content-Disposition: inline
In-Reply-To: <loom.20131112T015933-695@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: swapnil <patilswa@gmail.com>, Michael Luxen <mluxen@gmx.net>
Cc: linux-can@vger.kernel.org

Hey all,

Maybe Michael was a bit too fast.
I suspect you tried to merge the j1939 linux kernel into can-utils ?

On Tue, Nov 12, 2013 at 01:10:04AM +0000, swapnil wrote:
> Michael Luxen <mluxen <at> gmx.net> writes:
>=20
> >=20
> > Hello Swapnil,
> >=20
> > I've success with building the J1939 stack on my BBB based on Debia=
n using=20
> these steps:
> >=20
> > git clone git://gitorious.org/linux-can/can-utils.git
> > cd can-utils
> > --- get J1939 stuff ---

So you're in the can-utils directory now. Merge can-utils-j1939

$ git remote add j1939 git://gitorious.org/~kurt-vd/linux-can/can-j1939=
-utils.git
$ git remote update j1939
$ git merge j1939/master

build can-utils now.
And then:

$ cd ..
$ git clone <your kernel>
$ cd linux (or your linux kernel directory)

and then these steps apply.

> > git remote add j1939 git://gitorious.org/~kurt-vd/linux-can/linux-c=
an-j1939.git
> > git remote update j1939
> > --- depending on kernel ---
> > git merge j1939/v3.6
> > ...or=E2=80=A6
> > git merge j1939/v3.8

Maybe this will work better.

Kind regards,
Kurt
