From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 1/5][RFC] can: slcan: Replace sizeof struct can_frame
 with CAN_MTU
Date: Fri, 17 Jun 2016 11:25:56 +0200
Message-ID: <5763C224.6090601@denx.de>
References: <1465500064-5402-1-git-send-email-marex@denx.de> <5c0b646c-f020-98d0-de88-0a604c62fddf@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:60159 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967AbcFQJ0G (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Jun 2016 05:26:06 -0400
In-Reply-To: <5c0b646c-f020-98d0-de88-0a604c62fddf@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

On 06/17/2016 11:24 AM, Marc Kleine-Budde wrote:
> On 06/09/2016 09:21 PM, Marek Vasut wrote:
>> Use CAN_MTU macro instead of sizeof(struct can_frame) just like the
>> other drivers do.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> Cc: Oliver Hartkopp <socketcan@hartkopp.net>
>> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> Added this one to can-next.

Thnaks, at least this one was a bit helpful.

> Thnaks,
> Marc
> 


-- 
Best regards,
Marek Vasut
