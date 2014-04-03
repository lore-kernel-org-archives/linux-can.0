From: Stefano Babic <sbabic@denx.de>
Subject: Re: [PATCH v3 2/2] CAN: CAN driver to support multiple CAN bus on
 SPI interface
Date: Thu, 03 Apr 2014 10:57:42 +0200
Message-ID: <533D2286.1020609@denx.de>
References: <1396423121-28949-1-git-send-email-sbabic@denx.de> <1396423121-28949-3-git-send-email-sbabic@denx.de> <533C4708.8030600@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:33809 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162715AbaDCI5t (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Apr 2014 04:57:49 -0400
In-Reply-To: <533C4708.8030600@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Stefano Babic <sbabic@denx.de>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

Hi Oliver,

On 02/04/2014 19:21, Oliver Hartkopp wrote:
> Hello Stefano,
> 
> On 02.04.2014 09:18, Stefano Babic wrote:
> 
>> +
>> +/* CFG message */
>> +struct msg_cfg_data {
>> +	u8	channel;
>> +	u8	enabled;
>> +	struct can_bittiming bt;
>> +} __packed;
> 
> 
>> +static int spi_can_probe(struct spi_device *spi)
>> +{
> 
> (..)
> 
>> +
>> +		/* Set CAN specific parameters */
>> +		priv->can.clock.freq = SLAVE_CLK_FREQ;
>> +		priv->can.bittiming_const = NULL;
>> +		priv->can.do_set_mode = spi_can_set_mode;
>> +		priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
>> +			CAN_CTRLMODE_LISTENONLY	| CAN_CTRLMODE_3_SAMPLES;
> 
> This looks wrong to me.
> 
> In the one case (ctrlmode_supported) you aim to know about the SPI CAN
> controllers e.g. if they support LISTENONLY.
> 
> In the other case (bittiming_const) you don't know anything about the
> controller??

I agreee, this is wrong and must be fixed.

> 
> How do you set the bitrate without defining bittiming_const??
> And how does
> 
> 	ip -det link show can0
> 
> look like for your device then?

Only to check what is happening:

5: hcan2: <NOARP> mtu 16 qdisc noop state DOWN qlen 10
    link/can
    can state STOPPED restart-ms 0
    bitrate 0 sample-point 0.000
    tq 0 prop-seg 0 phase-seg1 0 phase-seg2 0 sjw 0
    clock 100000000

Everything is zeroed...


> 
> Setting the bitrate with the ip tools requires bittiming_const to be set:
> 
> http://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git/tree/drivers/net/can/dev.c#n252
> 

In fact I had supposed that setting the bitrate generates an OOPS in
can_calc_bittiming(). It does not, I have not checked why...in any case
the behavior must be fixed.

> IMO both ctrlmode_supported and bittiming_const need to be retrieved from
> each remote SPI attached CAN controller at startup initialization time.
> So that the configuration can be done with the standard tools.

Agree, it is the best way. I will add a SPI_MSG_GET_CFG to retrieve the
timing from the controller in probe(). In my case, the controller cannot
have different timing for each channel, but I agree the query must be
done for each channel, in case a microcontroller supports it.

Thanks for reviewing,

Stefano Babic


-- 
=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
