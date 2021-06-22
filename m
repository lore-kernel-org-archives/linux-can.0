Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8898C2B9F4
	for <linux-can@archiver.kernel.org>; Tue, 22 Jun 2021 08:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ED046113D
	for <linux-can@archiver.kernel.org>; Tue, 22 Jun 2021 08:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhFVI7I (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 22 Jun 2021 04:59:08 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:19956 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhFVI7H (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Jun 2021 04:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1624352206;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:To:Subject:Cc:Date:From:
    Subject:Sender;
    bh=zGEVrsTTCWzMwNYwWBsBblrPNk3weTfBnqwsZNGVsqg=;
    b=ED27S89Xk/BUgZcZn/sBGHFrhaE4RvGO3fk7JxdBcZqAzLntlfZ9L1M55b+nOFSaj2
    CyD5VAOfN+767wWGCl/0YwLvW6LLGLEHWKGpS9lsNWmOAnqcqK6wm665hRL4dmrQn6sJ
    PTm8N+cxuDTgcmetBmWVTaHreb1RsTqd0AWbsRd9KO2d7T8AMKRe6ItCoSaY/tst8HRy
    HqgiLPGojBxaxnUzEQAWMzPUYd1PapmRvdwiEsg5uyHUg+cP31vxjgykx2fZ40nyOUQj
    uoABdT6r2C5t6XgO8zKS45neV7YS5/X7f7WNANE/GTLtVgVom5yAkAWiqR8C0g+a0bhG
    SqaQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR9J8xozF0="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
    by smtp.strato.de (RZmta 47.27.4 DYNA|AUTH)
    with ESMTPSA id 9083dfx5M8uj2xf
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 22 Jun 2021 10:56:45 +0200 (CEST)
Subject: Re: LIN (ISO 17987)
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>,
        Pavel Pisa <pisa@cmp.felk.cvut.cz>
References: <20210622082539.hdm57g3auvtmiyxc@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <22a87fe9-3abd-b90a-0b5e-1c9e4ee920f5@hartkopp.net>
Date:   Tue, 22 Jun 2021 10:56:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210622082539.hdm57g3auvtmiyxc@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Marc,

On 22.06.21 10:25, Marc Kleine-Budde wrote:
> Hello CAN community,
> 
> has anyone experience with a LIN stack for Linux? Can you recommend one?
> 

there was an off-list discussion in February where I would like to share 
the latest reply.

In https://github.com/ppisa/linux-lin there's a bunch of URLs which 
points to a LIN implementation and documentation based on SocketCAN with 
LIN netdevices.

Best,
Oliver


On 21.02.21 19:54, Pavel Pisa wrote:
 > Hello Christoph and Oliver,
 >
 > On Sunday 21 of February 2021 18:05:45 Christoph Fritz wrote:
 >>   I would like to see a LIN implementation upstream in the Linux kernel,
 >> I'm eager to help. A friend of mine is working for a car company and may
 >> fund me a bit.
 >>
 >> So here I am asking for your opinion. What do you think about mainline
 >> LIN support? Do you consider sllin's approach ready for mainline
 >> (especially the CAN API and tty buffer requirement)?
 >
 > I am not sure if CAN API is a best approach but it worked, so it
 > is such integrated CAN to LIN gateway. I am not sure if it
 > should target drivers/net/can and considered rock stable API,
 > but I think that pushing it to staging would help when there
 > are users.
 >
 > My latest version is at
 >
 >    https://github.com/ppisa/linux-lin
 >
 > I have separated line discipline for master and slave
 > mode to allows both types to be registered easily.
 > It would be great if official slattach can add parameter
 > to select discipline number, then we do not need to
 > provide separate utility.
 >
 >> At first I thought about using an integrated chip like SJA1124 and
 >> writing a small driver (UIO + userland for example). Oliver's point was
 >> that it could use the already existing CAN API into userland as sllin is
 >> doing.
 >
 > The SJA1124 is probably more robust but RT with SPI on Linux
 > would cause probably even longer latencies than slLIN.
 > I suggest to use RT preempt kernels. The main limitation
 > of slLIN on UART is than in slave mode it cannot adjust
 > bitrate according to the frame start synchronization.
 > The timely response for slave on slLIN requires sound UART
 > and RT preempt. I did not finish reading of SJA1124 doc
 > if it support slave cache. For master mode, it seems that
 > slLIN is good enough. Problem is FIFO Rc trigger level
 > control. There should be unified API for this option control
 > for all UARTs. If slLIN gets at least into staging then there
 > is argument to start this proposal.
 >
 >> A beta character device driver like PEAK has for its products is pretty
 >> sure nothing to get adopted upstream:
 >> https://forum.peak-system.com/viewforum.php?f=237
 >> Still it's interesting and maybe an inspiration for the slave mode.
