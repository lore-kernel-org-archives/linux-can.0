From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can-bcm: initialize ifindex for timeouts without previous
 frame reception
Date: Mon, 26 Nov 2012 22:39:52 +0100
Message-ID: <50B3E1A8.7030900@hartkopp.net>
References: <50B3DE07.7080506@hartkopp.net> <50B3E11B.8040606@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:30297 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757252Ab2KZVjz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 16:39:55 -0500
In-Reply-To: <50B3E11B.8040606@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Andre Naujoks <nautsch2@googlemail.com>

On 26.11.2012 22:37, Marc Kleine-Budde wrote:

> On 11/26/2012 10:24 PM, Oliver Hartkopp wrote:
>> Set in the rx_ifindex to pass the correct interface index in the case of a
>> message timeout detection. Usually the rx_ifindex value is set at receive
>> time. But when no CAN frame has been received the RX_TIMEOUT notification
>> did not contain a valid value.
>>
>> Reported-by: Andre Naujoks <nautsch2@googlemail.com>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> Tnx, I'll send a pull request to David, let's hope the best :)


It probably helps to tag this patch as a candidate for stable also.

BR,
Oliver

