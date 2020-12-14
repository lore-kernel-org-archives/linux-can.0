Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87149C4361B
	for <linux-can@archiver.kernel.org>; Mon, 14 Dec 2020 09:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3118E22AAA
	for <linux-can@archiver.kernel.org>; Mon, 14 Dec 2020 09:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbgLNJfw (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 14 Dec 2020 04:35:52 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.21]:25893 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730038AbgLNJfr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 14 Dec 2020 04:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607938310;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:From:
        Subject:Sender;
        bh=JDmNgXnPMIFKiTnWYxN0lKWxmtn2zHZli6QsR/pAkEU=;
        b=Gxx3SOVlYFRiScfdrD0pDFzg0qGkReXOf2+Wum0kQHVRYQ5jTDPFvNWM8wiqy+4fWS
        1tY2TpOxiqm756pOOISw+ayz12F9Ent1ECENE4yUAfy36cji9ytu47TM2ZiWpW/1p0h5
        V8G5twSpNQFARr3YAHRNZF56lBH8ff+C0N9h2hYdodr177LIsEwaE93SlAvsHthSfa+i
        6WZ3SaOHZ4oBdhNvWhp1a66ChDD3kZMZ5TezLrmytn2iATT4kIAT678hp8xRLz01VQ8D
        XJwcFw0zw/+eCicq//6vAtimqSM9ETn6fTyc5I/joiSxe6A+BjxQn8M9hMlcdbEKFtmf
        Wvww==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR+J8xty10="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.7.1 SBL|AUTH)
        with ESMTPSA id 506da2wBE9Vo6Ni
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 14 Dec 2020 10:31:50 +0100 (CET)
Subject: Re: [can-next-rfc 1/7] can: m_can: update link to M_CAN user manual
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Sriram Dash <sriram.dash@samsung.com>
References: <20201212175518.139651-1-mkl@pengutronix.de>
 <20201212175518.139651-2-mkl@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <3b1ef62e-f61a-7445-b890-e346781a64f9@hartkopp.net>
Date:   Mon, 14 Dec 2020 10:31:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201212175518.139651-2-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 12.12.20 18:55, Marc Kleine-Budde wrote:
> Old versions of the user manual are regularly depublished, so change link to
> point to the product page instead. This will be hopefully more stable.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>   drivers/net/can/m_can/m_can.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 06c136961c7c..8873f6f6f6da 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -5,8 +5,7 @@
>   // Copyright (C) 2018-19 Texas Instruments Incorporated - http://www.ti.com/
>   
>   /* Bosch M_CAN user manual can be obtained from:
> - * http://www.bosch-semiconductors.de/media/pdf_1/ipmodules_1/m_can/
> - * mcan_users_manual_v302.pdf
> + * https://www.bosch-semiconductors.com/ip-modules/can-ip-modules/m-can/
>    */

This URL update makes it just 'a little' better.

Would it make sense to move

https://github.com/hartkopp/M_CAN-User-Manual-History

to

https://github.com/linux-can/M_CAN-User-Manual-Archive

and rework the README.md in a way that it's just an archive of already 
published content?

Regards,
Oliver
