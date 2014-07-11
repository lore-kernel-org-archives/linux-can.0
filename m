From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 3/4] can: netlink: Add CAN_CTRLMODE_PRESUME_ACK flag
Date: Fri, 11 Jul 2014 09:18:37 -0400
Message-ID: <53BFE42D.20700@hartkopp.net>
References: <1404934273-19233-1-git-send-email-nebaruzdin@gmail.com> <1404934273-19233-3-git-send-email-nebaruzdin@gmail.com> <53BE9DF7.6020608@hartkopp.net> <53BE9F35.9060509@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:13800 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbaGKNSq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Jul 2014 09:18:46 -0400
In-Reply-To: <53BE9F35.9060509@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, wg@grandegger.com
Cc: Nikita Edward Baruzdin <nebaruzdin@gmail.com>, linux-can@vger.kernel.org

I tried to find a short name for:

- do not wait for ack
- ignore missing ack
- broadcast that doesn't require an ack
- ...

I'm really open for an alternative ;-)

On 10.07.2014 10:12, Marc Kleine-Budde wrote:
> On 07/10/2014 04:06 PM, Oliver Hartkopp wrote:
>> what do you think about this extension.
>>
>>  From my side the patchset makes sense.
>>> +#define CAN_CTRLMODE_PRESUME_ACK    0x40    /* Ignore missing CAN
>>> ACKs */
>
> Is this a good name? Does anyone come up with an alternative/better one?
>
> Marc
>
