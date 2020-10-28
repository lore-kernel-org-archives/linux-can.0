Return-Path: <SRS0=J6wA=EE=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08306C5517A
	for <linux-can@archiver.kernel.org>; Thu, 29 Oct 2020 01:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B34120790
	for <linux-can@archiver.kernel.org>; Thu, 29 Oct 2020 01:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="juYqsNf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbgJ2BCD (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 28 Oct 2020 21:02:03 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:17810 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731082AbgJ1WNZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Oct 2020 18:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603923203;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=qvim9wN0dFhy9P/o7UAKne6od+ItXGCMkZx3GM9xQM4=;
        b=juYqsNf4Zw14Hn5C/uvI6LmJ+19oIWUePO0+SPDYARQ2lZrBEh/ZacgBaWizigpgG4
        P3IqFZespf9oGWu+/CZi2yGtSceV6srqagBV6Cu2pZE2xsCNjHLHksGF/nFt76/g33L7
        lQ2q7RW+UmCzlc/c8AvdAm/kDsuXYrb/jHlYEp09aXXUyTeRW1zOuVO5ItqJ3F3SpMsR
        yqvx3Bl44DwcuFpKI5n12LP1BIlx0pcDpZs/hy4S3stjPYKnwwGeyEbYHOAo8hei1OjS
        X+pSrx9bKSS4/Njf5bVOPnRwwxbfROzRkIIIL0GeKx0JPPJzXxEXkOPJ47d5IOdooOdK
        NoXQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR/J8xuy10="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.2.3 DYNA|AUTH)
        with ESMTPSA id J01b14w9SBDH0UJ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 28 Oct 2020 12:13:17 +0100 (CET)
Subject: Re: [PATCH 3/4] can: remove obsolete get_canfd_dlc() macro
To:     Marc Kleine-Budde <mkl@pengutronix.de>, mailhol.vincent@wanadoo.fr
Cc:     linux-can@vger.kernel.org
References: <20201028110033.113702-1-socketcan@hartkopp.net>
 <20201028110033.113702-4-socketcan@hartkopp.net>
 <57b153c5-d243-3a13-e643-1e64d60fc4df@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <80dd771b-e20b-ef3a-91d5-cdcbf1cdd1b0@hartkopp.net>
Date:   Wed, 28 Oct 2020 12:13:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <57b153c5-d243-3a13-e643-1e64d60fc4df@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 28.10.20 12:03, Marc Kleine-Budde wrote:
> On 10/28/20 12:00 PM, Oliver Hartkopp wrote:
>> The macro was always used together with can_dlc2len() which sanitizes the
>> given dlc value on its own.
>>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
>>   drivers/net/can/flexcan.c                         | 2 +-
>>   drivers/net/can/peak_canfd/peak_canfd.c           | 2 +-
>>   drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c    | 2 +-
>>   drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 2 +-
>>   drivers/net/can/usb/peak_usb/pcan_usb_fd.c        | 2 +-
>>   include/linux/can/dev.h                           | 1 -
>>   include/linux/can/dev/peak_canfd.h                | 2 +-
>>   7 files changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
>> index b30e3171cbd0..137f46705814 100644
>> --- a/drivers/net/can/flexcan.c
>> +++ b/drivers/net/can/flexcan.c
>> @@ -996,11 +996,11 @@ static struct sk_buff *flexcan_mailbox_read(struct can_rx_offload *offload,
>>   		cfd->can_id = ((reg_id >> 0) & CAN_EFF_MASK) | CAN_EFF_FLAG;
>>   	else
>>   		cfd->can_id = (reg_id >> 18) & CAN_SFF_MASK;
>>   
>>   	if (reg_ctrl & FLEXCAN_MB_CNT_EDL) {
>> -		cfd->len = can_dlc2len(get_canfd_dlc((reg_ctrl >> 16) & 0xf));
>> +		cfd->len = can_dlc2len((u8)((reg_ctrl >> 16) & 0xf));
>                                         ^^^^
> 
> where does this come from?

can_dlc2len(u8 dlc) needs an u8 and reg_ctrl is u32.

All other users of can_dlc2can already provide an u8 value to can_dlc2len().

Best,
Oliver
