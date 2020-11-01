Return-Path: <SRS0=QGsL=EH=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27834C2D0A3
	for <linux-can@archiver.kernel.org>; Sun,  1 Nov 2020 15:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C243D22246
	for <linux-can@archiver.kernel.org>; Sun,  1 Nov 2020 15:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="PPRZ067d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgKAPsX (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sun, 1 Nov 2020 10:48:23 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.169]:24347 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbgKAPsV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 1 Nov 2020 10:48:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1604245699;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=yAojNvsTMXwci+PgwEgeEyrFqh/svZFGBqzhQ51cJbk=;
        b=PPRZ067dYFeyXG03II9SgDM/g47z54k9IBT4HSnVoZVGAEVu3+KEFzJkfY0QCPLvDL
        IVTz426xbjVSqmnDcYIDrwQZFctLdpH0+6oXX7PguQk7IhLYxl4uKB7NVuZMj+tRb8YY
        uU9kvygoXCEt5V0/HNC3c/uKx7Mi4w94/TJnlG58/mj0mdJRvFOaCeMZrSsldqmOG8Yx
        Rbh6/hM4CnK2mv0Ip6faXZy8TV1vFaNyzXj9sTo9W9wsEI5BW7dH+mukjG+L0Panleym
        A/hIibqKY5H48+3hcUf6LUB6odyQHSLHx9W0cmEZGBrcti5Tm5uKU8crbCtEq+Gqdnpf
        Skgw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR9J8xtpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.3.0 DYNA|AUTH)
        with ESMTPSA id L010bewA1FmJ8Op
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sun, 1 Nov 2020 16:48:19 +0100 (CET)
Subject: Re: [PATCH] cangen: flush the CAN frame at each iteration
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
References: <20201101145712.489795-1-mailhol.vincent@wanadoo.fr>
 <5ecff3df-2e94-8702-3894-3fcd70364552@hartkopp.net>
Message-ID: <2ef6fb30-9fa8-99ee-39f7-e39bfb06f06c@hartkopp.net>
Date:   Sun, 1 Nov 2020 16:48:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <5ecff3df-2e94-8702-3894-3fcd70364552@hartkopp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


>> diff --git a/cangen.c b/cangen.c
>> index ab8122c..d7392b6 100644
>> --- a/cangen.c
>> +++ b/cangen.c
>> @@ -384,7 +384,7 @@ int main(int argc, char **argv)
>>       }
>>       while (running) {
>> -        frame.flags = 0;
>> +        memset(&frame, 0, sizeof(frame));
> 
> But this patch breaks everything which is not in random mode.
> 
> Analogue to frame.flags we just need to clear frame.len8_dlc

I've tagged you as author because of the great description but changed 
the code a bit ;-)

https://github.com/hartkopp/can-utils/commit/0b6af299d1b92c76447ce24f31702efb8eda02fa

Best,
Oliver

