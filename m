Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A2FC433EF
	for <linux-can@archiver.kernel.org>; Tue, 17 May 2022 00:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiEQAKT (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 16 May 2022 20:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiEQAKS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 16 May 2022 20:10:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8291AAE5D;
        Mon, 16 May 2022 17:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F3F6B816C0;
        Tue, 17 May 2022 00:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C53DBC34113;
        Tue, 17 May 2022 00:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652746213;
        bh=3LVa8vcpAQgFXgHvz/vLsd3jXAh8tFy4NgZsuUmLOJI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Oth4UeGB9dWVJyr1Wu6u2wD3h4divcCxiq3KRj/hW7kBJT+GEd9rCpeq9/h3B5D9T
         Kj3D2rLfFBnNeBqNZHHbGk86a0k5OCkr0HRIAcgV0OWOnK80O0R7nKxCxXz0IxlJQU
         RmiBtDB+ImOu7LlqtagveTUgJ3HztoJWPkM+oST8JCANPkRC1lZiysHJnUiQneqnVo
         H++ZMl0CjDC/IpE9eGBPZ6uPrgzHpJWom2I2cEVuoDeSVBt1amO/BemQw2oCPAGstK
         0N/k17bpOhuQEopzwzY2NKgs6kANOdHEif3l1DQ6jSekgAop9BqoU3cj/6rfVuv9ek
         eWzk0vt4eT+QA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A3B89F0392C;
        Tue, 17 May 2022 00:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/9] can: raw: raw_sendmsg(): remove not needed
 setting of skb->sk
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165274621366.23967.2797136297179359891.git-patchwork-notify@kernel.org>
Date:   Tue, 17 May 2022 00:10:13 +0000
References: <20220516202625.1129281-2-mkl@pengutronix.de>
In-Reply-To: <20220516202625.1129281-2-mkl@pengutronix.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-can@vger.kernel.org, kernel@pengutronix.de,
        socketcan@hartkopp.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (master)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Mon, 16 May 2022 22:26:17 +0200 you wrote:
> The skb in raw_sendmsg() is allocated with sock_alloc_send_skb(),
> which subsequently calls sock_alloc_send_pskb() -> skb_set_owner_w(),
> which assigns "skb->sk = sk".
> 
> This patch removes the not needed setting of skb->sk.
> 
> Link: https://lore.kernel.org/all/20220502091946.1916211-2-mkl@pengutronix.de
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] can: raw: raw_sendmsg(): remove not needed setting of skb->sk
    https://git.kernel.org/netdev/net-next/c/2af84932b3a1
  - [net-next,2/9] can: raw: add support for SO_TXTIME/SCM_TXTIME
    https://git.kernel.org/netdev/net-next/c/51a0d5e51178
  - [net-next,3/9] can: isotp: add support for transmission without flow control
    https://git.kernel.org/netdev/net-next/c/9f39d36530e5
  - [net-next,4/9] can: isotp: isotp_bind(): return -EINVAL on incorrect CAN ID formatting
    https://git.kernel.org/netdev/net-next/c/2aa39889c463
  - [net-next,5/9] can: ctucanfd: Let users select instead of depend on CAN_CTUCANFD
    https://git.kernel.org/netdev/net-next/c/94737ef56b61
  - [net-next,6/9] can: slcan: slc_xmit(): use can_dropped_invalid_skb() instead of manual check
    https://git.kernel.org/netdev/net-next/c/30abc9291329
  - [net-next,7/9] dt-bindings: can: renesas,rcar-canfd: Make interrupt-names required
    https://git.kernel.org/netdev/net-next/c/48b171dbf7b6
  - [net-next,8/9] dt-bindings: can: ctucanfd: include common CAN controller bindings
    https://git.kernel.org/netdev/net-next/c/14e1e9338c08
  - [net-next,9/9] docs: ctucanfd: Use 'kernel-figure' directive instead of 'figure'
    https://git.kernel.org/netdev/net-next/c/ba3e2eaef1ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


