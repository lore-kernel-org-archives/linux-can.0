From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: [PATCH] ARM: OMAP: AM33XX: CAN: d_can: Add support for Bosch
 D_CAN controller
Date: Thu, 05 Apr 2012 10:00:48 -0600
Message-ID: <4F7DC1B0.2070105@mlbassoc.com>
References: <1333456339-9372-1-git-send-email-anilkumar@ti.com> <4F7AF0C7.7020506@grandegger.com> <331ABD5ECB02734CA317220B2BBEABC1317D85D0@DBDE01.ent.ti.com> <4F7AFFEC.1010805@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC1317D86F7@DBDE01.ent.ti.com> <4F7B1854.90106@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC1317D88B7@DBDE01.ent.ti.com> <4F7C7515.4070802@grandegger.com> <331ABD5ECB02734CA317220B2BBEABC1317DACC6@DBDE01.ent.ti.com> <4F7DAA11.6080109@mlbassoc.com> <3F602CD5BF1C69469B2F060E90850642BD93A9@DQHE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([64.234.241.98]:60981 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446Ab2DEQAu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Apr 2012 12:00:50 -0400
In-Reply-To: <3F602CD5BF1C69469B2F060E90850642BD93A9@DQHE01.ent.ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Gole, Anant" <anantgole@ti.com>
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "m.kleine-budde@pengutronix.de" <m.kleine-budde@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Nori, Sekhar" <nsekhar@ti.com>

On 2012-04-05 09:54, Gole, Anant wrote:
>>
>> Sorry to drop in late on this discussion, but what's wrong with
>> just using the d_can driver from TI?  I have successfully used
>> it on AM3874 and I'm pretty sure that maps onto AM33xx as well.
>>
>> Note: as far as I know, this driver is only in the TI PSP kernels.
>> I extracted it from an Angstrom build for the BeagleBone which
>> is AM33xx based.
>
> It is the same driver that you picked from Angstrom done by Anil -
> it is being submitted for upstream through this list.

Good, thanks.  Some of the comments in this thread implied that
it was not quite the same.

Glad to hear that this will finally make it mainstream someday.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
