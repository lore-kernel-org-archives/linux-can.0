From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: add new socket option CAN_RAW_FILTER_UNIQUE to eliminate
 duplicate matches
Date: Tue, 17 Mar 2015 14:23:42 +0100
Message-ID: <55082ADE.4050602@hartkopp.net>
References: <1426597107-7590-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:37873 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbbCQNXp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Mar 2015 09:23:45 -0400
In-Reply-To: <1426597107-7590-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Marc,

On 17.03.2015 13:58, Oliver Hartkopp wrote:
> The CAN_RAW socket can set multiple CAN identifier specific filters that lead
> to multiple filters in the af_can.c filter processing. These filters are
> indenpendent from each other which leads to logical OR'ed filters when applied.
>
> Especially when the filter is intended to notch single CAN IDs or CAN ID ranges
> a problem emerges when using more than just one filter: The notched CAN IDs
> will be delivered once while the other CAN IDs will be delivered twice.
>
> This patch implements a new option to make sure that every CAN frame which is
> filtered for a specific socket is only delivered once to the user space.
> This is independent from the number of matching CAN filters of this socket.

Just to make sure, this patch really helps:

With the example above all CAN frames are delivered just once. The OR'ed 
filters still match. So you won't have the solution that you can have 
different notched areas of CAN IDs ...

I hope I expressed myself clearly.

Regards,
Oliver

