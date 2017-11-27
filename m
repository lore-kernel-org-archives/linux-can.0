From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v2 2/2] can: flexcan: adding platform specific details for
 LS1021A
Date: Mon, 27 Nov 2017 17:34:56 +0100
Message-ID: <f7eb0c80bc49faf35c54be8a7b7b0f54@agner.ch>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.kmu-office.ch ([178.209.48.109]:39361 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752864AbdK0QqK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 27 Nov 2017 11:46:10 -0500
In-Reply-To: <CALw8SCWNXJYuNWDtAxS9iFkKjMhcwQ60Pi7Mq3ne=k0Oynr47w@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mirza Krak <mirza.krak@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, Pankaj Bansal <pankaj.bansal@nxp.com>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Varun Sethi <V.Sethi@nxp.com>, Poonam Aggrwal <poonam.aggrwal@nxp.com>

On 2017-11-23 21:17, Mirza Krak wrote:
> 2017-11-23 21:12 GMT+01:00 Mirza Krak <mirza.krak@gmail.com>:
>> On Nov 22, 2017 13:00, "Marc Kleine-Budde" <mkl@pengutronix.de> wrote:
>>
> 
> < snip >
> 
>>
>> Cc'ed Stefan Agner - maybe he has access to this SoC.
>>

Without reading the full thread, I did some testing back when we added
vf610 support:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/275903.html

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
> 

Thanks Mirza for your testing!

--
Stefan
