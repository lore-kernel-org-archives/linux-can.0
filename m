From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH 0/4] Add DT support to C_CAN/D_CAN controller
Date: Wed, 25 Jul 2012 09:19:14 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA031DB@DBDE01.ent.ti.com>
References: <1343197417-27481-1-git-send-email-anilkumar@ti.com>
 <500FB695.4080103@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56239 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932767Ab2GYJVF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 25 Jul 2012 05:21:05 -0400
In-Reply-To: <500FB695.4080103@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

Marc,

Thanks for the review.

On Wed, Jul 25, 2012 at 14:34:21, Marc Kleine-Budde wrote:
> On 07/25/2012 08:23 AM, AnilKumar Ch wrote:
> > This patch series adds the device tree support to C_CAN/D_CAN
> > controller with pinmux configuration and device tree data
> > addition to corresponding dts and dtsi files.
> > 
> > Also adds Runtime PM support to C_CAN/D_CAN controller.
> > 
> > These patches have been tested on AM335x EVM using some additional
> > patch to initialize D_CAN RAM. D_CAN raminit is controlled from
> > control module register. This patch will be submitted once control
> > module MFD driver support is added to mainline.
> > 
> > Due to lack of hardware I am not able to test c_can functionality.
> > I appreciate if anyone can test c_can functionality with this patch
> > series.
> > 
> > First and last patches applies on top of linux-next tree, 2nd and
> > 3rd patches applies on linux-omap tree.
> 
> I think 1st and 4th patch (if not all) should go though the
> linux-can-next tree. Please rebase against linux-can-next master. If you
> need features from the v3.6 release cycle we have to wait until David
> merges then back.
> 

I will separate out into two sereis one with 1st and 4th patches and other
with 2nd and 3rd patches. I will submit v2 based on linux-can-nest master.

Thanks
AnilKumar