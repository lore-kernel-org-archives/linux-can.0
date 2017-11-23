From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v2 2/2] can: flexcan: adding platform specific details for
 LS1021A
Date: Thu, 23 Nov 2017 22:05:39 +0100
Message-ID: <e318ca19-bb08-f537-ed7a-4f8008b9a341@grandegger.com>
References: <1510307990-15418-1-git-send-email-pankaj.bansal@nxp.com>
 <1510660589-16125-1-git-send-email-pankaj.bansal@nxp.com>
 <1510660589-16125-2-git-send-email-pankaj.bansal@nxp.com>
 <828fba89-66dc-a2c5-e095-8554b9dce5d5@pengutronix.de>
 <AM0PR0402MB3940A4B29C67BAD85F461331F12E0@AM0PR0402MB3940.eurprd04.prod.outlook.com>
 <343d8c69-a01a-5ff7-75a2-99523391f97c@grandegger.com>
 <ff7b32a8bc694c92b10967bfd2de24fa@SGPMBX1017.APAC.bosch.com>
 <AM0PR0402MB394058F204ECA509D1ADB6AEF1220@AM0PR0402MB3940.eurprd04.prod.outlook.com>
 <cf35f42c513946918031b4c1cf6d8778@SGPMBX1017.APAC.bosch.com>
 <be8f51ff-8775-fe03-d299-2dc1f963ebcc@pengutronix.de>
 <3e201945af364c5a8a92dd6a931f4448@SGPMBX1017.APAC.bosch.com>
 <ced1aea2-144d-9bd5-8ab7-b19492512815@pengutronix.de>
 <CALw8SCUGuCmq+S_9-o-ZDYJuASveuj71WH97jYsEvNZX2N5ZXA@mail.gmail.com>
 <CALw8SCWNXJYuNWDtAxS9iFkKjMhcwQ60Pi7Mq3ne=k0Oynr47w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy01.manitu.net ([217.11.48.65]:47854 "EHLO
        mailproxy01.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbdKWVFm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 Nov 2017 16:05:42 -0500
In-Reply-To: <CALw8SCWNXJYuNWDtAxS9iFkKjMhcwQ60Pi7Mq3ne=k0Oynr47w@mail.gmail.com>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mirza Krak <mirza.krak@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, Pankaj Bansal <pankaj.bansal@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Varun Sethi <V.Sethi@nxp.com>, Poonam Aggrwal <poonam.aggrwal@nxp.com>, Stefan Agner <stefan@agner.ch>

Hello Mirza,

Am 23.11.2017 um 21:17 schrieb Mirza Krak:
> 2017-11-23 21:12 GMT+01:00 Mirza Krak <mirza.krak@gmail.com>:
>> On Nov 22, 2017 13:00, "Marc Kleine-Budde" <mkl@pengutronix.de> wrote:
>>
> 
> < snip >
> 
>>
>> Cc'ed Stefan Agner - maybe he has access to this SoC.
>>
>>> @Marc, @Wolfgang,
>>> What do you think? Or shall we fix first and then wait?
>>
>> Let's wait if Stefan can test, otherwise just fix.
>>
>>
>> I have access to an vf610 and can test CAN stuff.
>>
>> What is it more specifically we want to test? I read the thread but not
>> completely clear to me.

We want to know how the reporting of CAN error state changes 
"error-active" -> "warning" -> "error-passive" -> "bus-off" and back is 
working on that hardware.

You can test such state changes as show below. First setup the interface 
and start a session calling "candump" to report the state changes:

   # ip link set can0 up type can bitrate 500000 restart-ms 100
   # candump -td -e any,0:0,#FFFFFFFF

Then

1. disconnect the cable and send messages with "cangen"

    # cangen -i can0

"candump" should then report the error state changes "error-active" -> 
"warning" -> "error-passive". If you don't see "error-passive", the 
hardware needs the FLEXCAN_QUIRK_BROKEN_PERR_STATE as well. Then 
reconnect the cable and send messages till the "error active" state is 
reached (again with "cangen").

2. The second test is quite similar. Instead of disconnecting the cable, 
short-circuit the CAN low and high lines. The device should then go to 
"bus-off".

Thanks for testing,

Wolfgang.


