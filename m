Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE783C433EF
	for <linux-can@archiver.kernel.org>; Sat, 11 Jun 2022 15:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238330AbiFKPYt (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sat, 11 Jun 2022 11:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237799AbiFKPYs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 11 Jun 2022 11:24:48 -0400
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A33DB25E99
        for <linux-can@vger.kernel.org>; Sat, 11 Jun 2022 08:24:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 3B0AC100022;
        Sat, 11 Jun 2022 15:24:46 +0000 (UTC)
Date:   Sat, 11 Jun 2022 17:24:38 +0200
From:   Max Staudt <max@enpas.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH] can: netlink: allow configuring of fixed bit rates
 without need for do_set_bittiming callback
Message-ID: <20220611172438.59ad6167.max@enpas.org>
In-Reply-To: <20220611144248.3924903-1-mkl@pengutronix.de>
References: <20220611144248.3924903-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Thank you!

As discussed, after 3 years of can327/elmcan with the dummy function, I
believe this to be thoroughly tested ;)

Tested-by: Max Staudt <max@enpas.org>
