From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v10] can: c_can: Add runtime PM support to Bosch
 C_CAN/D_CAN controller
Date: Thu, 13 Sep 2012 09:20:58 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA2E345@DBDE01.ent.ti.com>
References: <1347525263-28414-1-git-send-email-mkl@pengutronix.de>
 <331ABD5ECB02734CA317220B2BBEABC13EA2E2E3@DBDE01.ent.ti.com>
 <5051A40F.2090205@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42959 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752234Ab2IMJVK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 13 Sep 2012 05:21:10 -0400
In-Reply-To: <5051A40F.2090205@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Thu, Sep 13, 2012 at 14:44:55, Marc Kleine-Budde wrote:
> On 09/13/2012 11:09 AM, AnilKumar, Chimata wrote:
> > On Thu, Sep 13, 2012 at 14:04:23, Marc Kleine-Budde wrote:
> >> From: AnilKumar Ch <anilkumar@ti.com>
> >>
> >> Add Runtime PM support to C_CAN/D_CAN controller. The runtime PM
> >> APIs control clocks for C_CAN/D_CAN IP and prevent access to the
> >> register of C_CAN/D_CAN IP when clock is turned off.
> >>
> >> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> >> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> >> ---
> >> Hello,
> >>
> >> I've squashed both patches into one, also changed:
> >> - add and use c_can_pm_runtime_{enable,disable}
> >> - remove leftovers from c_can_platform.c
> >> - cleaned up error path in register_c_can_dev
> >>
> > 
> > Thanks Marc, its working.
> > 
> > While committing "Adopt pinctrl support" patch on top
> > of this patch I saw some error, can you fix that?
> 
> Sure, already done :) I'll force push that on net-next/master
> 

Thanks much.

Regards
AnilKumar
