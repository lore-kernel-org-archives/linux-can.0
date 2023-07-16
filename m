Return-Path: <linux-can-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4C1C001DE
	for <linux-can@archiver.kernel.org>; Sun, 16 Jul 2023 16:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjGPQxl (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sun, 16 Jul 2023 12:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjGPQxl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 16 Jul 2023 12:53:41 -0400
Received: from out-36.mta1.migadu.com (out-36.mta1.migadu.com [IPv6:2001:41d0:203:375::24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3021B0
        for <linux-can@vger.kernel.org>; Sun, 16 Jul 2023 09:53:39 -0700 (PDT)
Date:   Mon, 17 Jul 2023 02:52:54 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1689526417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VdPWSeimVxVz91xQpsqP4Z46tm2ZX8etDGiqC5eAjnY=;
        b=yiYIdBSpp3Qlc5Nvg8wlFK23YkICxlgjlCAvrd8CIgCqv6CfsXiwb3hjS5aITUSvSCP+t3
        dYOjilmV/3oCefCfMuCmDtkgINtnZ2uzOKaeixeM5GHFDDf8X+j6OqmED1P6L2LTwp5rJo
        Mp8cdvHwhcxzZDZ13AZtKaNLisy/CTeM45sR1j1XlzTN+bdbXllMC1ksVda53ykY/aDZGN
        Www0zvg7+ihmzePP9aGKrqkJkQ/IHRDc6o5JfaihmKDQmNBuVF3SlQIrPF1HjiLGBzm0FE
        gZpGnlDhX7rJRISWrshJSZgx/0R40tdB6bm0UZA1I4kyeZmjHHplBwSaF61xBw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   John Watts <contact@jookia.org>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, linux-riscv@lists.infradead.org,
        Fabien Poussin <fabien.poussin@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 4/4] can: sun4i_can: Correctly set acceptance registers
 on the D1
Message-ID: <ZLQgZvipHOFTlnnO@titan>
References: <20230715112523.2533742-1-contact@jookia.org>
 <20230715112523.2533742-5-contact@jookia.org>
 <4844353.31r3eYUQgx@jernej-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4844353.31r3eYUQgx@jernej-laptop>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sun, Jul 16, 2023 at 06:45:25PM +0200, Jernej Škrabec wrote:
> This patch should precede patch 3, so in next patch you add full D1 support.
> 
> Best regards,
> Jernej

That makes sense, thank you. Will change in v2.

John.
