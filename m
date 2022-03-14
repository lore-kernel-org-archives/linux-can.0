Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6238C433F5
	for <linux-can@archiver.kernel.org>; Mon, 14 Mar 2022 13:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236350AbiCNNET (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 14 Mar 2022 09:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiCNNET (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 14 Mar 2022 09:04:19 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C4B2BC8;
        Mon, 14 Mar 2022 06:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=sZGCWDh0dfZ+WLDvLb/SCotSw5Z7sq0gZZDxSTkfyJo=;
  b=fbq7d3sCUpERkXkj8lEkFFwZhvtPpyB6uiTLBhL/3Gt9IccehSvO7YZ6
   2bm/d2XdrHaIEMdFLEUG7C5x1PmbMJ9nLezz+kaCvFDfuQvyPOCrSpEEq
   6B4zaFZUvtvqoiJNjH1x5r6OgT0kGVUAwn3wXOYIGzj5tafxGl606BVWK
   c=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,180,1643670000"; 
   d="scan'208";a="26014036"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 14:03:02 +0100
Date:   Mon, 14 Mar 2022 14:03:01 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     Marc Kleine-Budde <mkl@pengutronix.de>
cc:     Wolfgang Grandegger <wg@grandegger.com>,
        kernel-janitors@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 27/30] can: ucan: fix typos in comments
In-Reply-To: <20220314120502.kpc27kzk2dnou2td@pengutronix.de>
Message-ID: <alpine.DEB.2.22.394.2203141402480.2561@hadrien>
References: <20220314115354.144023-1-Julia.Lawall@inria.fr> <20220314115354.144023-28-Julia.Lawall@inria.fr> <20220314120502.kpc27kzk2dnou2td@pengutronix.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On Mon, 14 Mar 2022, Marc Kleine-Budde wrote:

> On 14.03.2022 12:53:51, Julia Lawall wrote:
> > Various spelling mistakes in comments.
> > Detected with the help of Coccinelle.
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
>
> Should I take this, or are you going to upstream this?

You can take it.

thanks,
julia

>
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
>
