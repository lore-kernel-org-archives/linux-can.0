From: Stefano Babic <sbabic@denx.de>
Subject: Re: [PATCH v3 2/2] CAN: CAN driver to support multiple CAN bus on
 SPI interface
Date: Thu, 03 Apr 2014 14:14:23 +0200
Message-ID: <533D509F.4000908@denx.de>
References: <1396423121-28949-1-git-send-email-sbabic@denx.de> <1396423121-28949-3-git-send-email-sbabic@denx.de> <533C4708.8030600@hartkopp.net> <533D2286.1020609@denx.de> <533D4DE7.5090408@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:55364 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbaDCMO0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Apr 2014 08:14:26 -0400
In-Reply-To: <533D4DE7.5090408@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Stefano Babic <sbabic@denx.de>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

Hi Oliver,

On 03/04/2014 14:02, Oliver Hartkopp wrote:
> Hi Stefano,
> 
> two more remarks:
> 
>>> On 02.04.2014 09:18, Stefano Babic wrote:
>>>
>>>> +
>>>> +/* CFG message */
>>>> +struct msg_cfg_data {
>>>> +	u8	channel;
>>>> +	u8	enabled;
>>>> +	struct can_bittiming bt;
>>>> +} __packed;
> 
> When you transfer this structure via SPI.
> What are your assumptions about the host specifc byte order?
> 
> Does the SPI CAN adapter autodetect the host byte order?
> 

The general assumption (I am sure/hope this is described in the doc) is
that data are transferred in big-endian mode on the SPI-Bus. The driver
calls then cpu_to_be32() in spi_can_cfg() before putting the data on the
bus.

>> Only to check what is happening:
>>
>> 5: hcan2: <NOARP> mtu 16 qdisc noop state DOWN qlen 10
>>     link/can
>>     can state STOPPED restart-ms 0
>>     bitrate 0 sample-point 0.000
>>     tq 0 prop-seg 0 phase-seg1 0 phase-seg2 0 sjw 0
>>     clock 100000000
> 
> Ah - you also have a CAN clock :-)
> 
> 
>> Agree, it is the best way. I will add a SPI_MSG_GET_CFG to retrieve the
>> timing from the controller in probe(). In my case, the controller cannot
>> have different timing for each channel, but I agree the query must be
>> done for each channel, in case a microcontroller supports it.
> 
> Yep.
> 
> Just to make sure what is needed:
> 
>>>> +		priv->can.clock.freq = SLAVE_CLK_FREQ;
>>>> +		priv->can.bittiming_const = NULL;
>>>> +		priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
>>>> +			CAN_CTRLMODE_LISTENONLY	| CAN_CTRLMODE_3_SAMPLES;
> 
> These three controller specific settings - which are usually constant values
> in other CAN drivers - need to be provided by SPI_MSG_GET_CFG.

ok, got it (I hope). Time to work for V4...

Best regards,
Stefano


-- 
=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
