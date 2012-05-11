From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v2 2/4] can: c_can: fix: enable CAN HW interrupts after
 napi_enable()
Date: Fri, 11 May 2012 11:09:48 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13E9BC786@DBDE01.ent.ti.com>
References: <1336649657-4152-1-git-send-email-anilkumar@ti.com>
 <1336649657-4152-3-git-send-email-anilkumar@ti.com>
 <4FAC1427.7070708@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54558 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753259Ab2EKLKA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 May 2012 07:10:00 -0400
In-Reply-To: <4FAC1427.7070708@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>


Hi Marc,

Thanks for the comments,

On Fri, May 11, 2012 at 00:46:55, Marc Kleine-Budde wrote:
> On 05/10/2012 01:34 PM, AnilKumar Ch wrote:
> > Fix the issue of C_CAN interrupts getting disabled forever even though
> > we do can configuration multiple times using can utils. According to
> > NAPI usage we disable all the hardware interrupts in ISR and re-enable
> > them in poll(). Current implementation calls napi_enable() after hardware
> > interrupts are enabled. If we get any interrupts between these two steps
> > then we do not process those interrupts because napi is not enabled. Mostly
> > these interrupts come because of STATUS is not 0x7 or ERROR interrupts. If
> > napi_enable() happens before hardware interrupts enabled then c_can_poll()
> > function will be called eventual re-enabling of interrupts will happen.
> > 
> > This patch moves the napi_enable() call before interrupts enabled.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> 
> Please test on c_can, also this is a stable candidate. What about add
> the term "race condition" to the subject?

I am changing it to
"can: c_can: fix race condition in c_can_open()"

> 
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> Marc
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 
> 

