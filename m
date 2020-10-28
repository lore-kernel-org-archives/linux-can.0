Return-Path: <SRS0=J6wA=EE=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB8FC55179
	for <linux-can@archiver.kernel.org>; Thu, 29 Oct 2020 00:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 666C520790
	for <linux-can@archiver.kernel.org>; Thu, 29 Oct 2020 00:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603932951;
	bh=rph1tfwjeUfkNdv+Xay3vP8t7dS/JiIJ7qk/l+QZ+Dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jZlKkQXtVxoN0SAdPRFou+rjWDZ/d0B1wmQ/iQWH0ZO7CGt+XI6G9MVNdLrkAQmrF
	 G7med4KLAnTX4LTabLgTH4KdzcDwUOgQPcH5/nfo92bWC+rmcOyc3xkbI8qlrB4GE2
	 r1BX2hiAaYo6bN04yfwi4iFtf16+VxwTRzGaQ0LE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731693AbgJ2AzN (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 28 Oct 2020 20:55:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731666AbgJ1WRk (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:40 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 590CC24684;
        Wed, 28 Oct 2020 09:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603875991;
        bh=rph1tfwjeUfkNdv+Xay3vP8t7dS/JiIJ7qk/l+QZ+Dw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IE92TK+RrVXe5Rvk7gXVLRlzcD1FcnKRqIql8GwA/dQP+2KYkbXAq/6TBWTu8t6KE
         /wx/6IgBPBgfuityI29Nwfo35dGkz5n7IDr3tGJfPnXoBmYMgiR4GR1BkX6L6sEdYx
         gOKEaQbQvNl0yL3AekYPGqg53XZibDhHvbqpx+/g=
Date:   Wed, 28 Oct 2020 17:06:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH v2 2/3] arm64: dts: ls1028a: add missing CAN nodes
Message-ID: <20201028090624.GJ28755@dragon>
References: <20201001091131.30514-1-michael@walle.cc>
 <20201001091131.30514-3-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001091131.30514-3-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, Oct 01, 2020 at 11:11:30AM +0200, Michael Walle wrote:
> The LS1028A has two FlexCAN controller. These are compatible with
> the ones from the LX2160A. Add the nodes.
> 
> The first controller was tested on the Kontron sl28 board.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied, thanks.
