Return-Path: <SRS0=J6wA=EE=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52687C4363A
	for <linux-can@archiver.kernel.org>; Thu, 29 Oct 2020 01:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0484920790
	for <linux-can@archiver.kernel.org>; Thu, 29 Oct 2020 01:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603933274;
	bh=Y7763jLRt17lwaz4nUanJFjbl1LXV6RdroINVp//PO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A2O3U1MDaS1fEjyuURKNNdvgo4jTxr/caolagNCp+q4u9dpImdzHd5B79zRxrzlri
	 /LB4zMVZbEgBAmhdNtlSeJL1hn7PX711E7wkNwajZ+Ph2Kcu7+xo5n/v5K+rSAV7sP
	 l1AvI1VayNDrlN3HwZs8DBhRuyqZr8LV0yD7kW7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbgJ2BBN (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 28 Oct 2020 21:01:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731523AbgJ1WR1 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:27 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1694824688;
        Wed, 28 Oct 2020 09:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603876011;
        bh=Y7763jLRt17lwaz4nUanJFjbl1LXV6RdroINVp//PO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wcc+/hv9pLtXqFy1C9F2NgW0AxkUGNL6uKCQGsTW7svtZnTx9AapokqVgKILNRYdP
         63hwvVODKjhpn3vq2a+xqcbZycbqtSQpUoAL59c984SmioX0BtZ0bPznfCp/L7ACOS
         u+J7wh8WKYP/djWWciLxZXJ4zSXIWRgMI7Ti+mao=
Date:   Wed, 28 Oct 2020 17:06:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH v2 3/3] arm64: dts: freescale: sl28: add CAN node
Message-ID: <20201028090645.GK28755@dragon>
References: <20201001091131.30514-1-michael@walle.cc>
 <20201001091131.30514-4-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001091131.30514-4-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, Oct 01, 2020 at 11:11:31AM +0200, Michael Walle wrote:
> The module supports one CAN controller. Enable it.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied, thanks.
