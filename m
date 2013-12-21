From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [can:for-davem 3/3] drivers/net/can/ti_hecc.c:909:7: warning:
 assignment makes pointer from integer without a cast
Date: Sat, 21 Dec 2013 20:21:58 -0300
Message-ID: <20131221232157.GB12243@localhost>
References: <52b60e29.e6MbNbPY4sH1N+Ql%fengguang.wu@intel.com>
 <52B60F21.5070502@pengutronix.de>
 <20131221225722.GA12243@localhost>
 <52B61E95.1050706@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:44625 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755141Ab3LUXVo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 21 Dec 2013 18:21:44 -0500
Content-Disposition: inline
In-Reply-To: <52B61E95.1050706@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

On Sun, Dec 22, 2013 at 12:04:53AM +0100, Marc Kleine-Budde wrote:
> On 12/21/2013 11:57 PM, Ezequiel Garcia wrote:
> [...]
>=20
> >> Should we go back to "depends on ARM"?
>=20
> > Well, it seems user-mode linux has no ioremap? So, maybe we'll have=
 to
> > live with "depends on ARM" unless anyone has a better idea.
>=20
> Then it's Patch v2.
>=20

What puzzles me is that other drivers are doing this same COMPILE_TEST
trick (see MTD_NAND_SH_FLCTL). I guess they just ignore the 0-day build
error?

Anyway... I agree with going with v2.
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
