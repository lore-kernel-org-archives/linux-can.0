Return-Path: <SRS0=tH2h=DO=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5260BC4363C
	for <linux-can@archiver.kernel.org>; Wed,  7 Oct 2020 07:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3535207EA
	for <linux-can@archiver.kernel.org>; Wed,  7 Oct 2020 07:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="gQ3i4dF/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbgJGH1D (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 7 Oct 2020 03:27:03 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:27415 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgJGH1C (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 7 Oct 2020 03:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1602055617;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=fPhLKX20KC04X1gND6ARpctoXPnL5OIA07EnZWPJq4M=;
        b=gQ3i4dF/zS3Jx4dBLoEVlw1sfMHHi9mHFD4bbBJmKSBLMQ5+iLAmsTh7EzKfTn6hfu
        iGVkShwNzqYPHlrmrlt1/1LBU8WNZrkqoUfVANdpp/UG07TklD6kWmOIMqxIFRhvhI4A
        5lbfNvDnsib2F3Vm7A6cRiIdi+F7NYrQiso7UbaujKKBS5VD9EBYxwVYpJk5fwPUi+69
        kRDKttojbOy86fAryl/Y/jkLq7s0nfDfvAmSKYbdBV838ayFwLxq1+/ZFKfOYEa7KceO
        gzKjYmq9FqFOmYU8gbzqbvrsY1oX7rECbdDEgyHBvuO2U6nQWr00ZzX0GmRYwzLQ7HbC
        JDjQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR/J89ozF0="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.2.1 DYNA|AUTH)
        with ESMTPSA id D0b41cw977QuC3X
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 7 Oct 2020 09:26:56 +0200 (CEST)
Subject: Re: [PATCH can-next] can: add ISO 15765-2:2016 transport protocol
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     netdev@vger.kernel.org
References: <20200928200404.82229-1-socketcan@hartkopp.net>
 <2cadd37a-bfca-097b-a957-864298b104f9@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <57739126-2f8a-ea82-49b3-94e396c2fd21@hartkopp.net>
Date:   Wed, 7 Oct 2020 09:26:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <2cadd37a-bfca-097b-a957-864298b104f9@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 06.10.20 22:27, Marc Kleine-Budde wrote:
> On 9/28/20 10:04 PM, Oliver Hartkopp wrote:
>> CAN Transport Protocols offer support for segmented Point-to-Point
>> communication between CAN nodes via two defined CAN Identifiers.
>> As CAN frames can only transport a small amount of data bytes
>> (max. 8 bytes for 'classic' CAN and max. 64 bytes for CAN FD) this
>> segmentation is needed to transport longer PDUs as needed e.g. for
>> vehicle diagnosis (UDS, ISO 14229) or IP-over-CAN traffic.
>> This protocol driver implements data transfers according to
>> ISO 15765-2:2016 for 'classic' CAN and CAN FD frame types.
>>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> Applied to linux-can-next with some changes:
> 
>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>> new file mode 100644
>> index 000000000000..efed3e47b6ee
>> --- /dev/null
>> +++ b/net/can/isotp.c
>> @@ -0,0 +1,1428 @@
>> +// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> 
> Removed the syscall note, as it's only ment for header files. See:
> 
>      d77cd7fefc0d can: remove "WITH Linux-syscall-note" fro
>                        SPDX tag of C files
> 

Oh, my bad. I was working on Linus' tree when creating the patch and 
missed that cleanup I acked myself m(

> Further I've fixes some indention, a checkpatch warning and some typos.

Thanks! I did not get the point with the (id) macro - now it's clear ;-)

Best,
Oliver
