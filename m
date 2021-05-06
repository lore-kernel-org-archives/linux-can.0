Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15111C43461
	for <linux-can@archiver.kernel.org>; Thu,  6 May 2021 23:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA8EE613C0
	for <linux-can@archiver.kernel.org>; Thu,  6 May 2021 23:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhEFXbO (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 6 May 2021 19:31:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232023AbhEFXbJ (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 6 May 2021 19:31:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B86A8613C5;
        Thu,  6 May 2021 23:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620343810;
        bh=x7/wx9HWRSPKx/bubp51BiTSg6K5xZJp6IGBy1QwZ6g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cNv5RTpwcaCORdDmRcX7HWzV789/KnbWU+l+30TIl6W7rLLuxLBtGbwknf8nxPXHa
         Jun2h/aQs5eK1i0BNWk3C2OG2m7rMvQPwa1Q13fechXhVeCiSGlBTT6UGV3xQLquk2
         AUvR+A4qtMUf3okHm0O+ElPAv07z+AJolgRlwKJKEze48oMssGvVvN8kSrNVBejk4E
         /eetjrjek5kGoS3XqypqDVvlaj2i4aeEyJ9Eu2asUGw1Zh/9iv+EaUq6QVRAxHMZ9c
         kDUzDAKjNt16wemdxJQI0JtNpHCyeFzhmroKJGuE4Ioj49RhPaY6gp3vuTvjh9Xc51
         D2WCehOjbSrAg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: can 2021-05-06
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162034381072.14975.11606577164704929804.git-patchwork-notify@kernel.org>
Date:   Thu, 06 May 2021 23:30:10 +0000
References: <20210506074015.1300591-1-mkl@pengutronix.de>
In-Reply-To: <20210506074015.1300591-1-mkl@pengutronix.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-can@vger.kernel.org, kernel@pengutronix.de
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (refs/heads/master):

On Thu,  6 May 2021 09:40:11 +0200 you wrote:
> Hello Jakub, hello David,
> 
> this is a pull request of 4 patches for net/master.
> 
> The first two patches target the mcp251xfd driver. Dan Carpenter's
> patch fixes a NULL pointer dereference in the probe function's error
> path. A patch by me adds the missing can_rx_offload_del() in error
> path of the probe function.
> 
> [...]

Here is the summary with links:
  - pull-request: can 2021-05-06
    https://git.kernel.org/netdev/net/c/9f3c3b423567
  - [net,2/4] can: mcp251xfd: mcp251xfd_probe(): add missing can_rx_offload_del() in error path
    https://git.kernel.org/netdev/net/c/4376ea42db8b
  - [net,3/4] can: mcp251x: fix resume from sleep before interface was brought up
    https://git.kernel.org/netdev/net/c/03c427147b2d
  - [net,4/4] can: m_can: m_can_tx_work_queue(): fix tx_skb race condition
    https://git.kernel.org/netdev/net/c/e04b2cfe6107

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


