From: Mirza Krak <mirza.krak@gmail.com>
Subject: Re: [PATCH v2 2/2] can: flexcan: adding platform specific details for LS1021A
Date: Sun, 26 Nov 2017 22:11:51 +0100
Message-ID: <CALw8SCWK55Byqackx3YQ_h8c5Jo5JFLtt3-WJryHwOEtP-Rtgw@mail.gmail.com>
References: <1510307990-15418-1-git-send-email-pankaj.bansal@nxp.com>
 <1510660589-16125-2-git-send-email-pankaj.bansal@nxp.com> <828fba89-66dc-a2c5-e095-8554b9dce5d5@pengutronix.de>
 <AM0PR0402MB3940A4B29C67BAD85F461331F12E0@AM0PR0402MB3940.eurprd04.prod.outlook.com>
 <343d8c69-a01a-5ff7-75a2-99523391f97c@grandegger.com> <ff7b32a8bc694c92b10967bfd2de24fa@SGPMBX1017.APAC.bosch.com>
 <AM0PR0402MB394058F204ECA509D1ADB6AEF1220@AM0PR0402MB3940.eurprd04.prod.outlook.com>
 <cf35f42c513946918031b4c1cf6d8778@SGPMBX1017.APAC.bosch.com>
 <be8f51ff-8775-fe03-d299-2dc1f963ebcc@pengutronix.de> <3e201945af364c5a8a92dd6a931f4448@SGPMBX1017.APAC.bosch.com>
 <ced1aea2-144d-9bd5-8ab7-b19492512815@pengutronix.de> <CALw8SCUGuCmq+S_9-o-ZDYJuASveuj71WH97jYsEvNZX2N5ZXA@mail.gmail.com>
 <CALw8SCWNXJYuNWDtAxS9iFkKjMhcwQ60Pi7Mq3ne=k0Oynr47w@mail.gmail.com>
 <e318ca19-bb08-f537-ed7a-4f8008b9a341@grandegger.com> <CALw8SCWFDt58x6zrbnoXuX=DkG0+OZtXnCO5CdK+MQb2JyubuA@mail.gmail.com>
 <d339bdc6-49c4-3184-6fa4-12521f491f20@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:38313 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbdKZVLx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 26 Nov 2017 16:11:53 -0500
Received: by mail-qk0-f182.google.com with SMTP id a142so30113861qkb.5
        for <linux-can@vger.kernel.org>; Sun, 26 Nov 2017 13:11:53 -0800 (PST)
In-Reply-To: <d339bdc6-49c4-3184-6fa4-12521f491f20@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, Pankaj Bansal <pankaj.bansal@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Varun Sethi <V.Sethi@nxp.com>, Poonam Aggrwal <poonam.aggrwal@nxp.com>, Stefan Agner <stefan@agner.ch>

2017-11-24 20:19 GMT+01:00 Wolfgang Grandegger <wg@grandegger.com>:
> Hello Mirza,
>

< snip >

