Return-Path: <SRS0=+HsW=CZ=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FB7C2BB84
	for <linux-can@archiver.kernel.org>; Wed, 16 Sep 2020 20:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8678E206B7
	for <linux-can@archiver.kernel.org>; Wed, 16 Sep 2020 20:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prbFeWJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgIPUKI (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbgIPRdm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Sep 2020 13:33:42 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FBBC0698D7;
        Wed, 16 Sep 2020 04:45:37 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id j2so5924286eds.9;
        Wed, 16 Sep 2020 04:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V6SQ95iuYBA2VrNE4b4AFdLhxDnlqOkMOm9qPCQ2rWE=;
        b=prbFeWJsNCTyQL7UeinrkyhUUkcjHZc7OqwVlg5/ZWvpMENY5VDied43TZCXcPtC1/
         cVL6DsQ+99WQf8KgGe1/plSIpFKhgv+l8oN0LL7Qk7NSPmqi2gNkRjBiMG8sQhGemPOk
         2TTo/JDlbLZrVdiOJT2j0q3EgKMEQ9uzwcVLLRGIMTvkTW0uHI0Ux1pavFU0fUrbOU0g
         x0RCRVygH3de3a88eVKdfkgm2/gPsMSQ0rbYPtpoGag7zxRaLeasg2qVcggsF769ou6f
         AVOaL0NAMXLOPcJ28f5spa78Lep9eNgdT2GO+eQ4A0LLn0T+/ZVlJnEW3Vz4AdnNwLNc
         Xw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V6SQ95iuYBA2VrNE4b4AFdLhxDnlqOkMOm9qPCQ2rWE=;
        b=mr3s2cDjLMQdwc/qNTrEYiLScs5q9xL8yIrefNggfpeNE0QP/W8ZGEeAc2J2UHH4wm
         a/ZPMoB7ekVoS6FV9NKEcZIoyFkzvtGktE99nRFV50JLeWxsaPWMgQtzglHMa3myCiUq
         mrsxW0x3q3W/LFVhQbM+Rwsarx0d/0VyBNbUg02yr8WjzTrufVJfIcBt6xnP+AQf0K8P
         WQVqyvCfBjGb/Bkw/OXA9AK+Bb7qSTV+ckb2aiAvKeyDPrffCjIzseORosVE39+aqx+c
         qJxep5UAZ2WTWKUUHhEAchjhuiiQWqbveKdd7EJdSzk4IXz+MRYJq2QkfYPMYHXWBPXd
         1UPw==
X-Gm-Message-State: AOAM5313KZBdi46HQGRCXb4sqFpYwZZCb8g6oA5kZLcIMwixQtuRH65Z
        Q78xLT5gDIwN3phwA69C5Jk=
X-Google-Smtp-Source: ABdhPJw9pQ31c/lNE0yZuxO37Z/8pdb4x+ZxzsEdex8lsz9lyI7OfbiAiZhAxngGGgN55F3U2MOgSA==
X-Received: by 2002:a50:99d6:: with SMTP id n22mr27628762edb.265.1600256735956;
        Wed, 16 Sep 2020 04:45:35 -0700 (PDT)
Received: from skbuf ([188.25.217.212])
        by smtp.gmail.com with ESMTPSA id k1sm11823265eji.20.2020.09.16.04.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 04:45:35 -0700 (PDT)
Date:   Wed, 16 Sep 2020 14:45:33 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     wg@grandegger.com, pankaj.bansal@nxp.com,
        pankaj.bansal@oss.nxp.com, linux-can@vger.kernel.org,
        qiangqing.zhang@nxp.com, linux-kernel@vger.kernel.org,
        vladimir.oltean@nxp.com
Subject: Re: canfdtest on flexcan loopback
Message-ID: <20200916114533.3hlthhfd7xmpamoa@skbuf>
References: <VI1PR04MB4093944944C574B138371F51F12F0@VI1PR04MB4093.eurprd04.prod.outlook.com>
 <20200916110154.hp4up6yhyokduvf2@skbuf>
 <20200916110448.dsla6vjzy4fvdr22@skbuf>
 <12688d2b-a198-ef5e-dd8f-64957df36574@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12688d2b-a198-ef5e-dd8f-64957df36574@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Sep 16, 2020 at 01:32:49PM +0200, Marc Kleine-Budde wrote:
> Which driver are you using? The mainline driver only uses one TX buffer.

Are there multiple flexcan drivers in circulation? Yes, the mainline
driver with a single priv->tx_mb.

Thanks,
-Vladimir
