Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BAFC433FE
	for <linux-can@archiver.kernel.org>; Tue,  4 Oct 2022 18:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJDSoR (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 4 Oct 2022 14:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJDSoR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Oct 2022 14:44:17 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC9B65646
        for <linux-can@vger.kernel.org>; Tue,  4 Oct 2022 11:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1664909052;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=TffA7LRMSJocpLbpD+OJYRx12+JiX7ekejUVblMhYmw=;
    b=AUWu8Ir2wyNo4t/Vwaw+rTp/BX+xkq4tjjbvRtX4UPXqmz9/sTwxFlJPBKZQgXYAak
    fhmrceZA8M9yzhqii+R2sIhmOLgDZJNUAX59ddcG0fw39SH095gM0M2LG6CIg6PJMi2G
    FxokXb0tuD8u+gK0MkXSGy3mpY77y8E2uvnyVQmyg6HyhaOErccrypziIsk6GTplJB9x
    oDRqf56Aa5ISy95Rye+wkTflFkcw67xluZ++0+P0POxdZZTv9+MGXXn/oT9of78eVgV6
    5qhabVRLv6J9P482ijl9c28fFX1f7wB+FdcL5Knod2edIYZurCl+d366fYAxHCOcPpa/
    I4KQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr6hfz3Vg=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::923]
    by smtp.strato.de (RZmta 48.1.3 AUTH)
    with ESMTPSA id Y52aa0y94IiCDWu
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 4 Oct 2022 20:44:12 +0200 (CEST)
Message-ID: <23216e28-49be-6461-9525-1faad3d439a7@hartkopp.net>
Date:   Tue, 4 Oct 2022 20:44:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFC can-next] can: remove obsolete PCH CAN driver
Content-Language: en-US
To:     Jacob Kroon <jacob.kroon@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Dario Binacchi <dariobin@libero.it>,
        Wolfgang Grandegger <wg@grandegger.com>
References: <20220924174424.86541-1-socketcan@hartkopp.net>
 <f9b37775-edd5-2a5b-18bc-b34bb69b8324@gmail.com>
 <20220926082526.ofoderi7wrpyolff@pengutronix.de>
 <1653bdae-2ed0-7cc4-993e-cae922f1c524@gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <1653bdae-2ed0-7cc4-993e-cae922f1c524@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

now that net-next is closed for the merge window would you consider this 
removal for the next can-next phase or is this something that can be 
still applied after the merge window to 6.1-rc1?

Best regards,
Oliver

On 26.09.22 10:55, Jacob Kroon wrote:
> On 9/26/22 10:25, Marc Kleine-Budde wrote:
>> On 24.09.2022 22:24:07, Jacob Kroon wrote:
>>> On 9/24/22 19:44, Oliver Hartkopp wrote:
>>>> The PCH CAN driver is a driver for a Bosch C_CAN controller IP core 
>>>> which
>>>> is attached to the system via PCI. This code has been introduced in 
>>>> 2011
>>>> by Oki Semiconductors developers to support the Intel Atom E6xx series
>>>> I/O Hub (aka EG20T IOH PCH CAN). Since 2012 the driver only has been
>>>> maintained by the kernel community.
>>>>
>>>> As there is a well maintained and continously tested C_CAN/D_CAN driver
>>>> which also supports the PCI configuration from the PCH CAN EG20T setup
>>>> this driver became obsolete.
>>>>
>>>> Cc: Jacob Kroon <jacob.kroon@gmail.com>
>>>> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
>>>> Cc: Dario Binacchi <dariobin@libero.it>
>>>> Cc: Wolfgang Grandegger <wg@grandegger.com>
>>>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>>> ---
>>>>    drivers/net/can/Kconfig       |    8 -
>>>>    drivers/net/can/Makefile      |    1 -
>>>>    drivers/net/can/c_can/Kconfig |    3 +-
>>>>    drivers/net/can/pch_can.c     | 1249 
>>>> ---------------------------------
>>>>    4 files changed, 2 insertions(+), 1259 deletions(-)
>>>>    delete mode 100644 drivers/net/can/pch_can.c
>>>>
>>>
>>> Given that the current PCH driver will lockup on my system I'm all for
>>> removing it.
>>
>> Should I add your Acked-by?
>>
> 
> Although I doubt my name carries any weight in this context, yes feel 
> free to do so.
> 
> Jacob
