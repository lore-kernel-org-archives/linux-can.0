From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: [PATCH] ARM: OMAP: AM33XX: CAN: d_can: Add support for Bosch
 D_CAN controller
Date: Thu, 05 Apr 2012 08:20:01 -0600
Message-ID: <4F7DAA11.6080109@mlbassoc.com>
References: <1333456339-9372-1-git-send-email-anilkumar@ti.com> <4F7AF0C7.7020506@grandegger.com> <331ABD5ECB02734CA317220B2BBEABC1317D85D0@DBDE01.ent.ti.com> <4F7AFFEC.1010805@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC1317D86F7@DBDE01.ent.ti.com> <4F7B1854.90106@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC1317D88B7@DBDE01.ent.ti.com> <4F7C7515.4070802@grandegger.com> <331ABD5ECB02734CA317220B2BBEABC1317DACC6@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([64.234.241.98]:59833 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539Ab2DEOUE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Apr 2012 10:20:04 -0400
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC1317DACC6@DBDE01.ent.ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "m.kleine-budde@pengutronix.de" <m.kleine-budde@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

On 2012-04-05 08:15, AnilKumar, Chimata wrote:
> [dropped some cross-posted lists I had added as requested by Oliver]
>
> On Wed, Apr 04, 2012 at 21:51:41, Wolfgang Grandegger wrote:
>
>> I did look into the manual. Unfortunately, a direct mapping of the C_CAN
>> to the D_CAN registers seems not possible. It's not just a different
>> alignment but sometimes two 16-bit C_CAN registers are folded into *one*
>> 32-bit D_CAN register. Therefore we need something more clever, e.g.
>
> Yes, it's definitely not straightforward.
>
>> using a separate struct or union or handling those register separately.
>> I still think, if feasible, we should avoid an extra driver for the
>> D_CAN controller, also because we sooner than later need the same
>> infrastructure (register_c_can_dev etc.).
>
> Okay, I started hacking the c_can driver to add d_can support
> this way. I will update soon with results/patches.
>
> I hope too that we don't have to add an extra driver.

Sorry to drop in late on this discussion, but what's wrong with
just using the d_can driver from TI?  I have successfully used
it on AM3874 and I'm pretty sure that maps onto AM33xx as well.

Note: as far as I know, this driver is only in the TI PSP kernels.
I extracted it from an Angstrom build for the BeagleBone which
is AM33xx based.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
