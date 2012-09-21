From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH] can: c_can: Add d_can suspend resume support
Date: Fri, 21 Sep 2012 10:16:28 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA389E1@DBDE01.ent.ti.com>
References: <1348221541-28878-1-git-send-email-anilkumar@ti.com>
 <505C3D4A.5030205@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33302 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362Ab2IUKQn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 21 Sep 2012 06:16:43 -0400
In-Reply-To: <505C3D4A.5030205@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

Hi Marc,

On Fri, Sep 21, 2012 at 15:41:22, Marc Kleine-Budde wrote:
> On 09/21/2012 11:59 AM, AnilKumar Ch wrote:
> > Adds suspend resume support to DCAN driver which enables
> > DCAN power down mode bit (PDR). Then DCAN will ack the local
> > power-down mode by setting PDA bit in STATUS register.
> 
> Applied to can-next. I've updated the master branch in the can-next

Thanks for pushing,

> repo. AnilKumar, I think I should squash patch "of: Modify c_can binding
> documentation" into "can: c_can: Add device tree support to Bosch
> C_CAN/D_CAN controller". What do you think?
> 

Yes, good to have in a patch where C_CAN DT support is added.
No issues.

Thanks
AnilKumar
