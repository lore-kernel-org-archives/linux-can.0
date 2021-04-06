Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077C4C433ED
	for <linux-can@archiver.kernel.org>; Tue,  6 Apr 2021 23:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAFA4613BE
	for <linux-can@archiver.kernel.org>; Tue,  6 Apr 2021 23:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344357AbhDFXkT (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 6 Apr 2021 19:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245171AbhDFXkS (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 6 Apr 2021 19:40:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C2875613CB;
        Tue,  6 Apr 2021 23:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617752409;
        bh=BBDcA9mMD1hh/MHKONANE/he4s+s4XtD+s5/7mD1Ao8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iWis537+iQu3XimXPxGNo8lKq6ejoGPTLI8wL+sDYPAqnINurQGGfdiyQBRNhWUUC
         f9rkXXM9n37vKqR1y+Ta46xVfkMNlu1cK+3weLYQ8nvkfHZV3vDXX5KREnjeFuIKLE
         fFptdbR/sacJQuqzc9UjZvhV+E/gNS/LXls1mdNQeoZXI5+RbE2/1y/URGUb8F2pRp
         1gmjGUyJrk06Ae1oiF8THFk58N3Q32HdYpDDhYXKlj63sfVUZAnawO4fW0u80HRywR
         PN6PG/605SelmoJX3t05wJXaXtnidJL3+cq4s7QcWn8bCyc23i70gwxoRb8STqFGnP
         9QyUofR2z6SOA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net] can: mcp251x: fix support for half duplex SPI host controllers
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161775240975.19905.5284211796735654997.git-patchwork-notify@kernel.org>
Date:   Tue, 06 Apr 2021 23:40:09 +0000
References: <20210406103606.1847506-2-mkl@pengutronix.de>
In-Reply-To: <20210406103606.1847506-2-mkl@pengutronix.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-can@vger.kernel.org, kernel@pengutronix.de,
        tharvey@gateworks.com, info@gerhard-bertelsmann.de
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Tue,  6 Apr 2021 12:36:06 +0200 you wrote:
> Some SPI host controllers do not support full-duplex SPI transfers.
> 
> The function mcp251x_spi_trans() does a full duplex transfer. It is
> used in several places in the driver, where a TX half duplex transfer
> is sufficient.
> 
> To fix support for half duplex SPI host controllers, this patch
> introduces a new function mcp251x_spi_write() and changes all callers
> that do a TX half duplex transfer to use mcp251x_spi_write().
> 
> [...]

Here is the summary with links:
  - [net] can: mcp251x: fix support for half duplex SPI host controllers
    https://git.kernel.org/netdev/net/c/617085fca637

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


