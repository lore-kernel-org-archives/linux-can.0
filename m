From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH] ARM: OMAP: AM33XX: CAN: d_can: Add support for Bosch
 D_CAN controller
Date: Thu, 5 Apr 2012 14:15:02 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC1317DACC6@DBDE01.ent.ti.com>
References: <1333456339-9372-1-git-send-email-anilkumar@ti.com>
 <4F7AF0C7.7020506@grandegger.com>
 <331ABD5ECB02734CA317220B2BBEABC1317D85D0@DBDE01.ent.ti.com>
 <4F7AFFEC.1010805@pengutronix.de>
 <331ABD5ECB02734CA317220B2BBEABC1317D86F7@DBDE01.ent.ti.com>
 <4F7B1854.90106@pengutronix.de>
 <331ABD5ECB02734CA317220B2BBEABC1317D88B7@DBDE01.ent.ti.com>
 <4F7C7515.4070802@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48419 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753820Ab2DEOPi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Apr 2012 10:15:38 -0400
In-Reply-To: <4F7C7515.4070802@grandegger.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "m.kleine-budde@pengutronix.de" <m.kleine-budde@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

[dropped some cross-posted lists I had added as requested by Oliver]

On Wed, Apr 04, 2012 at 21:51:41, Wolfgang Grandegger wrote:
 
> I did look into the manual. Unfortunately, a direct mapping of the C_CAN
> to the D_CAN registers seems not possible. It's not just a different
> alignment but sometimes two 16-bit C_CAN registers are folded into *one*
> 32-bit D_CAN register. Therefore we need something more clever, e.g.

Yes, it's definitely not straightforward.

> using a separate struct or union or handling those register separately.
> I still think, if feasible, we should avoid an extra driver for the
> D_CAN controller, also because we sooner than later need the same
> infrastructure (register_c_can_dev etc.).

Okay, I started hacking the c_can driver to add d_can support
this way. I will update soon with results/patches.

I hope too that we don't have to add an extra driver.

Thanks,
AnilKumar
