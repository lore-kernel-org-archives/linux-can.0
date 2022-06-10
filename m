Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F486C43334
	for <linux-can@archiver.kernel.org>; Fri, 10 Jun 2022 22:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344998AbiFJWn6 (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 10 Jun 2022 18:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245351AbiFJWn5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 10 Jun 2022 18:43:57 -0400
Received: from mail.enpas.org (zhong.enpas.org [IPv6:2a03:4000:2:537::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31AED4BB90;
        Fri, 10 Jun 2022 15:43:55 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id BA10A10001C;
        Fri, 10 Jun 2022 22:43:53 +0000 (UTC)
Date:   Sat, 11 Jun 2022 00:43:51 +0200
From:   Max Staudt <max@enpas.org>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        netdev@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v6 0/7] can: refactoring of can-dev module and of Kbuild
Message-ID: <20220611004351.0372ca8f.max@enpas.org>
In-Reply-To: <20220610143009.323579-1-mailhol.vincent@wanadoo.fr>
References: <20220513142355.250389-1-mailhol.vincent@wanadoo.fr>
        <20220610143009.323579-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Looks good to me. Thanks Vincent for this clean-up, and thanks to
everyone involved for the discussion, reviews, and testing!

Acked-by: Max Staudt <max@enpas.org>
