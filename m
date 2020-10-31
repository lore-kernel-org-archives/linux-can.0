Return-Path: <SRS0=iaBb=EG=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF94C388F7
	for <linux-can@archiver.kernel.org>; Sat, 31 Oct 2020 08:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6906F2074F
	for <linux-can@archiver.kernel.org>; Sat, 31 Oct 2020 08:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604133330;
	bh=osrJmoKas3X+pScT/xkIaBdNgBNjTA4rl7LpNScNfCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fUQatF0Lf8mHd8vmnG3SNXlqsI0bZYx43puBFF9aAzistKTuxKGI7QrOsG9tk5tdn
	 UA0JJwLfim/plDdaiA/hSMpzmn0DODmTvudzP9PflSW52kogrcj/ZdN7A9Zzq6y6FQ
	 YT5zTqa52BU7hDgtBiygNhyEzBT7cBuIvcSctW0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgJaIdh (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sat, 31 Oct 2020 04:33:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgJaIdT (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sat, 31 Oct 2020 04:33:19 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89C7E2074F;
        Sat, 31 Oct 2020 08:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604133199;
        bh=osrJmoKas3X+pScT/xkIaBdNgBNjTA4rl7LpNScNfCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bBaqg5tKSOK1U1z/HOF3Eni4YFUBUxlJloJxusm28kEyKzihXDTpTOA1C7yqkjqOi
         4Gx3TgUGse2+JNbXJ1vxL7q4zRwHYyio6rf1plcWBOCziBoRjl5qbrSzv8zulYmY2u
         5HJGzOZF4vvO9rZpR/+SC3TlyByNnItxdA2dB7iU=
Date:   Sat, 31 Oct 2020 16:33:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     mkl@pengutronix.de, Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: Re: [PATCH v1] ARM: dts: imx6/7: sync fsl,stop-mode with current
 flexcan driver
Message-ID: <20201031083312.GV28755@dragon>
References: <20201016075158.31574-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016075158.31574-1-o.rempel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Oct 16, 2020 at 09:51:58AM +0200, Oleksij Rempel wrote:
> After this patch we need 2 arguments less for the fsl,stop-mode
> property:
> 
> | commit d9b081e3fc4bdc33e672dcb7bb256394909432fc
> | Author: Marc Kleine-Budde <mkl@pengutronix.de>
> | Date:   Sun Jun 14 21:09:20 2020 +0200
> |
> | can: flexcan: remove ack_grp and ack_bit handling from driver
> |
> | Since commit:
> |
> |  048e3a34a2e7 can: flexcan: poll MCR_LPM_ACK instead of GPR ACK for stop mode acknowledgment
> |
> | the driver polls the IP core's internal bit MCR[LPM_ACK] as stop mode
> | acknowledge and not the acknowledgment on chip level.
> |
> | This means the 4th and 5th value of the property "fsl,stop-mode" isn't used
> | anymore. This patch removes the used "ack_gpr" and "ack_bit" from the driver.
> 
> This patch removes the two last arguments, as they are not needed
> anymore.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
>  # Please enter the commit message for your changes. Lines starting

It shouldn't be here.

Fixed it up and applied the patch.

Shawn
