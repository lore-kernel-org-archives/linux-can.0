Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (unknown [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803A8C433E9
	for <linux-can@archiver.kernel.org>; Sun, 21 Mar 2021 02:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D480261968
	for <linux-can@archiver.kernel.org>; Sun, 21 Mar 2021 02:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhCUCLk (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sat, 20 Mar 2021 22:11:40 -0400
Received: from [198.145.29.99] ([198.145.29.99]:50912 "EHLO mail.kernel.org"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S230014AbhCUCLH (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sat, 20 Mar 2021 22:11:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D58DE6194C;
        Sun, 21 Mar 2021 02:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616292608;
        bh=ii0hhmDiWoJrsDyEsa5R+c4c2PK3zuX8YCpsV7ZteZ8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FZFY/HRuX/57ji52zIfPJq39nWagaID0MoMeoKbHP+B3WZHaC+VXdNqkGHdjYfFB/
         SpE98h8Ct6dH3O61ObTNWhktyeDjOz1e6qyrYZPW/vKwAIVXqkfw7vqbfqAdhuhSUB
         fWsMBR18PjlosPSNpujuMni+dgXp+7Sx8/lNSE6polJpPV/mTM8gM6QawYY6ZyVTG+
         obzVjAOofC7NYIXMuWdvK1z1w+cRW1qBA6Y9cXlQICHD0auzbaBw75HwCCwUO6KR3U
         tit/olS6gajGnaB/RavilDA/JnTQ7iYhv0s4j7DJweXGaqjF9NrVXVm4v0e6++aQDo
         XHUuu9ofjJd6w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: can 2021-03-20
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161629260880.5230.14283916005008635768.git-patchwork-notify@kernel.org>
Date:   Sun, 21 Mar 2021 02:10:08 +0000
References: <20210320193708.348503-1-mkl@pengutronix.de>
In-Reply-To: <20210320193708.348503-1-mkl@pengutronix.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-can@vger.kernel.org, kernel@pengutronix.de
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (refs/heads/master):

On Sat, 20 Mar 2021 20:37:06 +0100 you wrote:
> Hello Jakub, hello David,
> 
> this is a pull request of 2 patches for net/master.
> 
> The first patch is by Oliver Hartkopp. He fixes the TX-path in the
> ISO-TP protocol by properly initializing the outgoing CAN frames.
> 
> [...]

Here is the summary with links:
  - pull-request: can 2021-03-20
    https://git.kernel.org/netdev/net/c/49371a8a66ac
  - [net,2/2] can: peak_usb: Revert "can: peak_usb: add forgotten supported devices"
    https://git.kernel.org/netdev/net/c/5d7047ed6b72

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


