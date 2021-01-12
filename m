Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C456C433E6
	for <linux-can@archiver.kernel.org>; Tue, 12 Jan 2021 09:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA89822DFB
	for <linux-can@archiver.kernel.org>; Tue, 12 Jan 2021 09:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389999AbhALJUi (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 12 Jan 2021 04:20:38 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.169]:36672 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732377AbhALJUi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jan 2021 04:20:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1610443066;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:From:
        Subject:Sender;
        bh=1mjQlQ48bblead7QmUHUNYxJvOehWMjF68FlUPNTbm8=;
        b=ci8ZLVpR/wlykiwRwY9GCrwrzZFxVLhxnpz9+clJ1CnxCUIwASmO35BufDKe9K1PKU
        kP0JjdBUGQBuKlEEDcAVY+S+wkJFxr9OEhdzvOPYbufsKfdC5wsHHciSxPv6Il8dkown
        m7lGrM8BLr1y4yu22E2bmff95UmUYaredb/P9g93OExt2twKBfId8SkoOiShIboDmVsp
        6aX4N3DC/7NagdIaT5J63BJiq5i5ZLg1Zk4zxULIOWUcMie9bSs2nqbL188gdKI/R1Yt
        1V/H2ZBKkXhkopEJVBxoJEB/QzMuMo4RKQSG2whIpyUg1INJCHPod9MHEG2zXkh/H7Gw
        ZlBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR9J8xty10="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.12.1 SBL|AUTH)
        with ESMTPSA id k075acx0C9HfKUx
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 12 Jan 2021 10:17:41 +0100 (CET)
Subject: Re: [PATCH] can: isotp: fix isotp_getname() leak
To:     Marc Kleine-Budde <mkl@pengutronix.de>, kuba@kernel.org,
        netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        syzbot+057884e2f453e8afebc8@syzkaller.appspotmail.com
References: <20210112090457.11262-1-socketcan@hartkopp.net>
 <6c2550bd-0e58-c300-c830-94d38b6ab7c9@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <cc5729d2-1301-6ca6-3847-f7bda9028583@hartkopp.net>
Date:   Tue, 12 Jan 2021 10:17:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <6c2550bd-0e58-c300-c830-94d38b6ab7c9@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 12.01.21 10:12, Marc Kleine-Budde wrote:
> On 1/12/21 10:04 AM, Oliver Hartkopp wrote:
>> Initialize the sockaddr_can structure to prevent a data leak to user space.
>>
>> Suggested-by: Cong Wang <xiyou.wangcong@gmail.com>
>> Reported-by: syzbot+057884e2f453e8afebc8@syzkaller.appspotmail.com
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> Can you add a Fixes: tag?

Yes, of course.

Sent out a v2 with Fixes: tag.

Best regards,
Oliver
