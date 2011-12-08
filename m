From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: using j1939: AF_CAN missing
Date: Thu, 8 Dec 2011 16:17:25 +0100
Message-ID: <20111208151725.GD964@e-circ.dyndns.org>
References: <loom.20111206T131950-88@post.gmane.org>
 <20111206131815.GD322@e-circ.dyndns.org>
 <loom.20111207T093827-478@post.gmane.org>
 <20111207143333.GD373@e-circ.dyndns.org>
 <20111207145032.GE373@e-circ.dyndns.org>
 <loom.20111208T120006-91@post.gmane.org>
 <20111208123004.GA964@e-circ.dyndns.org>
 <loom.20111208T134455-791@post.gmane.org>
 <20111208133213.GB964@e-circ.dyndns.org>
 <loom.20111208T150123-262@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:20520 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750890Ab1LHPRb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 8 Dec 2011 10:17:31 -0500
Content-Disposition: inline
In-Reply-To: <loom.20111208T150123-262@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Thu, Dec 08, 2011 at 02:27:23PM +0000, Wolfgang wrote:
> > that sounds not good.
> > can-j1939-utils should have binaries like candump, can..., jspy, ja=
cd, ...
>=20
> ^^yes, that is true
>=20
>=20
> =20
> > iproute2-j1939 should have (at least) ip.
>=20
> gosh, it seems that I was a bit puzzled.
>=20
> I wanted to make
>=20
> $ make KERNEL_INCLUDE=3D<KERNEL_HEADER_PATH> CC=3Dpowerpc-603e-linux-=
gnu-gcc
> then=20
I went back to this. I think I indeed puzzled you a bit.

=46or can-(j1939-)modules, you have to 'KERNEL_INCLUDE=3D<KERNEL_HEADER=
_PATH>'
or even better, KERNEL_DIR=3D...,

=46or iproute2(-j1939),=20
$ make CC=3Dpowerpc-603e-linux-gnu-gcc
will do.

But I believe you almost there.

>=20
> utils.c: In function =E2=80=98rt_addrpr_n2a=E2=80=99:
> utils.c:518: error: =E2=80=98AF_CAN=E2=80=99 undeclared (first use in=
 this function)
It appears your toolchain isn't even aware of CAN.
I'm not sure how to solve that one.

Anyone?

Kurt
