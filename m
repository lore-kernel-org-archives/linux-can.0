From: =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>
Subject: Re: Need help in interpreting ip status output
Date: Mon, 23 Mar 2020 08:19:09 +0100
Message-ID: <42667b7b-59be-051b-eeca-da5b5b843221@gmx.de>
References: <a6c8ef8c-5c72-7a2b-98df-0a30057c5fdc@gmx.de>
 <f029f731-25bc-a3f0-c5a9-380012a16839@gmx.de>
 <86b34b1b-7bda-e481-2087-1be8e64d2fed@hartkopp.net>
 <75a1a6b5-141e-e741-f6c2-bab5e9e4e541@gmx.de>
 <fe141541-7e79-3bee-8c75-29e6f9f3bc4e@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:41471 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbgCWHTP (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 23 Mar 2020 03:19:15 -0400
In-Reply-To: <fe141541-7e79-3bee-8c75-29e6f9f3bc4e@hartkopp.net>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Alex Blasche <alexander.blasche@qt.io>, Marc Kleine-Budde <mkl@pengutronix.de>

Thanks Oliver.

Reading the log it indeed seems a good idea to try a newer Kernel.

Marc, do you have any further comments?

Thanks and best regards,
Andr=C3=A9

On 21.03.20 18:04, Oliver Hartkopp wrote:
> + Marc
>
> Hi Andr=C3=A9,
>
> On 21/03/2020 16.19, Andr=C3=A9 Hartmann wrote:
>
>>> On 12/03/2020 18.43, Andr=C3=A9 Hartmann wrote:
>>>
>>>>> can someone help me interpreting the following ip output:
>
>>> The reason for the overrun error is a notification from the CAN
>>> controller itself. It tells us that the received CAN frame has not bee=
n
>>> read from the controller until the next CAN frame arrived.
>>
>> Ok, that's what I thought too, thanks for the confirmation.
>>
>>> The dropped counter usually indicates that the CAN driver did not get =
a
>>> skbuff data structure (e.g. out of memory condition).
>>>
>>> This is NOT good. What CAN hardware/setup are you using?
>>
>> Actually it's not my system. The report is from a customer doing a full
>> load test on an iMX8: https://bugreports.qt.io/browse/QTBUG-82610
>
> Thanks for the link!
>
>> I guess the customer should try a more recent Kernel than 4.14 first?
>
> The FlexCAN driver (which is used in the IMX8 AFAIK) had a remarkable
> number of changes last year:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/d=
rivers/net/can/flexcan.c
>
>
> So I would definitely suggest an update.
> I added Marc to this thread as he was very active on the FlexCAN
> improvements.
>
> Best,
> Oliver
