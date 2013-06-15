From: uescher <linux-can_ger.kernel.org@myvdr.de>
Subject: Re: [PATCH 1/1 V2] slcanpty: Improve the data handling from pty2can()
 to avoid, incomplete messages in further processing
Date: Sat, 15 Jun 2013 22:39:28 +0200
Message-ID: <51BCD100.6080700@myvdr.de>
References: <51AA491A.7060307@myvdr.de> <51B31311.6080606@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay02.ispgateway.de ([80.67.31.29]:53354 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754532Ab3FOUjc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 15 Jun 2013 16:39:32 -0400
In-Reply-To: <51B31311.6080606@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Am 08.06.2013 13:18, schrieb Oliver Hartkopp:
> Hi Ulrich,
>
> thanks for the fix!
>
> Indeed I needed some time to get the point %-)
>
> I removed all the debug stuff and added some comments to reduce the time to
> get the point the next time i look into that code.
>
> I changed the for() statement with the break to a simpler implementation.
>
> Please check out the updated version which should do the same as your patch.
It works fine. Thanks you.
