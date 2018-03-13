From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Subject: Re: [PATCH v2 1/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
Date: Tue, 13 Mar 2018 18:53:43 +0100
Message-ID: <872c1fca-df7c-84c1-e14b-0f7d60d0bafe@theobroma-systems.com>
References: <20180313173520.21257-1-jakob.unterwurzacher@theobroma-systems.com>
 <20180313173520.21257-2-jakob.unterwurzacher@theobroma-systems.com>
 <e6864131-adab-382b-617b-35e9329f00d0@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e6864131-adab-382b-617b-35e9329f00d0@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On 13.03.18 18:44, Marc Kleine-Budde wrote:
> On 03/13/2018 06:35 PM, Jakob Unterwurzacher wrote:
> 
> [...]
> 
> Please mark all multibyte values going over the USB as either le or be.

This is documented in can_ucan_protocol.rst,

     All multi-byte integers are encoded as Little Endian.

but it's probably worth mentioning here as well.

> 
> Please use standard 'net' comment style:
> 
>  /* this is a multiline
>   * comment
>   */
> 
>> +	struct ucan_ctl_cmd_start cmd_start;
>> +	/***************************************************
>> +	 * Setup Bittiming
>> +	 * bmRequest == UCAN_COMMAND_SET_BITTIMING
>> +	 ***************************************************/

Understood.

Thanks,
Jakob
