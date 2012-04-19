From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] candump: resolve signedness warnings
Date: Thu, 19 Apr 2012 17:46:42 +0200
Message-ID: <4F903362.3070703@hartkopp.net>
References: <1334821446-2925-1-git-send-email-yegorslists@googlemail.com> <4F8FD2C1.8010903@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:48976 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755575Ab2DSPqo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Apr 2012 11:46:44 -0400
In-Reply-To: <4F8FD2C1.8010903@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: yegorslists@googlemail.com, linux-can@vger.kernel.org

On 19.04.2012 10:54, Marc Kleine-Budde wrote:

> On 04/19/2012 09:44 AM, yegorslists@googlemail.com wrote:
>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>
>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> 
> nbytes has been tested before if it's < 0, so it's safe to cast it to an
> unsigned value.
> 
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> Oliver do you want to take the patch?


Yes. I applied it to the git repo.

I did it with

git am --signoff < candump.patch

using the original mail from Yegor.

Unfortunately that missed your Acked-by: ...

What would be the right way to apply it with your Acked-by too?

I assume applying your answered mail won't have made it, right?

Regards,
Oliver
