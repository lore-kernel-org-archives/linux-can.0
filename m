Return-Path: <linux-can-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE96C6FD1D
	for <linux-can@archiver.kernel.org>; Tue,  4 Apr 2023 12:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbjDDM7k (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 4 Apr 2023 08:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbjDDM7j (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Apr 2023 08:59:39 -0400
Received: from zeeaster.vergenet.net (zeeaster.vergenet.net [206.189.110.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C53D1722;
        Tue,  4 Apr 2023 05:59:38 -0700 (PDT)
Received: from momiji.horms.nl (2a02-a46e-7b6b-703-d63d-7eff-fe99-ac9d.fixed6.kpn.net [IPv6:2a02:a46e:7b6b:703:d63d:7eff:fe99:ac9d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by zeeaster.vergenet.net (Postfix) with ESMTPSA id E51EB200E7;
        Tue,  4 Apr 2023 12:59:06 +0000 (UTC)
Received: by momiji.horms.nl (Postfix, from userid 7100)
        id 93FE9940242; Tue,  4 Apr 2023 14:59:06 +0200 (CEST)
Date:   Tue, 4 Apr 2023 14:59:06 +0200
From:   Simon Horman <horms@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] can: CAN_BXCAN should depend on ARCH_STM32
Message-ID: <ZCwfGk2cv9d4biNR@vergenet.net>
References: <40095112efd1b2214e4223109fd9f0c6d0158a2d.1680609318.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40095112efd1b2214e4223109fd9f0c6d0158a2d.1680609318.git.geert+renesas@glider.be>
Organisation: Horms Solutions BV
X-Virus-Scanned: clamav-milter 0.103.8 at zeeaster
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, Apr 04, 2023 at 01:59:00PM +0200, Geert Uytterhoeven wrote:
> The STMicroelectronics STM32 basic extended CAN Controller (bxCAN) is
> only present on STM32 SoCs.  Hence drop the "|| OF" part from its
> dependency rule, to prevent asking the user about this driver when
> configuring a kernel without STM32 SoC support.
> 
> Fixes: f00647d8127be4d3 ("can: bxcan: add support for ST bxCAN controller")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

