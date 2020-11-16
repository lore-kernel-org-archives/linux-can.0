Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9A8C4742C
	for <linux-can@archiver.kernel.org>; Mon, 16 Nov 2020 08:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78580208C7
	for <linux-can@archiver.kernel.org>; Mon, 16 Nov 2020 08:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxbbiXzS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgKPIYS (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 16 Nov 2020 03:24:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:54414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbgKPIYS (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 16 Nov 2020 03:24:18 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB9DD2068E;
        Mon, 16 Nov 2020 08:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605515057;
        bh=0H8fIDnOgA7LmPBJ60kXLKS/bs4/I0z6S4fudgS4x1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YxbbiXzSI96Yx7lWcn/zNBIe4KPh+RUjAeY8ok4hMBggO8jetGF7pJ85ZS4T+quAZ
         bnHBOQWBvoKxfUlViH53c0eyeBce6XlhLwxls9XUy8nC5KSg7mPhdgWPGfJe7esfFu
         MUezOTREqal4izAfT7wYxCYYZ5OXw1IIt6aYrQzg=
Date:   Mon, 16 Nov 2020 16:24:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-can@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [net v2 2/4] ARM: dts: imx: Change flexcan node name to "can"
Message-ID: <20201116082411.GH5849@dragon>
References: <20201111130507.1560881-1-mkl@pengutronix.de>
 <20201111130507.1560881-3-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111130507.1560881-3-mkl@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Nov 11, 2020 at 02:05:05PM +0100, Marc Kleine-Budde wrote:
> Change i.MX SoCs nand node name from "flexcan" to "can" to be compliant with
> yaml schema, it requires the nodename to be "can". This fixes the following
> error found by dtbs_check:
> 
> arch/arm/boot/dts/imx6dl-apf6dev.dt.yaml: flexcan@2090000: $nodename:0: 'flexcan@2090000' does not match '^can(@.*)?$'
>     From schema: Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Applied, thanks.