>>>
>>> You can test such state changes as show below. First setup the interfac=
e
>>> and
>>> start a session calling "candump" to report the state changes:
>>>
>>>    # ip link set can0 up type can bitrate 500000 restart-ms 100
>>>    # candump -td -e any,0:0,#FFFFFFFF
>>>
>>> Then
>>>
>>> 1. disconnect the cable and send messages with "cangen"
>>>
>>>     # cangen -i can0
>>>
>>> "candump" should then report the error state changes "error-active" ->
>>> "warning" -> "error-passive". If you don't see "error-passive", the
>>> hardware
>>> needs the FLEXCAN_QUIRK_BROKEN_PERR_STATE as well. Then reconnect the
>>> cable
>>> and send messages till the "error active" state is reached (again with
>>> "cangen").
>>
>>
>> This was the result of this test:
>>
>> root@colibri-vf:~# ./candump -td -e can0,0:0,#FFFFFFFF
>>   (000.000000)  can0  0C8   [8]  E7 D5 75 20 1C F8 AA 6D
>>   (000.200201)  can0  7CD   [8]  58 5F B1 1E D7 AB 3C 15
>>   (000.200123)  can0  7FD   [8]  EC 43 EF 11 BB 76 50 4F
>>   (000.200119)  can0  20D   [8]  64 E0 A6 74 A2 A4 22 42
>>   (000.200115)  can0  226   [7]  CB 4D 12 46 F3 37 F1
>>   (000.200000)  can0  42F   [0]
>>   (000.200245)  can0  0F9   [8]  AD 61 16 77 0A 64 50 5C
>>   (000.199983)  can0  76E   [0]
>>   (000.200206)  can0  3CB   [6]  53 28 03 34 98 43
>>   (000.200152)  can0  230   [8]  70 EF 66 38 2D BA 5D 4D
>>   (000.200106)  can0  568   [8]  E8 30 AE 1C 75 77 4E 5E
>>   (000.200274)  can0  20000004   [8]  00 04 00 00 00 00 00 00   ERRORFRA=
ME
>> controller-problem{rx-error-warning}
>>
>> and the statistics
>>
>> root@colibri-vf:~# ip -d -s link show can0
>> 2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state
>> UNKNOWN mode DEFAULT group default qlen 10
>>      link/can  promiscuity 0
>>      can state ERROR-WARNING (berr-counter tx 0 rx 128) restart-ms 100
>>   bitrate 496240 sample-point 0.857
>>   tq 143 prop-seg 5 phase-seg1 6 phase-seg2 2 sjw 1
>>   flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 brp-inc 1
>>   clock 83368421
>>   re-started bus-errors arbit-lost error-warn error-pass bus-off
>>   0          0          0          1          0          0
>> numtxqueues 1
>>      RX: bytes  packets  errors  dropped overrun mcast
>>      8          1        0       0       0       0
>>      TX: bytes  packets  errors  dropped carrier collsns
>>      69         11       0       0       0       0
>>
>> I ran out of time as wanted to test a bit more as I was confused that
>> it is showing RX errors on the first test? I was not able to get it
>> back to ERROR-ACTIVE from ERROR-WARNING either. But posted result
>> anyway
>
>
> The received error messages are counted as well.
>
>>> 2. The second test is quite similar. Instead of disconnecting the cable=
,
>>> short-circuit the CAN low and high lines. The device should then go to
>>> "bus-off".
>>
>>
>> And this one:
>>
>> root@colibri-vf:~# ./candump -td -e any,0:0,#FFFFFFFF
>>   (000.000000)  can0  20000004   [8]  00 20 00 00 00 00 00 00   ERRORFRA=
ME
>> controller-problem{tx-error-passive}
>>   (000.000809)  can0  20000040   [8]  00 00 00 00 00 00 00 00   ERRORFRA=
ME
>> bus-off
>>   (000.109797)  can0  20000100   [8]  00 00 00 00 00 00 00 00   ERRORFRA=
ME
>> restarted-after-bus-off
>>   (000.100551)  can0  20000004   [8]  00 20 00 00 00 00 00 00   ERRORFRA=
ME
>> controller-problem{tx-error-passive}
>>   (000.000823)  can0  20000040   [8]  00 00 00 00 00 00 00 00   ERRORFRA=
ME
>> bus-off
>>   (000.108644)  can0  20000100   [8]  00 00 00 00 00 00 00 00   ERRORFRA=
ME
>> restarted-after-bus-off
>>   (000.090692)  can0  20000004   [8]  00 08 00 00 00 00 00 00   ERRORFRA=
ME
>> controller-problem{tx-error-warning}
>>   (000.000797)  can0  20000040   [8]  00 00 00 00 00 00 00 00   ERRORFRA=
ME
>> bus-off
>>
>> Will try again next week when I am back at the office.
>>
>> I ran my tests on 4.14 kernel.
>
>
> This Flexcan core needs the FLEXCAN_QUIRK_BROKEN_PERR_STATE as well, like
> all other cores. Adding that quirk for the vf610 will cure the problems.
>

I will probably get some time during the coming week to test adding
FLEXCAN_QUIRK_BROKEN_PERR_STATE and I can send a patch if it all looks
good.

--=20
Med V=C3=A4nliga H=C3=A4lsningar / Best Regards

Mirza Krak
