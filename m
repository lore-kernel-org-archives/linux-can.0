From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 3/4] can: flexcan: implement error passive state quirk
Date: Thu, 7 Sep 2017 20:17:17 +0200
Message-ID: <20820cdf-afff-9d04-3c9c-511e45bd0853@grandegger.com>
References: <87faf67d90a246938e0b51d2ddbc8b82@SGPMBX1017.APAC.bosch.com>
 <cc678b44-0aa8-ac91-567e-8b9c234ed024@grandegger.com>
 <ad3cf1da-ca4b-6149-876a-0c983f9d48c8@grandegger.com>
 <dfb4fd69b6d0463ca565245f4c072b90@SGPMBX1017.APAC.bosch.com>
 <1685670a-c87d-2204-7e46-c36ebb8b072f@grandegger.com>
 <bf6cad90aa9d4e8da439a5ac2e21eafd@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy02.manitu.net ([217.11.48.66]:48576 "EHLO
        mailproxy02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755524AbdIGSRT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 7 Sep 2017 14:17:19 -0400
In-Reply-To: <bf6cad90aa9d4e8da439a5ac2e21eafd@SGPMBX1017.APAC.bosch.com>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

Hello ZHU Yi,

Am 07.09.2017 um 10:11 schrieb ZHU Yi (ST-FIR/ENG1-Zhu):
> Hello Wolfgang,
> 
>> From: Wolfgang Grandegger [mailto:wg@grandegger.com]
>> Sent: Thursday, September 07, 2017 3:27 PM
>>
>> [snip]
>>>> I need here:
>>>>
>>>> 	    (priv->devtype_data->quirks & (FLEXCAN_QUIRK_BROKEN_PERR_STATE |
>>>> 					   FLEXCAN_QUIRK_BROKEN_WERR_STATE)) &&
>>>>
>>>> Or maybe better, add FLEXCAN_QUIRK_BROKEN_PERR_STATE to the legacy cores
>>>> as well.
>> [snip]
>>> If we add the WERR_STATE here, the pros is the old core will automatic
>>> take advantage of this change, the cons is the quirks do not need to
>>> match the exact hardware feature, which may lead to a bit chaos IMHO.
>>
>> Well, it's not always possible to make it right for all hardware
>> variants. People will speak up in case of problems.
> Agree.
> 
>>
>>> What do you think?
>>
>> I would set FLEXCAN_QUIRK_BROKEN_PERR_STATE for the legacy cores as
>> well. I have an i.MX28 board here as well. It should not need the
>> quirks. Will test it later this week.
> Great! According to i.MX28's datasheet, the guess is it should need
> the FLEXCAN_QUIRK_BROKEN_PERR_STATE enabled as well as i.MX6.
> I'm looking forward to the results and hope it works! :)

Yes, it needs:

static const struct flexcan_devtype_data fsl_imx28_devtype_data = {
	.quirks = FLEXCAN_QUIRK_BROKEN_PERR_STATE,
};

Error warning is always reported and with the quirk above also error
passive. After reconnecting the cable the error counter also jumps to
135. With bus-off, the device also reports 3->0 after bus error
recovery:

[  674.862816] flexcan 80032000.can can0: ctrl=0x11aac53 reg_iflag=0x0 reg_esr=0x24252 err=138/1
[  674.871542] flexcan 80032000.can can0: state 0->2 ctrl
[  674.877038] flexcan 80032000.can can0: ctrl=0x11aac53 reg_iflag=0x0 reg_esr=0x4034 err=0/0
[  674.885837] flexcan 80032000.can can0: state 2->3 ctrl
root@m28evk:~# [  674.985897] flexcan 80032000.can can0: ctrl=0x11aa053 reg_iflag=0x0 reg_esr=0x4 err=0/0
[  674.994090] flexcan 80032000.can can0: state 3->0 ctrl

That was missing on the i.MX53.

Wolfgang.
