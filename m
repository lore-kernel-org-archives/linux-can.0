Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B193DC49EA7
	for <linux-can@archiver.kernel.org>; Thu, 24 Jun 2021 18:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B323610A2
	for <linux-can@archiver.kernel.org>; Thu, 24 Jun 2021 18:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbhFXScb (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 24 Jun 2021 14:32:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232666AbhFXScY (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 24 Jun 2021 14:32:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3ABB6610A2;
        Thu, 24 Jun 2021 18:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624559405;
        bh=6r3D+w9wSai1i5AYKCkavmXfX1NiggGUJIFxg+8gjIg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ksKlS+xh3NmM8FYKf/pJiHmk+RPykfHpg6Tc2DC+QBAeO7PezbfDnkS9oKvffEjb5
         4rEhsiL4U5smTgUsBNSRZ9b6Ah6PR9ZpvxnIRWFVewH1atQeYTIxjDI274UMJvBrx4
         B6Yo/U2fdHavJZ+MWihH9Ye5YSn4DCCDKzySxkkcwVmgu8KBWVvNlnqoSTPsG/TbmB
         7rbv16EkuH5olBnseLlW9aqr2zMbtDn4Wm9BI9mecboHadH/pd5j3cLJnIBx2icUMx
         iZXygiMWpybwP5yj57ZBAbTV6mmtvQiQRZIosV/ZivH0MwxDPV201bgbcv+zAlQYHk
         iVgeeCqKT0oeg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: can 2021-06-24
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162455940514.3292.1536393943631339193.git-patchwork-notify@kernel.org>
Date:   Thu, 24 Jun 2021 18:30:05 +0000
References: <20210624064200.2998085-1-mkl@pengutronix.de>
In-Reply-To: <20210624064200.2998085-1-mkl@pengutronix.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-can@vger.kernel.org, kernel@pengutronix.de
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (refs/heads/master):

On Thu, 24 Jun 2021 08:41:58 +0200 you wrote:
> Hello Jakub, hello David,
> 
> this is a pull request of 2 patches for net/master.
> 
> The first patch is by Norbert Slusarek and prevent allocation of
> filter for optlen == 0 in the j1939 CAN protocol.
> 
> [...]

Here is the summary with links:
  - pull-request: can 2021-06-24
    https://git.kernel.org/netdev/net/c/abe90454f075

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


