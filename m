From: Anssi Hannula <anssi.hannula@bitwise.fi>
Subject: Re: [PATCH 4/5] can: xilinx_can: only report warning and passive
 states on state changes
Date: Mon, 29 Jan 2018 11:45:25 +0200
Message-ID: <b2ae0a20-984c-956b-072b-64921719e41d@bitwise.fi>
References: <20180126142723.3212-1-anssi.hannula@bitwise.fi>
 <20180126142723.3212-5-anssi.hannula@bitwise.fi>
 <87c7662b-0a49-cf90-10cc-b7aaee44a543@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.bitwise.fi ([109.204.228.163]:49834 "EHLO mail.bitwise.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751175AbeA2Jp3 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 29 Jan 2018 04:45:29 -0500
In-Reply-To: <87c7662b-0a49-cf90-10cc-b7aaee44a543@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: Michal Simek <michal.simek@xilinx.com>

On 29.1.2018 10:35, Marc Kleine-Budde wrote:
> On 01/26/2018 03:27 PM, Anssi Hannula wrote:
>> The xilinx_can driver currently increments error-warning and
>> error-passive statistics on every error interrupt regardless of whether
>> the interface was already in the same state. Similarly, the error frame
>> sent on error interrupts is always sent with
>> CAN_ERR_CRTL_(RX|TX)_(PASSIVE|WARNING) bit set.
>>
>> To make the error-warning and error-passive statistics more useful, add
>> a check to only set the error state when the state has actually been
>> changed.
>>
>> Tested with the integrated CAN on Zynq-7000 SoC.
>>
>> Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
>> ---
>>  drivers/net/can/xilinx_can.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
>> index 763408a..862c12bb 100644
>> --- a/drivers/net/can/xilinx_can.c
>> +++ b/drivers/net/can/xilinx_can.c
>> @@ -680,7 +680,8 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
>>  	} else {
>>  		enum can_state new_state = xcan_current_error_state(ndev);
>>  
>> -		xcan_set_error_state(ndev, new_state, skb ? cf : NULL);
>> +		if (new_state != priv->can.state)
>> +			xcan_set_error_state(ndev, new_state, skb ? cf : NULL);
>>  	}
> Are you changing a piece of code, that you've introduced in patch 3? If
> so, I'm going to squash these two patches together.

Yes, patch 3 keeps the state change reporting behavior (always vs. on
state change) like it was before, only introducing reporting recovery
from error states.

But I'm OK with squashing, as long as the commit message is updated to
say it changes that behavior, too.


-- 
Anssi Hannula / Bitwise Oy
+358503803997

