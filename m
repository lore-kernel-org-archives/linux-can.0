From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v10] can: c_can: Add runtime PM support to Bosch
 C_CAN/D_CAN controller
Date: Thu, 13 Sep 2012 10:46:23 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA2E490@DBDE01.ent.ti.com>
References: <1347525263-28414-1-git-send-email-mkl@pengutronix.de>
 <331ABD5ECB02734CA317220B2BBEABC13EA2E2E3@DBDE01.ent.ti.com>
 <5051A40F.2090205@pengutronix.de>
 <331ABD5ECB02734CA317220B2BBEABC13EA2E345@DBDE01.ent.ti.com>
 <5051A71A.6080800@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34470 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751889Ab2IMKqy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 13 Sep 2012 06:46:54 -0400
In-Reply-To: <5051A71A.6080800@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Marc,

On Thu, Sep 13, 2012 at 14:57:54, Marc Kleine-Budde wrote:
> On 09/13/2012 11:20 AM, AnilKumar, Chimata wrote:
> [...]
> 
> >>> While committing "Adopt pinctrl support" patch on top
> >>> of this patch I saw some error, can you fix that?
> >>
> >> Sure, already done :) I'll force push that on net-next/master
> 
> Done, can you please retest.
> 

I have tested with latest linux-can/master, its working no
issues.

Thanks
AnilKumar
