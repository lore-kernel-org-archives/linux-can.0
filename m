From: "Gole, Anant" <anantgole@ti.com>
Subject: RE: [PATCH] ARM: OMAP: AM33XX: CAN: d_can: Add support for Bosch
 D_CAN controller
Date: Thu, 5 Apr 2012 15:54:52 +0000
Message-ID: <3F602CD5BF1C69469B2F060E90850642BD93A9@DQHE01.ent.ti.com>
References: <1333456339-9372-1-git-send-email-anilkumar@ti.com>
 <4F7AF0C7.7020506@grandegger.com>
 <331ABD5ECB02734CA317220B2BBEABC1317D85D0@DBDE01.ent.ti.com>
 <4F7AFFEC.1010805@pengutronix.de>
 <331ABD5ECB02734CA317220B2BBEABC1317D86F7@DBDE01.ent.ti.com>
 <4F7B1854.90106@pengutronix.de>
 <331ABD5ECB02734CA317220B2BBEABC1317D88B7@DBDE01.ent.ti.com>
 <4F7C7515.4070802@grandegger.com>
 <331ABD5ECB02734CA317220B2BBEABC1317DACC6@DBDE01.ent.ti.com>
 <4F7DAA11.6080109@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53828 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752173Ab2DEPzL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Apr 2012 11:55:11 -0400
In-Reply-To: <4F7DAA11.6080109@mlbassoc.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gary Thomas <gary@mlbassoc.com>, "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "m.kleine-budde@pengutronix.de" <m.kleine-budde@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Nori, Sekhar" <nsekhar@ti.com>

>
>Sorry to drop in late on this discussion, but what's wrong with
>just using the d_can driver from TI?  I have successfully used
>it on AM3874 and I'm pretty sure that maps onto AM33xx as well.
>
>Note: as far as I know, this driver is only in the TI PSP kernels.
>I extracted it from an Angstrom build for the BeagleBone which
>is AM33xx based.

It is the same driver that you picked from Angstrom done by Anil - 
it is being submitted for upstream through this list.

Regards,
Anant
