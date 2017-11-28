From: Mirza Krak <mirza.krak@gmail.com>
Subject: Re: [PATCH v2 2/2] can: flexcan: adding platform specific details for LS1021A
Date: Tue, 28 Nov 2017 23:11:35 +0100
Message-ID: <CALw8SCXqcuUn_70704TxQAZrOFMbXhhdoYap2B4AFNJYFVw3Qg@mail.gmail.com>
References: <1510307990-15418-1-git-send-email-pankaj.bansal@nxp.com>
 <AM0PR0402MB3940A4B29C67BAD85F461331F12E0@AM0PR0402MB3940.eurprd04.prod.outlook.com>
 <343d8c69-a01a-5ff7-75a2-99523391f97c@grandegger.com> <ff7b32a8bc694c92b10967bfd2de24fa@SGPMBX1017.APAC.bosch.com>
 <AM0PR0402MB394058F204ECA509D1ADB6AEF1220@AM0PR0402MB3940.eurprd04.prod.outlook.com>
 <cf35f42c513946918031b4c1cf6d8778@SGPMBX1017.APAC.bosch.com>
 <be8f51ff-8775-fe03-d299-2dc1f963ebcc@pengutronix.de> <3e201945af364c5a8a92dd6a931f4448@SGPMBX1017.APAC.bosch.com>
 <ced1aea2-144d-9bd5-8ab7-b19492512815@pengutronix.de> <CALw8SCUGuCmq+S_9-o-ZDYJuASveuj71WH97jYsEvNZX2N5ZXA@mail.gmail.com>
 <CALw8SCWNXJYuNWDtAxS9iFkKjMhcwQ60Pi7Mq3ne=k0Oynr47w@mail.gmail.com>
 <e318ca19-bb08-f537-ed7a-4f8008b9a341@grandegger.com> <CALw8SCWFDt58x6zrbnoXuX=DkG0+OZtXnCO5CdK+MQb2JyubuA@mail.gmail.com>
 <d339bdc6-49c4-3184-6fa4-12521f491f20@grandegger.com> <CALw8SCWK55Byqackx3YQ_h8c5Jo5JFLtt3-WJryHwOEtP-Rtgw@mail.gmail.com>
 <54c6924f-1aac-342e-d1f8-af175a33268e@pengutronix.de> <CALw8SCVNqN0SM1e=bxXZFMVL0VN0iy0LgFj9Hv4BeRwAbb9Y6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:34094 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbdK1WLg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 28 Nov 2017 17:11:36 -0500
Received: by mail-qt0-f181.google.com with SMTP id 33so1967569qtv.1
        for <linux-can@vger.kernel.org>; Tue, 28 Nov 2017 14:11:36 -0800 (PST)
In-Reply-To: <CALw8SCVNqN0SM1e=bxXZFMVL0VN0iy0LgFj9Hv4BeRwAbb9Y6A@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, Pankaj Bansal <pankaj.bansal@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Varun Sethi <V.Sethi@nxp.com>, Poonam Aggrwal <poonam.aggrwal@nxp.com>, Stefan Agner <stefan@agner.ch>

2017-11-28 23:09 GMT+01:00 Mirza Krak <mirza.krak@gmail.com>:
> 2017-11-27 15:00 GMT+01:00 Marc Kleine-Budde <mkl@pengutronix.de>:
>>
>> On 11/26/2017 10:11 PM, Mirza Krak wrote:
>> >>> Will try again next week when I am back at the office.
>> >>>
>> >>> I ran my tests on 4.14 kernel.
>> >>
>> >> This Flexcan core needs the FLEXCAN_QUIRK_BROKEN_PERR_STATE as well,
>> >> like
>> >> all other cores. Adding that quirk for the vf610 will cure the
>> >> problems.
>> >
>> > I will probably get some time during the coming week to test adding
>> > FLEXCAN_QUIRK_BROKEN_PERR_STATE and I can send a patch if it all looks
>> > good.
>>
>> I've created a patch, waiting for your Tested-by.
>>
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git/log/?h=
=3Dtesting
>
>
> Great thanks. I will not have access to hardware until Friday this week,
> hope you are patient :)

Grrr, stupid email client (last mail went out as HTML), sorry.

Re-send as plain-text for it to reach mailing list as well.

--=20
Med V=C3=A4nliga H=C3=A4lsningar / Best Regards

Mirza Krak
