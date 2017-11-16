From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v2 2/2] can: flexcan: adding platform specific details for
 LS1021A
Date: Thu, 16 Nov 2017 08:05:31 +0100
Message-ID: <343d8c69-a01a-5ff7-75a2-99523391f97c@grandegger.com>
References: <1510307990-15418-1-git-send-email-pankaj.bansal@nxp.com>
 <1510660589-16125-1-git-send-email-pankaj.bansal@nxp.com>
 <1510660589-16125-2-git-send-email-pankaj.bansal@nxp.com>
 <828fba89-66dc-a2c5-e095-8554b9dce5d5@pengutronix.de>
 <AM0PR0402MB3940A4B29C67BAD85F461331F12E0@AM0PR0402MB3940.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy03.manitu.net ([217.11.48.67]:44736 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756730AbdKPHFd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 16 Nov 2017 02:05:33 -0500
In-Reply-To: <AM0PR0402MB3940A4B29C67BAD85F461331F12E0@AM0PR0402MB3940.eurprd04.prod.outlook.com>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pankaj Bansal <pankaj.bansal@nxp.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Yi.Zhu5@cn.bosch.com" <Yi.Zhu5@cn.bosch.com>
Cc: Varun Sethi <V.Sethi@nxp.com>, Poonam Aggrwal <poonam.aggrwal@nxp.com>, Bhupesh Sharma <bhupesh.sharma@freescale.com>



Am 16.11.2017 um 06:34 schrieb Pankaj Bansal:
> 
> 
>> -----Original Message-----
>> From: Marc Kleine-Budde [mailto:mkl@pengutronix.de]
>> Sent: Tuesday, November 14, 2017 6:29 PM
>> To: Pankaj Bansal <pankaj.bansal@nxp.com>; wg@grandegger.com; linux-
>> can@vger.kernel.org
>> Cc: Varun Sethi <V.Sethi@nxp.com>; Poonam Aggrwal
>> <poonam.aggrwal@nxp.com>; Bhupesh Sharma
>> <bhupesh.sharma@freescale.com>
>> Subject: Re: [PATCH v2 2/2] can: flexcan: adding platform specific details for
>> LS1021A
>>
>> On 11/14/2017 12:56 PM, Pankaj Bansal wrote:
>>> This patch adds platform specific details for NXP SOC LS1021A to the
>>> flexcan driver code.
>>>
>>> Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
>>> Reviewed-by: Zhengxiong Jin <Jason.Jin@freescale.com>
>>> Reviewed-by: Poonam Aggrwal <poonam.aggrwal@nxp.com>
>>> ---
>>> Changes in v2:
>>>    - No change.
>>>
>>>   drivers/net/can/flexcan.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
>>> index 100b451..fa2d4c9 100644
>>> --- a/drivers/net/can/flexcan.c
>>> +++ b/drivers/net/can/flexcan.c
>>> @@ -304,6 +304,11 @@ static const struct flexcan_devtype_data
>> fsl_vf610_devtype_data = {
>>>   		FLEXCAN_QUIRK_DISABLE_MECR |
>> FLEXCAN_QUIRK_USE_OFF_TIMESTAMP,  };
>>>
>>> +/* LS1021A-Rev2 has functional RX-FIFO mode  */
>>
>> How big is the RX-FIFO? If the normal mailboxes can receive RTR messages,
>> we definitely want to use FLEXCAN_QUIRK_USE_OFF_TIMESTAMP. As you
>> can buffer > 60 CAN frames compared to only 6 in FIFO mode.
>>
> 
> The FIFO in LS1021A is 6 frames.
> I saw this quirk. Basically we are creating a FIFO in software which is sorted based
> on the receive time stamp value. IMO LS1021A should be able to support that.
> BUT I have not tested this quirk yet. Right now I won't be able to test this on LS1021A.
> If you can accept this platform with FIFO mode now, then later on I can add this quirk after testing.
> 
>> Please add your IP core to the "FLEXCAN hardware feature flags" table [1] in
>> the driver. Also please test the transition interrupts for changes in the CAN
>> error state, see the commits of ZHU Yi
>> (ST-FIR/ENG1-Zhu) <Yi.Zhu5@cn.bosch.com> on the driver. [2]
>>
> 
> I did not understand this quirk (FLEXCAN_QUIRK_BROKEN_PERR_STATE).
> What does this quirk do ? how do I check if my IP supports it or not ?
> How do I test this ?
> 
> Can you please help me to understand ?

It's about reporting CAN error state changes "error-active" -> "warning" 
-> "error-passive" -> "bus-off" and back. The quirk might be required to 
trigger the state-change to "error-passive".

You can test such state changes by doing:

1. Send messages without CAN cable connected

2. Short-circuit the CAN low and high signals

Then connect the cable and remove the short-circuit and send messages 
using "cansend" or "cangen". Please also use "ip set link can0 ... 
restart-ms 100" to recover from bus-off automatically.

While testing watch the error messages with the command below and report 
the results to the list.

# candump -td -e any,0:0,#FFFFFFFF

Thanks,

Wolfgang.
