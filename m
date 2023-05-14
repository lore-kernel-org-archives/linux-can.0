Return-Path: <linux-can-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A551C77B7F
	for <linux-can@archiver.kernel.org>; Sun, 14 May 2023 17:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjENRMc (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sun, 14 May 2023 13:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjENRMa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 14 May 2023 13:12:30 -0400
X-Greylist: delayed 435 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 14 May 2023 10:12:29 PDT
Received: from mail.rdts.de (mail.rdts.de [195.243.153.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183B840C0;
        Sun, 14 May 2023 10:12:28 -0700 (PDT)
Received: from webmail.rdts.de (php1.rdts.de [82.223.13.20])
        by mail.rdts.de (Postfix) with ESMTPSA id A06F1BABA4;
        Sun, 14 May 2023 19:05:08 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sun, 14 May 2023 19:05:08 +0200
From:   Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@pengutronix.de
Subject: Re: [PATCH 17/19] can: sun4i_can: Convert to platform remove callback
 returning void
In-Reply-To: <20230512212725.143824-18-u.kleine-koenig@pengutronix.de>
References: <20230512212725.143824-1-u.kleine-koenig@pengutronix.de>
 <20230512212725.143824-18-u.kleine-koenig@pengutronix.de>
Message-ID: <e8d411e1e01f3c7ae8bf97f2f1700e3d@gerhard-bertelsmann.de>
X-Sender: info@gerhard-bertelsmann.de
User-Agent: Roundcube Webmail/1.2.3
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Am 2023-05-12 23:27, schrieb Uwe Kleine-König:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling 
> by
> returning an error code. However the value returned is ignored (apart 
> from
> emitting a warning) and this typically results in resource leaks. To 
> improve
> here there is a quest to make the remove callback return void. In the 
> first
> step of this quest all drivers are converted to .remove_new() which 
> already
> returns void. Eventually after all drivers are converted, .remove_new() 
> is
> renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>

Thanks Uwe :-)
