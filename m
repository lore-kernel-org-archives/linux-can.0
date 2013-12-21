From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [can:for-davem 3/3] drivers/net/can/ti_hecc.c:909:7: warning:
 assignment makes pointer from integer without a cast
Date: Sat, 21 Dec 2013 19:57:23 -0300
Message-ID: <20131221225722.GA12243@localhost>
References: <52b60e29.e6MbNbPY4sH1N+Ql%fengguang.wu@intel.com>
 <52B60F21.5070502@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:44570 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751192Ab3LUW5M (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 21 Dec 2013 17:57:12 -0500
Content-Disposition: inline
In-Reply-To: <52B60F21.5070502@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

On Sat, Dec 21, 2013 at 10:58:57PM +0100, Marc Kleine-Budde wrote:
> On 12/21/2013 10:54 PM, kbuild test robot wrote:
> > tree:   git://gitorious.org/linux-can/linux-can-next for-davem
> > head:   5dd64fac3ff28aab5e92548a066c175e00cc9da4
> > commit: 5dd64fac3ff28aab5e92548a066c175e00cc9da4 [3/3] can: ti_hecc=
: Use the OMAP2PLUS dependency for omap2plus devices
> > config: make ARCH=3Dum allyesconfig
> >=20
> > All warnings:
> >=20
> >    drivers/net/can/ti_hecc.c: In function 'ti_hecc_probe':
> >    drivers/net/can/ti_hecc.c:909:2: error: implicit declaration of =
function 'ioremap' [-Werror=3Dimplicit-function-declaration]
> >      addr =3D ioremap(mem->start, resource_size(mem));
> >      ^
> >>> drivers/net/can/ti_hecc.c:909:7: warning: assignment makes pointe=
r from integer without a cast [enabled by default]
> >      addr =3D ioremap(mem->start, resource_size(mem));
> >           ^
> >    drivers/net/can/ti_hecc.c:974:2: error: implicit declaration of =
function 'iounmap' [-Werror=3Dimplicit-function-declaration]
> >      iounmap(addr);
> >      ^
> >    cc1: some warnings being treated as errors
>=20
> Should we go back to "depends on ARM"?
>=20

Well, it seems user-mode linux has no ioremap? So, maybe we'll have to
live with "depends on ARM" unless anyone has a better idea.
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
