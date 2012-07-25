From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH 0/4] Add DT support to C_CAN/D_CAN controller
Date: Wed, 25 Jul 2012 09:56:36 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA0326A@DBDE01.ent.ti.com>
References: <1343197417-27481-1-git-send-email-anilkumar@ti.com>
 <500FB695.4080103@pengutronix.de>
 <331ABD5ECB02734CA317220B2BBEABC13EA031DB@DBDE01.ent.ti.com>
 <500FBBCB.7000206@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58788 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755502Ab2GYJ4t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 25 Jul 2012 05:56:49 -0400
In-Reply-To: <500FBBCB.7000206@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

Hi Marc,

On Wed, Jul 25, 2012 at 14:56:35, Marc Kleine-Budde wrote:
> On 07/25/2012 11:19 AM, AnilKumar, Chimata wrote:
> [...]
> 
> >>> First and last patches applies on top of linux-next tree, 2nd and
> >>> 3rd patches applies on linux-omap tree.
> >>
> >> I think 1st and 4th patch (if not all) should go though the
> >> linux-can-next tree. Please rebase against linux-can-next master. If you
> >> need features from the v3.6 release cycle we have to wait until David
> >> merges then back.
> >>
> > 
> > I will separate out into two sereis one with 1st and 4th patches and other
> > with 2nd and 3rd patches. I will submit v2 based on linux-can-nest master.
> 
> I think the #ifdef CONFIG_HAVE_CLK will be removed in -rc1, maybe it's
> better to wait until this is done.

My patches are based on linux-next tree have this patch, which removes
CONFIG_HAVE_CLK dependency.

In that case we can use this time for reviewing the patches and once the
-rc1 is ready we can push these patches.

I will submit v2 based on your review comments.

Thanks
AnilKumar