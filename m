From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v5 4/6] can: introduce the data bitrate configuration
 for CAN FD
Date: Fri, 28 Feb 2014 13:58:35 +0100
Message-ID: <531087FB.6010008@hartkopp.net>
References: <1393452662-3154-1-git-send-email-socketcan@hartkopp.net> <1393452662-3154-5-git-send-email-socketcan@hartkopp.net> <530EFAA0.4090000@pengutronix.de> <530F7E6A.4050307@hartkopp.net> <53106B6B.6040307@pengutronix.de> <53107F29.1080109@hartkopp.net> <53108165.5050606@pengutronix.de> <53108210.6070700@hartkopp.net> <5310867F.8060503@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:21113 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbaB1M6l (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 28 Feb 2014 07:58:41 -0500
In-Reply-To: <5310867F.8060503@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org



On 28.02.2014 13:52, Marc Kleine-Budde wrote:
> On 02/28/2014 01:33 PM, Oliver Hartkopp wrote:


>>> A new do_set_data_bittiming() callback is not needed, as it's better do
>>> set the data and "normal" bit timing registers during open().
>>
>> With this argumentation do_set_bittiming() has to be removed too.
>>
>> Is this your intention?
> 
> Yes. But it's in many drivers so let's keep it, for now.
> 

Good.

Btw. this could be a general simplification topic for the future.

I do not have any objections to remove the callbacks in can_priv and call the
device specific functions for the (data) bittiming setting in the open
function then.

Regards,
Oliver
