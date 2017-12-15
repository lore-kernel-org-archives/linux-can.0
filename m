From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] can: gs_usb: fix return value of the "set_bittiming"
 callback
Date: Fri, 15 Dec 2017 17:12:44 +0100
Message-ID: <3b80ab04-c88a-2468-e5c1-83a6d4619777@grandegger.com>
References: <7e1d101e-9c10-4067-ab6e-91c4338670d3@grandegger.com>
 <0f752fcb-64bf-d471-b376-48d4c2cf53c7@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy01.manitu.net ([217.11.48.65]:32986 "EHLO
        mailproxy01.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932359AbdLOQMq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 15 Dec 2017 11:12:46 -0500
In-Reply-To: <0f752fcb-64bf-d471-b376-48d4c2cf53c7@pengutronix.de>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Maximilian Schneider <max@schneidersoft.net>

Am 15.12.2017 um 14:27 schrieb Marc Kleine-Budde:
> On 12/13/2017 07:52 PM, Wolfgang Grandegger wrote:
>> The "set_bittiming" callback treats a positive return value as error!
>> For that reason "can_changelink()" will quit silently after setting
>> the bittiming values without processing ctrlmode, restart-ms, etc.
>>
>> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
>> ---
>>   drivers/net/can/usb/gs_usb.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
>> index 68ac3e8..52907d4 100644
>> --- a/drivers/net/can/usb/gs_usb.c
>> +++ b/drivers/net/can/usb/gs_usb.c
>> @@ -449,7 +449,7 @@ static int gs_usb_set_bittiming(struct net_device *netdev)
>>   		dev_err(netdev->dev.parent, "Couldn't set bittimings (err=%d)",
>>   			rc);
>>   
>> -	return rc;
>> +	return rc < 0 ? rc : 0;
>>   }
>>   
>>   static void gs_usb_xmit_callback(struct urb *urb)
>>
> 
> I've changed the patch to:
> index 8bf80ad9dc44..3ed2a47e3af0 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -267,7 +267,7 @@ static int gs_cmd_reset(struct gs_usb *gsusb, struct gs_can *gsdev)
> 
>          kfree(dm);
> 
> -       return rc;
> +       return (rc > 0) ? 0 : rc;
>   }
> 
> As some other code in the driver already uses this.

Perfect! Thanks.

Wolfgang.
