From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 2/4] can: netlink send bittiming data only when bittiming_const
 is available
Date: Sat, 15 Feb 2014 08:10:44 +0100
Message-ID: <52FF12F4.5010905@hartkopp.net>
References: <1392411447-9105-1-git-send-email-socketcan@hartkopp.net> <1392411447-9105-2-git-send-email-socketcan@hartkopp.net> <52FE8A0B.6090405@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:44385 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbaBOHKp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 15 Feb 2014 02:10:45 -0500
In-Reply-To: <52FE8A0B.6090405@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org



On 14.02.2014 22:26, Marc Kleine-Budde wrote:
> On 02/14/2014 09:57 PM, Oliver Hartkopp wrote:
>> The bittiming information is only valid when the CAN driver has a valid
>> structure of bittiming_const. Therefore provide the information of the
>> bittiming only when bittiming_const exists.
> 
> What about intelligent CAN controllers which only support fixed
> bitrates? We once hat such a device and it was a design goal to support
> such devices.
> 
>> This is also a preparation for the CAN FD specific bittiming_const structure
>> which is not existing in non-FD drivers. Therefore all the CAN FD bittiming
>> stuff has to be disabled when the CAN FD specific bittiming_const structure is
>> missing.
> 
> Can we use bitrate == 0 as an indicator?
> 

Good idea.
This is done in another place too.

Updated patchset sent.

How do I make it a "v2" ??

Regards,
Oliver
