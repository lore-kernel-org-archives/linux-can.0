Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFB4C388F9
	for <linux-can@archiver.kernel.org>; Wed, 11 Nov 2020 10:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E145C20756
	for <linux-can@archiver.kernel.org>; Wed, 11 Nov 2020 10:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgKKKWQ (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 11 Nov 2020 05:22:16 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:42899 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgKKKWP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 Nov 2020 05:22:15 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id CB853FF1DB
        for <linux-can@vger.kernel.org>; Wed, 11 Nov 2020 10:22:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NU8_m7nQyThR for <linux-can@vger.kernel.org>;
        Wed, 11 Nov 2020 11:22:12 +0100 (CET)
Subject: Re: [PATCH 09/17] can: ems_usb: For CPC-USB/FD added clock
 definitions, bittiming constants, set_bittiming functions, bittiming init
 function and add all that to probe function
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     wg@grandegger.com
References: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
 <20201106170206.32162-10-uttenthaler@ems-wuensche.com>
 <e10bf6e4-559a-176b-904c-a7a5f5933f2b@pengutronix.de>
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Message-ID: <0427c0ae-8495-4adc-0945-3ca131c3caac@ems-wuensche.com>
Date:   Wed, 11 Nov 2020 11:22:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <e10bf6e4-559a-176b-904c-a7a5f5933f2b@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Am 06.11.20 um 18:51 schrieb Marc Kleine-Budde:
> On 11/6/20 6:01 PM, Gerhard Uttenthaler wrote:
>> Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
>> ---
>>  drivers/net/can/usb/ems_usb.c | 141 +++++++++++++++++++++++++++++++++-
>>  1 file changed, 139 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
>> index 6a9ea6a4e687..d6b52b265536 100644
>> --- a/drivers/net/can/usb/ems_usb.c
>> +++ b/drivers/net/can/usb/ems_usb.c
>> @@ -108,6 +108,17 @@ MODULE_LICENSE("GPL v2");
>>   */
>>  #define EMS_USB_ARM7_CLOCK 8000000
>>  
>> +/* CPC-USB/FD supports the following CAN clocks
>> + */
>> +#define EMS_USB_FD_8MHZ   8000000
>                           ^^^ one space only
I can do that, no problem, but is it really better readable?

>> +#define EMS_USB_FD_16MHZ 16000000
>> +#define EMS_USB_FD_20MHZ 20000000
>> +#define EMS_USB_FD_24MHZ 24000000
>> +#define EMS_USB_FD_32MHZ 32000000
>> +#define EMS_USB_FD_40MHZ 40000000
>> +#define EMS_USB_FD_80MHZ 80000000
> 
> are these used?
These frequencies are supported by the interface. I gave them as a
reference only, if someone wants to compile it for a different clock.
Used is:
#define EMS_USB_FD_CLOCK EMS_USB_FD_40MHZ

-- 
Gerhard

-- 
EMS Dr. Thomas Wuensche e.K.
Sonnenhang 3
85304 Ilmmuenster
HR Ingolstadt, HRA 170106

Phone: +49-8441-490260
Fax  : +49-8441-81860
http://www.ems-wuensche.com
