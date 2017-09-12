From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 3/4] can: flexcan: implement error passive state quirk
Date: Tue, 12 Sep 2017 08:53:52 +0200
Message-ID: <e1a698c3-58f6-9165-ff8a-595dbee3f70c@grandegger.com>
References: <87faf67d90a246938e0b51d2ddbc8b82@SGPMBX1017.APAC.bosch.com>
 <cc678b44-0aa8-ac91-567e-8b9c234ed024@grandegger.com>
 <ad3cf1da-ca4b-6149-876a-0c983f9d48c8@grandegger.com>
 <dfb4fd69b6d0463ca565245f4c072b90@SGPMBX1017.APAC.bosch.com>
 <1685670a-c87d-2204-7e46-c36ebb8b072f@grandegger.com>
 <bf6cad90aa9d4e8da439a5ac2e21eafd@SGPMBX1017.APAC.bosch.com>
 <20820cdf-afff-9d04-3c9c-511e45bd0853@grandegger.com>
 <1ccdad7593e34103bd4d96f5b1e64ea7@SGPMBX1017.APAC.bosch.com>
 <92d997b5-957e-7e0b-70aa-bff16e289e81@grandegger.com>
 <6903931307914574bcc729ece55c0b0d@SGPMBX1017.APAC.bosch.com>
 <ea3a890e-450e-3c8b-a337-4f81bbb9c0a4@grandegger.com>
 <e878b7f3840c4a60940828a3e77d4ee7@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy03.manitu.net ([217.11.48.67]:52344 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751238AbdILGxy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Sep 2017 02:53:54 -0400
In-Reply-To: <e878b7f3840c4a60940828a3e77d4ee7@SGPMBX1017.APAC.bosch.com>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

Hello,

Am 12.09.2017 um 03:59 schrieb ZHU Yi (ST-FIR/ENG1-Zhu):
> Hello Wolfgang,
> 
>> From: Wolfgang Grandegger [mailto:wg@grandegger.com]
>> Sent: Monday, September 11, 2017 3:06 PM
>>
>> Hello ZHU Yi,
>>
>> Am 11.09.2017 um 04:29 schrieb ZHU Yi (ST-FIR/ENG1-Zhu):
>>> [...]
>>
>> The patches are fine. You can add my:
>>
>> "Acked-by: Wolfgang Grandegger <wg@grandegger.com>
> Thanks! :)
> 
>>
>>> [...]
>>
>> Could you please add the patch below for the i.MX28:
>>
>>From c8c61fd02e016ff890a9a0f672cc63790bc8a408 Mon Sep 17 00:00:00 2001
>> From: Wolfgang Grandegger <wg@grandegger.com>
>> Date: Mon, 11 Sep 2017 08:59:53 +0200
>> Subject: [PATCH] can: flexcan: fix i.MX28 state transition issue
>>
>> Enable FLEXCAN_QUIRK_BROKEN_PERR_STATE for i.MX28 to report correct
>> state transitions, especially to error passive.
>>
>> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
>> ---
>> drivers/net/can/flexcan.c | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
>> index 57b37446..c9b3a1a 100644
>> --- a/drivers/net/can/flexcan.c
>> +++ b/drivers/net/can/flexcan.c
>> @@ -285,7 +285,9 @@ static const struct flexcan_devtype_data fsl_p1010_devtype_data = {
>> 	.quirks = FLEXCAN_QUIRK_BROKEN_WERR_STATE,
>> };
>>
>> -static const struct flexcan_devtype_data fsl_imx28_devtype_data;
>> +static const struct flexcan_devtype_data fsl_imx28_devtype_data = {
>> +	.quirks = FLEXCAN_QUIRK_BROKEN_PERR_STATE,
>> +};
>>
>> static const struct flexcan_devtype_data fsl_imx6q_devtype_data = {
>> 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
>> --
>> 2.7.4
> Sure, it's done! :)
> 
>>
>> I think we should add the flag also for the "p1010", even if I have
>> only tested it on the i.MX53:
>>
>> static const struct flexcan_devtype_data fsl_p1010_devtype_data = {
>> 	.quirks = FLEXCAN_QUIRK_BROKEN_WERR_STATE,
>> };
> The WERR_STATE is already added for p1010, do you mean we should add
> the PERR_STATE to p1010 as well?

Yes, because bus error interrupt flooding may be a problem on these 
systems, especially low-end system. And WERR_STATE enables the bus error 
interrupt from the beginning.

Wolfgang.
