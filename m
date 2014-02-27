From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v5 4/6] can: introduce the data bitrate configuration
 for CAN FD
Date: Thu, 27 Feb 2014 19:05:30 +0100
Message-ID: <530F7E6A.4050307@hartkopp.net>
References: <1393452662-3154-1-git-send-email-socketcan@hartkopp.net> <1393452662-3154-5-git-send-email-socketcan@hartkopp.net> <530EFAA0.4090000@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:18184 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbaB0SFd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 27 Feb 2014 13:05:33 -0500
In-Reply-To: <530EFAA0.4090000@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 27.02.2014 09:43, Marc Kleine-Budde wrote:

>> +		if (priv->do_set_data_bittiming) {
>> +			/* Finally, set the bit-timing registers */
>> +			err = priv->do_set_data_bittiming(dev);
>> +			if (err)
>> +				return err;
>> +		}
> 
> Do we really need the do_set_data_bittiming() callback? Allmost all
> drivers set the bitrate during open and not asynchronously (when the
> interface is down) via the set_bittiming() callback. If there is a
> driver which really needs this callback, we can introduce it.

No. I assume you did not check the current implementation %-)

The bitrate is always set via do_set[_data]_bittiming() when the interface is
down - and *not* during the open process.

In the open process only the availability of the bitrate(s) is checked before
the controller is set into operational mode.

It is pretty straight forward to introduce do_set_data_bittiming() as a
different register set is addressed for CAN FD.

Regards,
Oliver
