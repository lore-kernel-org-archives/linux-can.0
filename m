From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] bfin_can: move the header file to arch independent location
Date: Mon, 29 Dec 2014 17:04:19 +0100
Message-ID: <54A17B83.60206@hartkopp.net>
References: <1419563241-20766-1-git-send-email-Aaron.wu@analog.com> <549E936A.2080904@hartkopp.net> <649EF91064D35D40B9C93A225BF41674612CCDB7@NWD2MBX7.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:34483 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbaL2QE3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Dec 2014 11:04:29 -0500
In-Reply-To: <649EF91064D35D40B9C93A225BF41674612CCDB7@NWD2MBX7.ad.analog.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Wu, Aaron" <Aaron.Wu@analog.com>, "adi-buildroot-devel@lists.sourceforge.net" <adi-buildroot-devel@lists.sourceforge.net>, "wg@grandegger.com" <wg@grandegger.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Aaron,

On 12/29/2014 03:32 AM, Wu, Aaron wrote:
>> From: Oliver Hartkopp [mailto:socketcan@hartkopp.net]

>> So the correct way is to check which defines are *really* referenced and add
>> these directly to bfin_can.c (the only user) when removing bfin_can.h
> 
> Thanks for reply, will merge your idea and be back.

Great. As there's so many unused stuff in bfin_can.h I assume this to be a
real good improvement.

> Also your comments about another of my recent patch " Rewrite the blackfin CAN driver into arch independent style" is welcome.

This looks good to ME but usually Marc maintains the driver portions - and I
don't really know if it just *looks* good or if it *is* good ;-)

I just wanted to comment on the include file - as I knew the potential
feedback from Marc there. For the rest we need to wait for Marc coming back
from vacation.

Best regards,
Oliver
