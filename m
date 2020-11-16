Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A4DC55ABD
	for <linux-can@archiver.kernel.org>; Mon, 16 Nov 2020 08:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9CAC221F9
	for <linux-can@archiver.kernel.org>; Mon, 16 Nov 2020 08:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0Uz/yTb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgKPIXz (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 16 Nov 2020 03:23:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:54346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbgKPIXy (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 16 Nov 2020 03:23:54 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D4DB2068E;
        Mon, 16 Nov 2020 08:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605515034;
        bh=WeaMYx0LhD683ipfnIPd+2LcKPqIwV94ziWzD8HZ5OM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0Uz/yTb0lk6URX0tSO5pH1l/ZglDAv+iHg+kr8nmPYujLm3VpgyowuBZLTfXh6XDc
         7YZ9iXfYt9Uq406wzGXxTpnuWsCPjnenMJ9oRGUdaB7KyzbbgjnHPa8bdq3A7bFncZ
         f8+i0gWG0780iVqEYv/fIGRvhg06BACUldrs/UhE=
Date:   Mon, 16 Nov 2020 16:23:48 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-can@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [net v2 1/4] ARM: dts: imx: fix can fsl,stop-mode
Message-ID: <20201116082347.GG5849@dragon>
References: <20201111130507.1560881-1-mkl@pengutronix.de>
 <20201111130507.1560881-2-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111130507.1560881-2-mkl@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Nov 11, 2020 at 02:05:04PM +0100, Marc Kleine-Budde wrote:
> Since commit:
> 
>     d9b081e3fc4b can: flexcan: remove ack_grp and ack_bit handling from driver
> 
> the 4th and 5th value of the property "fsl,stop-mode" aren't used anymore. With
> the conversion of the flexcan binding to yaml this raises the following error
> during dtbs_check:
> 
> arch/arm/boot/dts/imx6dl-apf6dev.dt.yaml: flexcan@2090000: fsl,stop-mode:0: [1, 52, 28, 16, 17] is too long
>     From schema: Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> 
> This patch fixes the error by removing the obsolete values.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Already applied a patch from Oleksij Rempel [1].

Shawn

[1] https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/commit/?h=imx/dt64&id=73db215119963918afe446c6cec76e2d421aa33c
