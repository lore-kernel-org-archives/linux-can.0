Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F7CC4361B
	for <linux-can@archiver.kernel.org>; Tue, 15 Dec 2020 21:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F0F522CB8
	for <linux-can@archiver.kernel.org>; Tue, 15 Dec 2020 21:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgLOVDH (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 15 Dec 2020 16:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbgLOVDH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Dec 2020 16:03:07 -0500
X-Greylist: delayed 129 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Dec 2020 13:02:26 PST
Received: from coruscant.sevenbyte.org (coruscant.sevenbyte.org [IPv6:2001:19f0:6c01:abf:5400:1ff:fe40:fb77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AEEC06179C
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 13:02:26 -0800 (PST)
Received: from [IPv6:2003:cd:370e:4d00:7d0:30c6:72d:ea04] (p200300cd370e4d0007d030c6072dea04.dip0.t-ipconnect.de [IPv6:2003:cd:370e:4d00:7d0:30c6:72d:ea04])
        (Authenticated sender: stefan@rumpelsepp.org)
        by coruscant.sevenbyte.org (Postfix) with ESMTPSA id EC2A83F263;
        Tue, 15 Dec 2020 22:02:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rumpelsepp.org;
        s=dkim; t=1608066145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vopymdZwo397O4iFMUZFrT/M27q/+4NEqD93sjhI7KM=;
        b=HoyceypViEdlSR4rKudHXKBStIHSrh5Q2vQs74pwiZgOslvlPX+SrUV8HRBY/TsoGcLeHp
        0rCxRi9VK7jBBkkHxZNb1WKzyNF6e5av02ziHCVHPtF0U0s41GEKb8/77q6e62i++Z7Ssl
        0ODk3McngxpNby4MtfEGh+Aq7SwpYJsjUaIFeZpDi/2VTH/qXBkv29t97c65+G0jjKp/3W
        ALsKEerj6Ab7l4ZNu4DCiE8QsKyja5tCkkBl7qecv1xSDBPLI+Nldxwu4Tvurx3tykJIlr
        lUexlDdKRwntv+UOqevyiDQiz13nwNmSC6t8W8ajqsDoBx+VxcSLEPQppSo7EF2EaSUQx5
        DVxIMuwewLVmPi9EEjST3eBeQ65UwJEcb8vPeosxdrTXX/HtIEwwoRrrI1KXdOA0dKwDrf
        GrOMca5aV2TmOH4nBRT7tR3++kEGcJ8A9hZAqpWf8MQyqT9IWOQueqqVT/7RKCYH9CE/4X
        AZd8N+RIQ3je7hpWV4OqV/2T6gK0Io8NZcBg9+Q2eLFimYNW2Lfzi3XiXZBagk1PyQcLCO
        1Fq7SbwiCmHrgJZQjN0UsVmebS2bR4i1mb6nmCSVqzD3+fabFn8ExF6HmDnpBWQKlzekOL
        3FCHGQ1uc64MlLG3Hcs6NWJYIL/miMbak0ff0RZkB2HtWqZ5kTZ64=
Message-ID: <bf1f223b500ca27636fd04d7d10a1401f5a6bf18.camel@rumpelsepp.org>
Subject: Re: pcan: usb_submit_urb() hangs in peak_usb_ndo_start_xmit()
From:   Stefan Tatschner <stefan@rumpelsepp.org>
To:     linux-can@vger.kernel.org
Cc:     ferdinand.jarisch@aisec.fraunhofer.de,
        Tobias Specht <tobias.specht@aisec.fraunhofer.de>
Date:   Tue, 15 Dec 2020 22:02:24 +0100
In-Reply-To: <ad68c4ebcdadb31cbf9fd78c9ad38b57ee9ef562.camel@rumpelsepp.org>
References: <ad68c4ebcdadb31cbf9fd78c9ad38b57ee9ef562.camel@rumpelsepp.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, 2020-12-15 at 21:59 +0100, Stefan Tatschner wrote:
> The very can frame which poc.py should send is:
>
>  25 ff

Sorry for the follow up e-mail, but this detail is important…
"25 ff" should be the very **last** can frame. The word "last" somehow
disappeared from my e-mail.^^

Stefan

