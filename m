From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v4 7/7] can: add bittiming check at interface open for
 CAN FD
Date: Wed, 26 Feb 2014 21:35:57 +0100
Message-ID: <530E502D.2060601@hartkopp.net>
References: <1393009025-4903-1-git-send-email-socketcan@hartkopp.net> <1393009025-4903-8-git-send-email-socketcan@hartkopp.net> <20140226195208.GA10876@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:40128 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbaBZUgA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Feb 2014 15:36:00 -0500
In-Reply-To: <20140226195208.GA10876@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: linux-can@vger.kernel.org

On 26.02.2014 20:52, Kurt Van Dijck wrote:

>> +	/* For CAN FD the data bitrate has to be >= the arbitration bitrate */
>> +	if ((priv->ctrlmode_supported & CAN_CTRLMODE_FD) &&
>> +	    (!priv->data_bittiming.tq || !priv->data_bittiming.bitrate ||
>> +	     (priv->data_bittiming.bitrate < priv->bittiming.bitrate))) {
> 
> This prevents to configure a data bitrate slower than the arbitration bitrate.
> Such configuration is useless, but is it really "incorrect" or wrong?

Yes it is.

There was a definition that the data bitrate has to be greater or equal the
arbitration bitrate.

In the Bosch whitepaper about CAN FD Florian Hartwich always states about the
higher bitrate - but at least the data bitrate must not be lower than the
arbitration bitrate.

Regards,
Oliver

