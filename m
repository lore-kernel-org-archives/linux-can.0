From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Subject: Re: [PATCH v2 1/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
Date: Wed, 14 Mar 2018 10:09:52 +0100
Message-ID: <6c1b7482-2cde-40e3-eff4-e4b94794a63e@theobroma-systems.com>
References: <20180313173520.21257-1-jakob.unterwurzacher@theobroma-systems.com>
 <20180313173520.21257-2-jakob.unterwurzacher@theobroma-systems.com>
 <b4f644dc-265e-01e0-acaa-88cc8f3f69f5@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b4f644dc-265e-01e0-acaa-88cc8f3f69f5@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On 14.03.18 08:51, Marc Kleine-Budde wrote:
>> +		memcpy(cf->data, m->msg.can_msg.data, cf->can_dlc);
>> +
>> +	/* don't count error frames as real packets */
>> +	if (!(canid & CAN_ERR_FLAG)) {
>> +		stats->rx_packets++;
>> +		stats->rx_bytes += cf->can_dlc;
>> +	}
> Please count them, too.

We do count them, as errors!

This is what happens when you transmit a single CAN frame with nothing 
connected: "TX errors" shoots up but "RX packets" stays zero.

> root@rk3399-q7:~# ip -details -statistics link show can0
[...]
>     RX: bytes  packets  errors  dropped overrun mcast
>     0          0        0       0       0       0
>     TX: bytes  packets  errors  dropped carrier collsns
>     0          0        20425   0       0       0
