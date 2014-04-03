From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3 2/2] CAN: CAN driver to support multiple CAN bus on
 SPI interface
Date: Thu, 03 Apr 2014 14:02:47 +0200
Message-ID: <533D4DE7.5090408@hartkopp.net>
References: <1396423121-28949-1-git-send-email-sbabic@denx.de> <1396423121-28949-3-git-send-email-sbabic@denx.de> <533C4708.8030600@hartkopp.net> <533D2286.1020609@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:55291 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbaDCMCz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Apr 2014 08:02:55 -0400
In-Reply-To: <533D2286.1020609@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefano Babic <sbabic@denx.de>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

Hi Stefano,

two more remarks:

>> On 02.04.2014 09:18, Stefano Babic wrote:
>>
>>> +
>>> +/* CFG message */
>>> +struct msg_cfg_data {
>>> +	u8	channel;
>>> +	u8	enabled;
>>> +	struct can_bittiming bt;
>>> +} __packed;

When you transfer this structure via SPI.
What are your assumptions about the host specifc byte order?

Does the SPI CAN adapter autodetect the host byte order?

> Only to check what is happening:
> 
> 5: hcan2: <NOARP> mtu 16 qdisc noop state DOWN qlen 10
>     link/can
>     can state STOPPED restart-ms 0
>     bitrate 0 sample-point 0.000
>     tq 0 prop-seg 0 phase-seg1 0 phase-seg2 0 sjw 0
>     clock 100000000

Ah - you also have a CAN clock :-)


> Agree, it is the best way. I will add a SPI_MSG_GET_CFG to retrieve the
> timing from the controller in probe(). In my case, the controller cannot
> have different timing for each channel, but I agree the query must be
> done for each channel, in case a microcontroller supports it.

Yep.

Just to make sure what is needed:

>>> +		priv->can.clock.freq = SLAVE_CLK_FREQ;
>>> +		priv->can.bittiming_const = NULL;
>>> +		priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
>>> +			CAN_CTRLMODE_LISTENONLY	| CAN_CTRLMODE_3_SAMPLES;

These three controller specific settings - which are usually constant values
in other CAN drivers - need to be provided by SPI_MSG_GET_CFG.

Best regards,
Oliver

