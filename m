Return-Path: <SRS0=J6wA=EE=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FAFC55178
	for <linux-can@archiver.kernel.org>; Thu, 29 Oct 2020 12:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 136D42075E
	for <linux-can@archiver.kernel.org>; Thu, 29 Oct 2020 12:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="HmZ3pjwc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbgJ2Mui (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 29 Oct 2020 08:50:38 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:8897 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ2Mui (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 29 Oct 2020 08:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603975836;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=GcHUJfei2GHynRT17Eet1qyKbECdbytUxM+xcX/GzT0=;
        b=HmZ3pjwcke/8JwJP85N0WzJhkwM7gACFbkN33leN7BjGjZorrlLggqCnlfcQUgOsWh
        6+uRgLSilEAiPKFi2Q3lDdtpIIdh8BHDr+vAu9lZEmzIB54QDpYrskvg3B45EZmRFbJb
        omIjCM4Ob9HA80YbBO5xwj0qyfKx1DH/tSzbljq6/3s67uXkBszTPhlvYuJuiOXVppQp
        E0uYhbBgIP0fUCMCnCgDANRgOEkBCb4RqZBPGLnWbLdTETsJZXe2f4+pcf49hbb9lk1E
        eWPqV3OzmbnV7yAwtZFAa8TM8iHt3g/mpU8cMccFnOIEyXszrzmNNHBVuHoz5XJkec0U
        lfoQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVNiOM1ppw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.3.0 DYNA|AUTH)
        with ESMTPSA id L010bew9TCoY1kA
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 29 Oct 2020 13:50:34 +0100 (CET)
Subject: Re: [PATCH testing-only] can-dev: implement len8_dlc in some CAN USB
 adapters for testing
To:     Marc Kleine-Budde <mkl@pengutronix.de>, mailhol.vincent@wanadoo.fr
Cc:     linux-can@vger.kernel.org
References: <20201029083258.41569-1-socketcan@hartkopp.net>
 <d58008e9-3e07-73b4-27bb-ac5eeebacc0f@hartkopp.net>
 <8818b66d-a986-fb7a-b80b-985ec0d750f5@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <7a370719-09d0-0191-7d46-6932cebee746@hartkopp.net>
Date:   Thu, 29 Oct 2020 13:50:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <8818b66d-a986-fb7a-b80b-985ec0d750f5@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 29.10.20 10:56, Marc Kleine-Budde wrote:
> On 10/29/20 10:50 AM, Oliver Hartkopp wrote:
>> Info: usb8dev and gs_usb work as expected.
> 
> Which gs_usb are you using? The original one, or the candelight?

The "original candelight" from Hubert :-)

Best,
Oliver
